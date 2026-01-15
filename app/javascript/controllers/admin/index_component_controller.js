import { Controller } from "@hotwired/stimulus";
import { CookieUtil } from "controllers/util/cookie_util"

export default class extends Controller {
  connect() {
    CookieUtil.init()
  }
}
