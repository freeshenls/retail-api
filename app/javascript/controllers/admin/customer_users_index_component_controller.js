// app/javascript/controllers/admin/customer_users_index_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "selectedUserName", "userHiddenInput"]

  // 1. 左侧列表：切换 Active 高亮及箭头
  setActive(e) {
    const links = this.listTarget.querySelectorAll('a')
    
    links.forEach(link => {
      // 【核心修正】：使用 classList.remove/add 而不是直接重写 className
      // 这样就不会把用于搜索过滤的 'hidden' 类给删掉了
      link.classList.remove('bg-[#0066b3]/5', 'border-[#0066b3]/20', 'shadow-sm')
      link.classList.add('border-transparent', 'text-slate-600')
      
      const name = link.querySelector('.name-text')
      if (name) {
        name.classList.remove('text-[#0066b3]')
        name.classList.add('text-slate-700')
      }
      
      const chevron = link.querySelector('.chevron')
      if (chevron) chevron.classList.add('hidden')
    })

    // 给当前点击项加高亮
    const el = e.currentTarget
    el.classList.remove('border-transparent', 'text-slate-600')
    el.classList.add('bg-[#0066b3]/5', 'border-[#0066b3]/20', 'shadow-sm')
    
    const currentName = el.querySelector('.name-text')
    if (currentName) {
      currentName.classList.add('text-[#0066b3]')
      currentName.classList.remove('text-slate-700')
    }
    
    const currentChevron = el.querySelector('.chevron')
    if (currentChevron) currentChevron.classList.remove('hidden')
  }

  // 2. 右上角：选择员工逻辑（复刻邀请码页：占位符变正文）
  selectUser(e) {
    const { id, name } = e.params
    const label = this.selectedUserNameTarget

    // 1. 更新 UI 样式（保持和你邀请码页一致）
    label.textContent = name
    label.classList.remove('text-slate-400')
    label.classList.add('text-slate-700', 'font-bold')

    // 2. 写入隐藏域
    this.userHiddenInputTarget.value = id

    // 3. 【核心修正】：手动关闭下拉菜单
    // 我们找到触发点击的按钮所属的 dropdown 控制器并隐藏它
    const dropdownElement = e.target.closest('[data-controller="dropdown"]')
    if (dropdownElement) {
      // 触发一个自定义事件，或者如果你的 dropdown 控制器支持，直接操作 DOM
      // 最通用的做法是给 document 发一个点击信号，触发 dropdown 的 click@window->dropdown#hide
      document.dispatchEvent(new MouseEvent('click', {
        view: window,
        bubbles: true,
        cancelable: true
      }))
    }
  }

  // 3. 左侧：实时搜索过滤
  filter(e) {
    const query = e.target.value.toLowerCase()
    this.listTarget.querySelectorAll('[data-filter-value]').forEach(item => {
      const match = item.dataset.filterValue.toLowerCase().includes(query)
      item.classList.toggle('hidden', !match)
    })
  }
}
