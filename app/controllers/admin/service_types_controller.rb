class Admin::ServiceTypesController < ApplicationController
  before_action :set_service_type, only: [:edit, :update, :destroy]

  def index
    # 基础查询
    query = Biz::Unit.includes(:category).order(:service_type, "biz_category.position")

    # 1. 服务项目筛选 (模糊匹配)
    if params[:service_type].present?
      query = query.where("service_type LIKE ?", "%#{params[:service_type]}%")
    end

    # 2. 规格类型筛选 (精确匹配)
    if params[:category_id].present?
      query = query.where(category_id: params[:category_id])
    end

    # 分页处理
    @pagy, @service_types = pagy(query, limit: 5)
  end

  def new
    @service_type = Biz::Unit.new
  end

  def create
    @service_type = Biz::Unit.new(service_type_params)
    if @service_type.save
      redirect_to admin_service_types_path, notice: "服务定价已创建"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @service_type.update(service_type_params)
      redirect_to admin_service_types_path, notice: "定价信息已更新"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service_type.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@service_type)) }
      format.html { redirect_to admin_service_types_path, notice: "定价项已删除" }
    end
  end

  private

  def set_service_type
    @service_type = Biz::Unit.find(params[:id])
  end

  def service_type_params
    params.require(:biz_unit).permit(:service_type, :category_id, :price, :currency, :status)
  end
end
