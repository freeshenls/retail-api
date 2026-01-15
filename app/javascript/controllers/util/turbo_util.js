export const TurboUtil = {
	async refreshTabSwitcher(path) {
		let url = `/layout/tabs/refresh?current=${encodeURIComponent(path)}`
		
    const response = await fetch(url, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
    if (response.ok) {
      const html = await response.text()
      Turbo.renderStreamMessage(html)
    }
  }
}