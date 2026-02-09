import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["roleName", "hiddenInput"]

  selectRole(event) {
    const { id, desc } = event.params

    if (this.hasRoleNameTarget) {
      this.roleNameTarget.innerText = desc
    }

    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = id
    }

    // 自动寻找并关闭最近的 dropdown 控制器
    const dropdownContainer = this.element.closest('[data-controller~="dropdown"]')
    if (dropdownContainer) {
      const dropdown = this.application.getControllerForElementAndIdentifier(dropdownContainer, "dropdown")
      if (dropdown) dropdown.toggle()
    }
  }
}
