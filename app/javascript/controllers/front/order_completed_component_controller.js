// app/javascript/controllers/designer/order_completed_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // 页面加载后的逻辑
    console.log("设计师已提交订单列表已加载")
  }

  // 可以在这里添加如预览文件等交互
}
