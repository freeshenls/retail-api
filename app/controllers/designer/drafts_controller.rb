# app/controllers/designer/drafts_controller.rb
class Designer::DraftsController < ApplicationController
  before_action :set_draft, only: [:show]

  def index
    query = Biz::Draft.with_attached_file.where(user: current_user)

    if params[:search].present?
      query = query.where("name like ?", "%#{params[:search]}%")
    end

    # v43 新写法：必须显式指定 :offset (或者 :countish, :keyset 等)
    @pagy, @drafts = pagy(:offset, query.order(upload_time: :desc), limit: 5)
  end

  def new
    @draft = Biz::Draft.new
  end

  def create
    @draft = Biz::Draft.new(draft_params)
    @draft.user = current_user

    if @draft.save
      redirect_to new_designer_draft_path, notice: "稿件上传成功！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_draft
    @draft = Biz::Draft.find(params[:id])
  end

  def draft_params
    # 匹配 Migration 中的字段名 :name
    params.require(:biz_draft).permit(:name, :file)
  end
end
