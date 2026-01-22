# app/models/biz/draft.rb
class Biz::Draft < ApplicationRecord
  belongs_to :user, class_name: "Sys::User"
  has_one :order, class_name: "Biz::Order"
  
  # Active Storage 附件
  has_one_attached :file

  before_save :sync_file_info, if: -> { attachment_changes.key?("file") }

  # 校验
  validates :file, presence: true

  def sync_file_info
    # 关键点：从 attachment_changes 中直接抓取即将保存的 blob 对象
    # 这样不会触发 Active Storage 的重置逻辑或提前读取流
    blob = attachment_changes["file"].attachment.blob
    
    # 同步元数据到业务字段
    self.name = blob.filename.to_s
    self.file_path = blob.key
    self.file_type = blob.content_type
    self.upload_time = Time.current
  end
end