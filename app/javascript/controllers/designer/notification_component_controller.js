// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel", "title"]
  // 这里设置你想要的选中样式：品牌蓝、光圈、轻微放大
  static classes = ["activeTab"] 

  connect() {
    // 页面加载时，根据第一个按钮的状态初始化
    const firstTab = this.tabTargets[0]
    const secondTab = this.tabTargets[1]

    if (firstTab) {
      if (Number(firstTab.dataset.count) == 0) {
        if (secondTab && Number(secondTab.dataset.count) != 0) {
          this.showTab(secondTab.dataset.id, secondTab.dataset.title)
          return
        }
      }
      this.showTab(firstTab.dataset.id, firstTab.dataset.title)
    }
  }

  change(event) {
    const id = event.currentTarget.dataset.id
    const title = event.currentTarget.dataset.title
    this.showTab(id, title)
  }

  showTab(id, titleText) {
    // 1. 切换内容面板
    this.panelTargets.forEach(panel => {
      panel.classList.toggle("hidden", panel.dataset.id !== id)
    })

    // 2. 切换呼吸孔样式
    this.tabTargets.forEach(tab => {
      const isActive = tab.dataset.id === id
      // 动态切换你定义的 data-tabs-active-tab-class
      tab.classList.toggle(...this.activeTabClasses, isActive)
      
      // 如果未选中，确保它是默认的浅灰色；选中则移除默认灰色
      if (isActive) {
        tab.classList.remove("bg-slate-200")
        tab.classList.add("bg-[#0066b3]") // 确保选中是品牌蓝
      } else {
        tab.classList.add("bg-slate-200")
        tab.classList.remove("bg-[#0066b3]")
      }
    })

    // 3. 动态更新标题文字
    if (this.hasTitleTarget && titleText) {
      this.titleTarget.textContent = titleText
    }
  }
}
