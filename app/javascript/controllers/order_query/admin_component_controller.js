// app/javascript/controllers/order_query/admin_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["customerInput", "userInput", "searchDisplay"]

  // 这里的参数格式要匹配 HTML 中的 data-common--order-index-component-xxx-param
  quickSelect(event) {
    const { type, id, name } = event.params
    
    // 1. 清空隐藏域
    this.customerInputTarget.value = ""
    this.userInputTarget.value = ""

    // 2. 赋值
    if (type === "customer") {
      this.customerInputTarget.value = id
      this.searchDisplayTarget.innerText = `👤 客户: ${name}`
    } else {
      this.userInputTarget.value = id
      this.searchDisplayTarget.innerText = `👔 员工: ${name}`
    }
  }
}
