class Layout::TabsController < ApplicationController
  def refresh
    render turbo_stream: turbo_stream.update("tabs", Layout::TabSwitcherComponent.new(tabs: @cookie_tabs))
  end
end
