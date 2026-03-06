# config/initializers/view_component.rb
ActiveSupport.on_load(:view_component) do
  # 1. 引入 Heroicons 辅助方法
  include Heroicons::Helper
  
  # 2. 引入路由（建议用这个，更全面）
  include Rails.application.routes.url_helpers
end