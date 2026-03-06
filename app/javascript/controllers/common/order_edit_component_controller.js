// app/javascript/controllers/common/order_edit_component_controller.js
import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

export default class extends Controller {
  static targets = [
    "unitIdInput", "customerNameText", "customerIdInput",
    "serviceTypeText", "serviceTypeInput", "categoryText", "categoryIdInput", "serviceTypeOption", "categoryOption",
    "quantity", "unitPrice", "deliveryFee", "amountDisplay", 
    "paymentMethodText", "paymentMethodInput", "deliveryMethodText", "deliveryMethodInput",
    "fileNameDisplay", "uploadHint", "uploadContainer", "fileHiddenInput", "progressBar", "submitBtn"
  ]

  static values = { units: Array }

  connect() {
    // 1. 获取初始值
    const initialService = this.serviceTypeInputTarget.value
    const initialCategoryId = this.categoryIdInputTarget.value

    // 2. 执行双向初始化过滤
    // 用初始服务去禁用不支持的规格
    if (initialService) this.filterOptions('service', initialService)
    // 用初始规格去禁用不支持的服务
    if (initialCategoryId) this.filterOptions('category', initialCategoryId)
      
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
    if (!file) return

    if (file) {
      this.progressBarTarget.classList.replace("bg-green-500", "bg-[#0066b3]")
      this.fileNameDisplayTarget.className = "text-xs font-black text-slate-600 block transition-all"
      this.fileNameDisplayTarget.classList.add("text-[#0066b3]", "font-bold")
      this.uploadContainerTarget.classList.add("border-[#0066b3]", "bg-blue-50/30")
      if (this.hasUploadHintTarget) {
        this.uploadHintTarget.textContent = `${file.name} · ${(file.size / 1024 / 1024).toFixed(2)} MB`
      }
    }

    // 1. 获取 Rails 自动生成的上传地址 (在 HTML 里的 data 属性)
    const url = event.target.dataset.directUploadUrl
    
    // 2. 手动创建上传实例 (参数：文件, 上传地址, 代理对象)
    // 代理对象就是 this，因为我们在下面定义了回调方法
    const upload = new DirectUpload(file, url, this)

    // 3. 立即触发上传
    this.lockSubmit(true, `🚀 正在上传...`)
    event.target.disabled = true

    upload.create((error, blob) => {
      if (error) {
        this.handleError(error)
      } else {
        this.handleSuccess(blob)
      }
      event.target.disabled = false
    }) 
  }

  // --- DirectUpload 代理回调方法 (必须按此名称定义) ---

  // 上传过程中实时更新进度条
  directUploadDidProgress(event) {
    const progress = (event.loaded / event.total) * 100
    this.progressBarTarget.style.width = `${progress}%`
  }

  // 上传开始前
  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", event => this.directUploadDidProgress(event))
  }

  // --- 业务逻辑状态控制 ---

  handleSuccess(blob) {
    this.fileNameDisplayTarget.textContent = "✅ 稿件上传成功"
    this.fileNameDisplayTarget.className = "text-xs font-black text-green-600 block"
    this.progressBarTarget.classList.replace("bg-[#0066b3]", "bg-green-500")
    this.lockSubmit(false) // 上传成功，解锁提交按钮
    
    // 手动将上传成功后的 signed_id 存入表单，确保提交时后端能找到文件
    if (this.hasFileHiddenInputTarget) {
      this.fileHiddenInputTarget.value = blob.signed_id;
    }
  }

  handleError(error) {
    this.fileNameDisplayTarget.textContent = "❌ 上传失败，请检查网络或 CORS"
    this.fileNameDisplayTarget.className = "text-xs font-black text-red-500 block"
    this.lockSubmit(true) // 上传失败，保持锁定，不准提交
  }

  lockSubmit(disabled, text = null) {
    this.submitBtnTargets.forEach(btn => {
      if (btn.tagName == "A") {
        btn.classList.toggle("pointer-events-none", disabled)
      } else {
        btn.disabled = disabled
      }
    })
    if (text) this.fileNameDisplayTarget.textContent = text
  }

  // --- 下拉选择逻辑 (Update 版) ---
  selectCustomer(e) {
    const { id, name } = e.currentTarget.dataset
    this.customerIdInputTarget.value = id
    this.customerNameTextTarget.textContent = name
  }

  filterOptions(type, filterValue) {
    if (!filterValue) return

    // 1. 确定我们要操作哪一组按钮
    const options = type === 'service' ? this.categoryOptionTargets : this.serviceTypeOptionTargets
    
    // 2. 确定匹配逻辑
    const filterKey = type === 'service' ? 'service_type' : 'category_id'
    const otherKey = type === 'service' ? 'category_id' : 'service_type'
    
    // 3. 找出所有合法的“另一方”的值
    const validUnits = this.unitsValue.filter(u => u[filterKey] == filterValue)
    const allowedValues = validUnits.map(u => String(u[otherKey]))

    // 4. 遍历并禁用
    options.forEach(btn => {
      const btnValue = String(btn.dataset.id || btn.dataset.value)
      const isAllowed = allowedValues.includes(btnValue) || btnValue === "自定价"
      
      // 设置原生属性
      btn.disabled = !isAllowed
      
      // 切换视觉样式
      if (isAllowed) {
        btn.classList.remove('opacity-30', 'cursor-not-allowed', 'bg-slate-50')
        btn.classList.add('text-slate-600', 'hover:bg-blue-50', 'cursor-pointer')
      } else {
        btn.classList.add('opacity-30', 'cursor-not-allowed', 'bg-slate-50')
        btn.classList.remove('text-slate-600', 'hover:bg-blue-50', 'cursor-pointer')
      }
    })
  }

  selectService(e) {
    const value = e.currentTarget.dataset.value
    this.serviceTypeInputTarget.value = value
    this.serviceTypeTextTarget.textContent = value
    this.filterOptions('service', value)
    this.matchUnitAndPrice()
  }

  selectCategory(e) {
    const { id, name } = e.currentTarget.dataset
    this.categoryIdInputTarget.value = id
    this.categoryTextTarget.textContent = name
    
    this.filterOptions('category', id)
    // 如果当前是自定价模式，切分类也要切到对应分类的自定价 ID
    if (this.serviceTypeInputTarget.value === "自定价") {
      this.handlePriceManualChange() 
    } else {
      this.matchUnitAndPrice()
    }
  }

  selectPayment(e) {
    const value = e.currentTarget.dataset.value
    this.paymentMethodInputTarget.value = value
    this.paymentMethodTextTarget.textContent = value
  }

  selectDelivery(e) {
    const value = e.currentTarget.dataset.value
    this.deliveryMethodInputTarget.value = value
    this.deliveryMethodTextTarget.textContent = value

    if (value !== "快递") {
      this.deliveryFeeTarget.value = 0.0
      this.deliveryFeeTarget.disabled = true
    } else {
      this.deliveryFeeTarget.disabled = false
    }
    this.calculate()
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
}
