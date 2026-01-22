// app/javascript/controllers/layout/tab_init_controller.js
import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"
import { TurboUtil } from "controllers/util/turbo_util"

export default class extends Controller {
  static values = {
    label: String,
    path: String,
    closable: { type: Boolean, default: true } // 显式定义为 Boolean
  }

  connect() {
    this.syncTab()
  }

  syncTab() {
    const label = this.labelValue
    const path = this.pathValue
    // ✅ 修复点：必须使用 this.closableValue 访问，不能直接写 closable
    const closable = this.closableValue 

    let tabs = []
    try {
      tabs = JSON.parse(Cookies.get('tabs') || '[]')
    } catch (e) {
      tabs = []
    }
    
    const exists = tabs.some(item => item.path === path)

    if (!exists) {
      // 插入时使用上面获取到的 closable 变量
      tabs.push({ label: label, path: path, closable: closable })
      Cookies.set('tabs', JSON.stringify(tabs)) // 建议加上 path: '/'
      
      TurboUtil.refreshTabSwitcher(path)
    } else {
      TurboUtil.refreshTabSwitcher(path)
    }
  }
}
