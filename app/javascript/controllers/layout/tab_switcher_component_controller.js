import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"
import { TurboUtil } from "controllers/util/turbo_util"

export default class extends Controller {
  // 当点击标签链接时，立即切换前端高亮，提升响应感
  activateTab(event) {
    this._deactivateAll()
    const tabItem = event.currentTarget.closest('[id^="tab_"]')
    if (tabItem) this._markActive(tabItem)
  }

  closeTab(event) {
    event.preventDefault()
    
    const btn = event.currentTarget
    const pathToRemove = btn.dataset.path
    const currentPath = location.pathname

    let tabs = JSON.parse(Cookies.get('tabs') || '[]')
    Cookies.set('tabs', JSON.stringify(tabs.filter(item => item.path != pathToRemove)))

    let nextPath = currentPath
    if (pathToRemove == currentPath) {
      Turbo.visit(tabs[0].path)
    }else{
      TurboUtil.refreshTabSwitcher(currentPath)
    }
  }

  _deactivateAll() {
    this.element.querySelectorAll('[id^="tab_"]').forEach(el => {
      el.classList.remove('bg-slate-50', 'border-slate-200', 'border-b-white', 'text-blue-600', 'z-10')
      el.classList.add('bg-transparent', 'border-transparent', 'text-slate-500')
      const line = el.querySelector('.absolute'); if(line) line.remove()
    })
  }

  _markActive(el) {
    el.classList.add('bg-slate-50', 'border-slate-200', 'border-b-white', 'text-blue-600', 'z-10')
    el.classList.remove('bg-transparent', 'border-transparent', 'text-slate-500')
    const line = document.createElement('div')
    line.className = 'absolute -bottom-px left-0 right-0 h-px bg-slate-50'
    el.appendChild(line)
  }
}
