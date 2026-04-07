import { Controller } from "@hotwired/stimulus";
import { TurboUtil } from "controllers/util/turbo_util"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  print(event) {
    const { count, customer, date } = event.currentTarget.dataset

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
            /* 强制 48x28 尺寸 */
            @page { size: 48mm 28mm; margin: 0; }
            * { 
              -webkit-print-color-adjust: exact !important; 
              print-color-adjust: exact !important; 
              box-sizing: border-box; 
              /* 核心：设置为微软雅黑 */
              font-family: "Microsoft YaHei", "微软雅黑", sans-serif;
            }
            
            body { 
              width: 48mm; height: 28mm;
              margin: 0; padding: 1.5mm 2.5mm;
              overflow: hidden;
              padding: 2mm 3mm;
              display: flex; flex-direction: column;
            }

            .header {
              /* 小五号是 9pt，这里标题加粗并稍微加大一点点 */
              font-size: 8pt; 
              font-weight: bold;
              border-bottom: 0.5pt solid #000;
              padding-bottom: 0.5mm;
              margin-bottom: 1mm;
              text-align: center;
              white-space: nowrap;
              margin-bottom: 2mm;
            }

            .content { 
              flex: 1; 
              display: flex; 
              flex-direction: column; 
              justify-content: flex-start; 
              gap: 0.1mm; 
            }

            .item { 
              /* 核心：标准小五号字体 (9pt) */
              font-size: 9pt; 
              line-height: 1.5;
              margin-bottom: 0.2mm;
              display: flex; 
              align-items: center;
              white-space: nowrap; 
              overflow: hidden; 
            }

            .label { 
              font-weight: bold;
              min-width: 13mm; /* 稍微加宽 label 确保对齐 */
              display: inline-block;
            }

            .value { 
              text-overflow: ellipsis; 
              overflow: hidden; 
              flex: 1;
            }

            .footer-time {
              font-size: 7pt;
              color: #666;
              margin-top: auto;
              text-align: right;
            }
          </style>
        </head>
        <body>
          <div class="header">共点科技发货单</div>
          <div class="content">
            <div class="item">
              <span class="label">客户名:</span>
              <span class="label">${customer}</span>
            </div>
            <div class="item">
              <span class="label">订单数:</span>
              <span class="label">${count}</span>
            </div>
            <div class="item">
              <span class="label">日期时间:</span>
              <span class="label">${date}</span>
            </div>
          </div>
        </body>
      </html>
    `);

    doc.close();

    setTimeout(() => {
      iframe.contentWindow.focus();
      iframe.contentWindow.print();
      document.body.removeChild(iframe);
    }, 250);
  }

  syncStatus() {
    const { nos } = event.currentTarget.dataset
    TurboUtil.syncStatus(nos)
  }
}
