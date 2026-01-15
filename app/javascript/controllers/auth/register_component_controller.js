// app/components/auth/register_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "password" ]

  togglePassword() {
    const input = this.passwordTarget
    input.type = input.type === "password" ? "text" : "password"
  }
}
