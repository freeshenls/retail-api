class Layout::SidebarComponent < ViewComponent::Base

  def initialize(items: [], submenus: [], title: "菜单导航", icon: nil)
    @items = items
    @submenus = submenus
    @title = title
    @icon = icon
  end
end
