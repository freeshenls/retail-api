// app/javascript/controllers/finance/chart_draft_component_controller.js
import Chartjs from '@stimulus-components/chartjs'

export default class extends Chartjs {
  connect() {
    super.connect()
    // 这里可以访问 this.chart 获取 Chart.js 实例进行二次操作
    console.log('图表已加载', this.chart)
  }
}
