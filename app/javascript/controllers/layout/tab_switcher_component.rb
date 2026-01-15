class Layout::TabSwitcherComponent < ViewComponent::Base

  def initialize(tabs: [])
    # tabs 格式: [{ label: "首页", path: "/", active: true, closable: false }]
    @tabs = tabs
  end
end
