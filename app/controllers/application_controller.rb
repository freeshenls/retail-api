class ApplicationController < ActionController::Base
  include Pagy::Method

  before_action :set_pagy_locale
  before_action :set_cookie_tabs

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def after_sign_in_path_for(resource)
    flash.delete(:notice)
    super
  end

  def set_pagy_locale
    Pagy::I18n.locale = "zh-CN"
  end

  def set_cookie_tabs
    raw_tabs = cookies[:tabs]
    
    # 2. 安全解析：处理 nil 或 非法 JSON 格式
    @cookie_tabs = begin
      if raw_tabs.present?
        JSON.parse(Rack::Utils.unescape(raw_tabs))
      else
        []
      end
    rescue JSON::ParserError, TypeError
      [] # 如果 Cookie 损坏，返回空数组
    end

    # 3. 数据转换：确保每一项都是 Hash 且处理 Active 状态
    @cookie_tabs = @cookie_tabs.map do |item|
      path = item["path"]
      {
        label: item["label"],
        path: path,
        active: request.path == path || params[:current] == path,
        closable: [true, "true"].include?(item["closable"])
      }
    end
  end
end
