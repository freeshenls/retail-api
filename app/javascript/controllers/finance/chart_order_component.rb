# app/javascript/controllers/finance/chart_order_component.rb
class Finance::ChartOrderComponent < ViewComponent::Base
  def initialize(stats:)
    @stats = stats
  end

  def chart_data
	  {
	    labels: @stats.keys.map { |d| d.strftime("%m/%d") },
	    datasets: [{
	      label: "成交量",
	      data: @stats.values,
	      borderColor: "#3b82f6",           # 核心蓝色线
	      backgroundColor: "rgba(59, 130, 246, 0.1)", # 浅蓝色背景填充
	      borderWidth: 3,
	      fill: true,
	      tension: 0.4,
	      pointBorderColor: "#3b82f6"       # 圆点边框颜色
	    }]
	  }
	end
end
