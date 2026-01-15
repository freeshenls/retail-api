// app/javascript/controllers/layout/navbar_component_controller.js
import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"

export default class extends Controller {
  static targets = ["dropdown"]

  logout(event) {
    Cookies.remove('tabs')
  }

  handleItemClick(event) {
    if (location.href == event.currentTarget.href) {
      event.preventDefault()
    }
  }

  toggleDropdown(event) {
    event.stopPropagation()
    this.dropdownTarget.classList.toggle("hidden")
  }

  hideDropdown(event) {
    // 逻辑：如果点击的是组件外部，则隐藏下拉框
    if (!this.element.contains(event.target)) {
      this.dropdownTarget.classList.add("hidden")
    }
  }
}
