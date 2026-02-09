# app/components/admin/category_new_component.rb
class Admin::CategoryNewComponent < ViewComponent::Base
  # 增加这个 initialize 方法
  def initialize(category:)
    @category = category
  end
end
