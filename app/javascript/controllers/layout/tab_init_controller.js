// app/javascript/controllers/layout/tab_init_controller.js
import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"
import { TurboUtil } from "controllers/util/turbo_util"

export default class extends Controller {
  static values = {
    label: String,
    path: String
  }

  connect() {
    this.syncTab()
  }

  syncTab() {
    const label = this.labelValue
    const path = this.pathValue

    // 获取当前 Cookie 中的 tabs
    let tabs = JSON.parse(Cookies.get('tabs') || '[]')
    
    // 检查是否已经存在该路径
    const exists = tabs.some(item => item.path === path)

    if (!exists) {
      // 如果不存在，插入新标签
      tabs.push({ label: label, path: path, closable: true })
      Cookies.set('tabs', JSON.stringify(tabs))
      
      // 调用你定义的 TurboUtil 同步后端视图
      TurboUtil.refreshTabSwitcher(path)
    } else {
      // 如果已存在，仅触发一次刷新以确保 Tabbar 的“高亮状态”与当前页面匹配
      // 这解决了：点击侧边栏已存在的 Tab，但 Tabbar 需要切换 Active 样式的问题
      TurboUtil.refreshTabSwitcher(path)
    }
  }
}
