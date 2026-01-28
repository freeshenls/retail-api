import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview"]

  connect() {
    // 检查 target 是否连接成功
    if (this.hasPreviewTarget) {
      console.log("预览组件已连接")
    } else {
      console.warn("未找到预览目标元素")
    }
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
