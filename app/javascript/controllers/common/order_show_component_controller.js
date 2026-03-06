// app/javascript/controllers/common/order_show_component_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  // 假设从 data 属性或 HTML 中获取订单数据
  printTag(event) {
    // 从 dataset 获取数据，建议在模板中做截断处理防止溢出
    const order = event.target.dataset.order
    const draft = event.target.dataset.draft
    const quantity = event.target.dataset.quantity

    const iframe = document.createElement('iframe');
    Object.assign(iframe.style, {
      position: 'fixed', right: '0', bottom: '0', width: '0', height: '0', border: '0'
    });
    document.body.appendChild(iframe);

    const doc = iframe.contentWindow.document;

    doc.write(`
      <html>
        <head>
          <style>
            /* 强制 48x28 尺寸，无边距 */
            @page { size: 48mm 28mm; margin: 0; }
            * { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; box-sizing: border-box; }
            
            body { 
              width: 48mm; height: 28mm;
              font-family: "SimSun", "STHeiti", sans-serif; 
              margin: 0; padding: 2mm;
              overflow: hidden;
              display: flex; flex-direction: column; justify-content: space-between;
            }

            .header {
              font-size: 8pt; font-weight: 900;
              border-bottom: 0.5pt solid #000;
              padding-bottom: 1mm; margin-bottom: 1mm;
              text-align: center; white-space: nowrap;
            }

            .content { flex: 1; display: flex; flex-direction: column; justify-content: center; gap: 0.5mm; }

            .item { 
              font-size: 7pt; font-weight: bold; 
              display: flex; align-items: baseline; 
              white-space: nowrap; overflow: hidden; 
            }

            .label { color: #666; font-weight: normal; min-width: 9mm; display: inline-block; }

            .value { color: #000; text-overflow: ellipsis; overflow: hidden; }

            .order-no { font-family: monospace; font-size: 7.5pt; font-weight: 900; }

            /* 底部装饰或提示 */
            .footer {
              font-size: 6pt; color: #888;
              text-align: right; margin-top: 1mm;
            }
          </style>
        </head>
        <body>
          <div class="header">共点科技发货单</div>
          <div class="content">
            <div class="item">
              <span class="label">订单号:</span>
              <span class="value order-no">${order}</span>
            </div>
            <div class="item">
              <span class="label">稿件名:</span>
              <span class="value">${draft}</span>
            </div>
            <div class="item">
              <span class="label">数量:</span>
              <span class="value">${quantity}</span>
            </div>
            <div class="item">
              <span class="label">日期时间:</span>
              <span class="value">${new Date().toLocaleString()}</span>
            </div>
          </div>
        </body>
      </html>
    `);

    doc.close();

    // 关键：小尺寸打印机通常需要一点加载时间来渲染
    setTimeout(() => {
      iframe.contentWindow.focus();
      iframe.contentWindow.print();
      document.body.removeChild(iframe);
    }, 200);
  }
}