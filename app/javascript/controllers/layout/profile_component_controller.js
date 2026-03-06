import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview", "tab", "panel"]
  static classes = ["activeTab"] 

  connect() {
    // 检查 target 是否连接成功
    if (this.hasPreviewTarget) {
      console.log("预览组件已连接")
    } else {
      console.warn("未找到预览目标元素")
    }
  }

  changeTab(event) {
    let id = event.target.dataset.id
    // 1. 切换内容面板
    this.panelTargets.forEach(panel => {
      panel.classList.toggle("hidden", panel.dataset.id !== id)
    })

    this.tabTargets.forEach(tab => {
      tab.classList.toggle("border-transparent", tab.dataset.id !== id)
    })
  }

  previewImage(event) {
    const file = event.target.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = (e) => {
      if (this.hasPreviewTarget) {
        // 直接替换内容，确保预览生效
        this.previewTarget.innerHTML = `
          <img src="${e.target.result}" class="w-full h-full object-cover">
        `
      }
    }
    reader.readAsDataURL(file)
  }
}
