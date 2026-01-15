import Cookies from "js-cookie"

export const CookieUtil = {
	init() {
		const path = location.pathname

    let tabs = JSON.parse(Cookies.get('tabs') || '[]')
    if (!tabs.map(item => item.path).includes(path)) {
      tabs.push({ label: "控制台", path: path, active:true, closable: false })
      Cookies.set('tabs', JSON.stringify(tabs))
    }
  }
}