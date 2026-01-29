import { Application } from "@hotwired/stimulus"
import Dialog from '@stimulus-components/dialog'
import Chartjs from '@stimulus-components/chartjs'
import Popover from '@stimulus-components/popover'
import Dropdown from '@stimulus-components/dropdown'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register('dialog', Dialog)
application.register('chartjs', Chartjs)
application.register('popover', Popover)
application.register('dropdown', Dropdown)
export { application }
