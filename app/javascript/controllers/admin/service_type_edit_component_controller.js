import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["labelName", "hiddenInput"]

  // 通用的选择处理逻辑
  selectItem(event) {
    event.preventDefault()

    const { id, name } = event.params
    
    // 1. 更新 UI 和 隐藏域
    if (this.hasLabelNameTarget) this.labelNameTarget.innerText = name
    if (this.hasHiddenInputTarget) this.hiddenInputTarget.value = id

    // 2. 调用成功经验：手动关闭下拉框
    const dropdownElement = this.element.closest('[data-controller~="dropdown"]')
    if (dropdownElement) {
      const dropdownController = this.application.getControllerForElementAndIdentifier(
        dropdownElement,
        "dropdown"
      )
      if (dropdownController) {
        dropdownController.toggle()
      }
    }
  }
}
