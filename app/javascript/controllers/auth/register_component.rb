class Auth::RegisterComponent < ViewComponent::Base

  def initialize(resource:, resource_name:, url:, link_path:)
    @resource = resource
    @resource_name = resource_name
    @url = url
    @link_path = link_path
    
    @title = "注册"
    @button_text = "注册"
    @link_text = "已有账号？"
    @link_label = "立即登录"
  end
end