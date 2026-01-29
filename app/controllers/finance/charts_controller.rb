class Finance::ChartsController < ApplicationController
  def index
  end

  def draft
  	@draft_stats = Biz::Draft.for_finance(current_user).group_by_day(:created_at, last: 7).count
  end

  def order
  	@order_stats = Biz::Order.for_finance(current_user).group_by_day(:created_at, last: 7).count
  end
end
