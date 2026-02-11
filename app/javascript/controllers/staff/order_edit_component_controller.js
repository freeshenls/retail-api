// app/javascript/controllers/staff/order_edit_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "unitIdInput", "customerNameText", "customerIdInput",
    "serviceTypeText", "serviceTypeInput", "categoryText", "categoryIdInput",
    "quantity", "unitPrice", "deliveryFee", "amountDisplay", 
    "paymentMethodText", "paymentMethodInput",
    "fileNameDisplay", "uploadHint", "uploadContainer"
  ]
  
  static values = { units: Array }

  connect() {
    // 页面加载时，立即根据当前 Input 的值进行一次全量计算
    this.calculate()
  }

  // --- 核心联动：手动改价触发“自定价”锁定 ---
  handlePriceManualChange() {
    this.serviceTypeTextTarget.textContent = "自定价"
    this.serviceTypeInputTarget.value = "自定价"
    
    // 自动寻找当前分类下的“自定价”Unit ID 并同步
    const currentCategoryId = this.categoryIdInputTarget.value
    if (currentCategoryId) {
      const customUnit = this.unitsValue.find(u => 
        u.service_type === "自定价" && u.category_id == currentCategoryId
      )
      if (customUnit) {
        this.unitIdInputTarget.value = customUnit.unit_id
      }
    }
    this.calculate()
  }

  // --- 稿件回显：显示新选择的文件名 ---
  handleFileChange(event) {
    const file = event.target.files[0]
    if (file) {
      this.fileNameDisplayTarget.textContent = file.name
      this.fileNameDisplayTarget.classList.add("text-[#0066b3]", "font-bold")
      this.uploadContainerTarget.classList.add("border-[#0066b3]", "bg-blue-50/30")
      if (this.hasUploadHintTarget) {
        this.uploadHintTarget.textContent = `新文件大小: ${(file.size / 1024 / 1024).toFixed(2)} MB`
      }
    }
  }

  // --- 下拉选择逻辑 (Update 版) ---
  selectCustomer(e) {
    const { id, name } = e.currentTarget.dataset
    this.customerIdInputTarget.value = id
    this.customerNameTextTarget.textContent = name
    this._closeDropdown(e)
  }

  selectService(e) {
    const value = e.currentTarget.dataset.value
    this.serviceTypeInputTarget.value = value
    this.serviceTypeTextTarget.textContent = value
    this.matchUnitAndPrice()
    this._closeDropdown(e)
  }

  selectCategory(e) {
    const { id, name } = e.currentTarget.dataset
    this.categoryIdInputTarget.value = id
    this.categoryTextTarget.textContent = name
    
    // 如果当前是自定价模式，切分类也要切到对应分类的自定价 ID
    if (this.serviceTypeInputTarget.value === "自定价") {
      this.handlePriceManualChange() 
    } else {
      this.matchUnitAndPrice()
    }
    this._closeDropdown(e)
  }

  selectPayment(e) {
    const value = e.currentTarget.dataset.value
    this.paymentMethodInputTarget.value = value
    this.paymentMethodTextTarget.textContent = value
    this._closeDropdown(e)
  }

  // --- 逻辑匹配：根据服务类型+分类 寻找 UnitID 和 价格 ---
  matchUnitAndPrice() {
    const serviceType = this.serviceTypeInputTarget.value
    const categoryId = this.categoryIdInputTarget.value

    if (serviceType && categoryId) {
      const unit = this.unitsValue.find(u => 
        u.service_type === serviceType && u.category_id == categoryId
      )
      
      if (unit) {
        this.unitIdInputTarget.value = unit.unit_id
        // 只有非“自定价”模式下才覆盖单价框
        if (serviceType !== "自定价") {
          this.unitPriceTarget.value = unit.price
        }
        this.calculate()
      }
    }
  }

  // --- 核心计算 ---
  calculate() {
    // 增加健壮性检查，防止 missing target 报错
    if (!this.hasQuantityTarget || !this.hasUnitPriceTarget) return

    const q = parseFloat(this.quantityTarget.value || 0)
    const p = parseFloat(this.unitPriceTarget.value || 0)
    const f = this.hasDeliveryFeeTarget ? parseFloat(this.deliveryFeeTarget.value || 0) : 0
    
    const total = (q * p) + f
    
    if (this.hasAmountDisplayTarget) {
      this.amountDisplayTarget.textContent = total.toLocaleString('zh-CN', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      })
    }
  }

  // --- 辅助：关闭下拉菜单 ---
  _closeDropdown(event) {
    const container = event.currentTarget.closest('[data-controller="dropdown"]')
    if (container) {
      container.setAttribute("data-dropdown-open-value", "false")
      const menu = container.querySelector('[data-dropdown-target="menu"]')
      if (menu) menu.classList.add('hidden')
    }
  }
}
