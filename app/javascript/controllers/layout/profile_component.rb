# app/components/designer/profile_component.rb
class Layout::ProfileComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
    # 提取关联客户（基于你的 Seeds 数据）
    @customers = @user.customers
  end

  # 辅助方法：格式化加入时间
  def joined_date
    @user.created_at.strftime("%Y-%m-%d")
  end
end
