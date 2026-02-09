import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["roleName", "hiddenInput"];

  selectRole(event) {
    // 1. 核心修复点：这里解构的变量名必须和 HTML 中的 data-*-desc-param 一致
    const { id, desc } = event.params; 
    
    // 如果你之前的 HTML 里写的是 desc-param，这里就要用 desc
    // 检查一下：你的 HTML 里现在是 data-admin--invite-index-component-desc-param
    
    // 2. 更新显示文字
    if (this.hasRoleNameTarget) {
      this.roleNameTarget.innerText = desc;
    }
    
    // 3. 更新隐藏域的值（用于表单提交）
    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = id;
    }
    
    // 4. 关闭下拉框
    const dropdown = this.application.getControllerForElementAndIdentifier(this.element.closest('[data-controller~="dropdown"]'), "dropdown");
    if (dropdown) {
      dropdown.toggle();
    }
  }
}
