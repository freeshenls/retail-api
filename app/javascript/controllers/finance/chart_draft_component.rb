# app/components/finance/chart_draft_component.rb
class Finance::ChartDraftComponent < ViewComponent::Base
  def initialize(stats: {})
    @stats = stats
  end

  def chart_data
    {
      # 格式化日期：将 2026-01-29 这种 Date 对象转为 "01-29"
      labels: @stats.keys.map { |date| date.strftime("%m-%d") },
      datasets: [{
        label: '上传稿件',
        data: @stats.values,
        borderColor: '#f97316',
        backgroundColor: 'rgba(249, 115, 22, 0.1)',
        borderWidth: 3,
        fill: true,
        tension: 0.4,
        pointRadius: 4,
        pointBackgroundColor: '#fff',
        pointHoverRadius: 6
      }]
    }
  end
end
