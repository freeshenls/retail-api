import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"
import { TurboUtil } from "controllers/util/turbo_util"

export default class extends Controller {
  static targets = ["container"]

  handleItemClick(event) {
    const isCollapsed = this.containerTarget.getAttribute('data-collapsed') === "true"
    if (isCollapsed) {
      event.preventDefault()
      event.stopPropagation()
      this.toggleSidebar()
    }

    const label = event.currentTarget.dataset.label
    const path = event.currentTarget.pathname

    let tabs = JSON.parse(Cookies.get('tabs') || '[]')
    if (!tabs.map(item => item.path).includes(path)) {
      tabs.push({ label: label, path: path, closable: true })
      Cookies.set('tabs', JSON.stringify(tabs))
      
      TurboUtil.refreshTabSwitcher(path)
    }
  }

  toggleSidebar() {
    const isCollapsed = this.containerTarget.getAttribute('data-collapsed') === "true"
    if (isCollapsed) {
      this.containerTarget.classList.replace('w-16', 'w-64')
      this.containerTarget.setAttribute('data-collapsed', "false")
    } else {
      this.containerTarget.classList.replace('w-64', 'w-16')
      this.containerTarget.setAttribute('data-collapsed', "true")
    }
  }

  toggleSubmenu(event) {
    if (this.containerTarget.getAttribute('data-collapsed') === "true") {
      this.toggleSidebar()
      return
    }

    const menuId = event.params.menuId
    const submenu = document.getElementById(menuId)
    const arrow = document.getElementById(`arrow_${menuId}`)

    if (!submenu) return

    if (submenu.style.display === "none" || submenu.style.display === "") {
      submenu.style.display = "block"
      if (arrow) arrow.style.transform = "rotate(90deg)"
    } else {
      submenu.style.display = "none"
      if (arrow) arrow.style.transform = "rotate(0deg)"
    }
  }
}
