import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 定义对应的 Target
  static targets = ["hiddenInput", "labelName"]

  // 选择规格时的动作
  selectCategory(event) {
    // 获取通过 data-admin--service-type-index-component-id-param 传进来的值
    const id = event.params.id
    const name = event.params.name

    // 1. 给隐藏的 input 赋值
    this.hiddenInputTarget.value = id
    
    // 2. 更新按钮显示的规格名称
    this.labelNameTarget.innerText = name

    // 3. 自动提交表单进行筛选
    // 寻找最近的 form 元素并触发 Turbo 提交
    this.element.closest('form').requestSubmit()
  }
}
