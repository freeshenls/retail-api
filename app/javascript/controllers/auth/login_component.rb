# app/components/auth/login_component.rb
class Auth::LoginComponent < ViewComponent::Base

  def initialize(resource:, resource_name:, url:, link_path:)
    @resource = resource
    @resource_name = resource_name
    @url = url
    @link_path = link_path
    
    # 登录页特定文案
    @title = "登录"
    @button_text = "登录"
    @link_text = "还没有账号？"
    @link_label = "立即注册"
  end
end
