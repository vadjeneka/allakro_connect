import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-product"
export default class extends Controller {
  static targets = ['modal']
  connect() {
    console.log('gotchaaa')
  }

  display() {
      this.modalTarget.classList.remove("hidden")
  }
}
