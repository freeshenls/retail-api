# config/initializers/view_component.rb
ActiveSupport.on_load(:view_component) do
  include Heroicons::Helper
end
