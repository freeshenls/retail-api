import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "fileName"]

  // 处理文件选择
  handleFileChange(event) {
    const file = event.target.files[0]
    if (file) {
      this.fileNameTarget.innerText = file.name
      this.previewTarget.classList.remove("hidden")
    }
  }

  // 处理移除文件
  removeFile(event) {
    // 1. 核心：阻止事件冒泡，防止触发下层的 file input 弹窗
    event.preventDefault()
    event.stopPropagation()

    // 2. 清空 input 的值
    this.inputTarget.value = ""

    // 3. 隐藏预览区
    this.previewTarget.classList.add("hidden")
  }
}
