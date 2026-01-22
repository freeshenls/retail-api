// app/javascript/controllers/designer/order_new_component_controller.js
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
    // 页面加载瞬间，执行初始化默认值和计算
    this._setInitialDefaults()
    this.calculate()
  }

  // --- 初始化：根据后端预设的 ID 同步 UI 文本 ---
  _setInitialDefaults() {
    // 1. 同步客户名称显示
    const selectedCustomer = this.element.querySelector(`[data-action*="selectCustomer"][data-id="${this.customerIdInputTarget.value}"]`)
    if (selectedCustomer) {
      this.customerNameTextTarget.textContent = selectedCustomer.dataset.name
    }

    // 2. 同步分类名称显示
    const selectedCategory = this.element.querySelector(`[data-action*="selectCategory"][data-id="${this.categoryIdInputTarget.value}"]`)
    if (selectedCategory) {
      this.categoryTextTarget.textContent = selectedCategory.dataset.name
    }

    // 3. 同步服务项目文本
    if (this.serviceTypeInputTarget.value) {
      this.serviceTypeTextTarget.textContent = this.serviceTypeInputTarget.value
    }

    // 4. 执行一次匹配，带出预设单价（如果有的话）
    this.matchUnitAndPrice()
  }

  // --- 核心：手动改价实时触发“自定价”条目的 ID 选择 ---
  handlePriceManualChange() {
    // 1. UI 瞬间切换为“自定价”
    this.serviceTypeTextTarget.textContent = "自定价"
    this.serviceTypeInputTarget.value = "自定价"
    
    // 2. 根据当前选中的“规格/幅面”，匹配对应的自定价 Unit ID
    const currentCategoryId = this.categoryIdInputTarget.value
    if (currentCategoryId) {
      const customUnit = this.unitsValue.find(u => 
        u.service_type === "自定价" && u.category_id == currentCategoryId
      )
      if (customUnit) {
        this.unitIdInputTarget.value = customUnit.unit_id
      }
    }
    
    // 3. 计算金额
    this.calculate()
  }

  // --- 稿件上传回显 ---
  handleFileChange(event) {
    const file = event.target.files[0]
    if (file) {
      this.fileNameDisplayTarget.textContent = file.name
      this.fileNameDisplayTarget.classList.add("text-[#0066b3]", "font-bold")
      this.uploadContainerTarget.classList.add("border-[#0066b3]", "bg-blue-50/30")
      if (this.hasUploadHintTarget) {
        this.uploadHintTarget.textContent = `文件大小: ${(file.size / 1024 / 1024).toFixed(2)} MB`
      }
    }
  }

  // --- 下拉选择逻辑 ---
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
    // 即使是自定价模式，切分类也要切到对应的自定价ID
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

  // --- 核心匹配逻辑 ---
  matchUnitAndPrice() {
    const serviceType = this.serviceTypeInputTarget.value
    const categoryId = this.categoryIdInputTarget.value

    if (serviceType && categoryId) {
      const unit = this.unitsValue.find(u => 
        u.service_type === serviceType && u.category_id == categoryId
      )
      
      if (unit) {
        this.unitIdInputTarget.value = unit.unit_id
        // 只有非“自定价”才覆盖单价
        if (serviceType !== "自定价") {
          this.unitPriceTarget.value = unit.price
        }
        this.calculate()
      }
    }
  }

  calculate() {
    const q = parseFloat(this.quantityTarget.value || 0)
    const p = parseFloat(this.unitPriceTarget.value || 0)
    const f = parseFloat(this.deliveryFeeTarget.value || 0)
    const total = (q * p) + f
    
    if (this.hasAmountDisplayTarget) {
      this.amountDisplayTarget.textContent = total.toLocaleString('zh-CN', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      })
    }
  }

  // --- 自动关闭下拉 ---
  _closeDropdown(event) {
    const container = event.currentTarget.closest('[data-controller="dropdown"]')
    if (container) {
      container.setAttribute("data-dropdown-open-value", "false")
      const menu = container.querySelector('[data-dropdown-target="menu"]')
      if (menu) menu.classList.add('hidden')
    }
  }
}
