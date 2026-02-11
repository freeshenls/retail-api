class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    # 按 position 排序
    query = Biz::Category.order(position: :asc)
    @pagy, @categories = pagy(:offset, query, limit: 5)
  end

  def new
    @category = Biz::Category.new
  end

  def create
    @category = Biz::Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "规格 [#{@category.name}] 已成功创建"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "规格信息已更新"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@category)) }
      format.html { redirect_to admin_categories_path, notice: "规格已删除" }
    end
  end

  private

  def set_category
    @category = Biz::Category.find(params[:id])
  end

  def category_params
    params.require(:biz_category).permit(:name, :position)
  end
end
