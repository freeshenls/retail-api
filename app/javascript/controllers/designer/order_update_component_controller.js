import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "quantity", "unitPrice", "deliveryFee", "amountDisplay",
    "customerIdInput", "customerNameText",
    "serviceTypeInput", "serviceTypeText",
    "categoryIdInput", "categoryText",
    "paymentMethodInput", "paymentMethodText",
    "unitIdInput"
  ]
  static values = { units: Array }

  connect() {
    this.calculate()
    this.matchUnit()
  }

  // 1. 客户选择
  selectCustomer(e) {
    const { id, name } = e.currentTarget.dataset
    this.customerIdInputTarget.value = id
    this.customerNameTextTarget.textContent = name
    this._closeDropdown(e)
  }

  // 2. 服务项目选择
  selectService(e) {
    const val = e.currentTarget.dataset.value
    this.serviceTypeInputTarget.value = val
    this.serviceTypeTextTarget.textContent = val
    this.matchUnit()
    this._closeDropdown(e)
  }

  // 3. 规格选择
  selectCategory(e) {
    const { id, name } = e.currentTarget.dataset
    this.categoryIdInputTarget.value = id
    this.categoryTextTarget.textContent = name
    this.matchUnit()
    this._closeDropdown(e)
  }

  // 4. 付款方式选择
  selectPayment(e) {
    const val = e.currentTarget.dataset.value
    this.paymentMethodInputTarget.value = val
    this.paymentMethodTextTarget.textContent = val
    this._closeDropdown(e)
  }

  // 联动逻辑：根据服务+规格从 JSON 中匹配单价
  matchUnit() {
    const sType = this.serviceTypeInputTarget.value
    const cId = parseInt(this.categoryIdInputTarget.value)
    
    const unit = this.unitsValue.find(u => 
      u.service_type === sType && u.category_id === cId
    )

    if (unit) {
      this.unitPriceTarget.value = unit.price
      this.unitIdInputTarget.value = unit.unit_id
      this.calculate()
    }
  }

  // 计算总额显示
  calculate() {
    const qty = parseFloat(this.quantityTarget.value) || 0
    const price = parseFloat(this.unitPriceTarget.value) || 0
    const fee = parseFloat(this.deliveryFeeTarget.value) || 0
    const total = (qty * price) + fee
    
    this.amountDisplayTarget.textContent = total.toLocaleString('zh-CN', { 
      minimumFractionDigits: 2, 
      maximumFractionDigits: 2 
    })
  }

  // 强制关闭下拉菜单
  _closeDropdown(event) {
    const container = event.currentTarget.closest('[data-controller="dropdown"]')
    if (container) {
      const menu = container.querySelector('[data-dropdown-target="menu"]')
      if (menu) {
        menu.classList.add('hidden')
      }
    }
  }
}
