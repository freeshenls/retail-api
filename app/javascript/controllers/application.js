import { Application } from "@hotwired/stimulus"
import Dialog from '@stimulus-components/dialog'
import Chartjs from '@stimulus-components/chartjs'
import Popover from '@stimulus-components/popover'
import Dropdown from '@stimulus-components/dropdown'
import Clipboard from '@stimulus-components/clipboard'
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

application.register('dialog', Dialog)
application.register('chartjs', Chartjs)
application.register('popover', Popover)
application.register('dropdown', Dropdown)
application.register('clipboard', Clipboard)
export { application }
