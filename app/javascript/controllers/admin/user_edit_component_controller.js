// app/javascript/controllers/admin/user_edit_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["roleName", "hiddenInput"]

  selectRole(event) {
    event.preventDefault() // 防止意外行为
    console.log("选中角色事件触发:", event.params) // 调试用

    const { id, desc } = event.params

    if (this.hasRoleNameTarget) {
      this.roleNameTarget.innerText = desc
    }

    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = id
    }

    // 自动关闭下拉框
    const dropdownController = this.application.getControllerForElementAndIdentifier(
      this.element.closest('[data-controller~="dropdown"]'), 
      "dropdown"
    )
    if (dropdownController) {
      dropdownController.toggle()
    }
  }
}
