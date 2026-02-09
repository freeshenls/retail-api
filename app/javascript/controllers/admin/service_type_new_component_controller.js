import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["labelName", "hiddenInput"]

  selectCategory(event) {
    event.preventDefault()

    // 1. 获取参数 (确保 HTML 里的 param 名字是 id 和 name)
    const { id, name } = event.params

    // 2. 赋值
    if (this.hasLabelNameTarget) {
      this.labelNameTarget.innerText = name
    }

    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = id
    }

    // 3. 复制成功经验：手动获取 dropdown 控制器并关闭
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
