# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "js-cookie" # @3.0.5
pin "@stimulus-components/dropdown", to: "@stimulus-components--dropdown.js" # @3.0.0
pin "stimulus-use" # @0.52.3
pin "@stimulus-components/dialog", to: "@stimulus-components--dialog.js" # @1.0.1
pin "@stimulus-components/popover", to: "@stimulus-components--popover.js" # @7.0.0
pin "@stimulus-components/chartjs", to: "@stimulus-components--chartjs.js" # @6.0.1
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "chart.js" # @4.5.1
pin "@rails/activestorage", to: "@rails--activestorage.js" # @8.1.200
