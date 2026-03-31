import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"

export default class extends Controller {
  // 定义 Value，自动关联 HTML 中的 data-*-id-value
  static values = { id: String }

  handleDelete(event) {
    const orderId = this.idValue
    
    // 1. 读取当前的 tabs cookie
    const currentTabs = Cookies.get('tabs')
    Cookies.set('tabs', JSON.stringify(JSON.parse(currentTabs).filter(item => item.path != location.pathname)))
  }
}
