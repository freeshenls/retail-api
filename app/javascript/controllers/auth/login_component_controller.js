// app/components/auth/login_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "password" ]

  togglePassword() {
    this.passwordTarget.type = this.passwordTarget.type === "password" ? "text" : "password"
  }
}
