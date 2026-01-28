class Layout::NavbarComponent < ViewComponent::Base
  renders_one :notification
  
  def initialize(user_name:, avatar:, role:, nav_items:)
    @user_name = user_name
    @avatar = avatar
    @role = role
    @nav_items = nav_items
  end

  # 修改这个方法，确保它能识别配置里的 active: true
  def is_active?(item)
    # 1. 如果配置里明确写了 active: true，直接返回 true
    return true if item[:active] == true
    
    # 2. 否则，再尝试根据路径判断（防止路径为 nil 或 "#" 报错）
    begin
      return false if item[:path].blank? || item[:path] == "#"
      helpers.current_page?(item[:path])
    rescue
      false
    end
  end
end
