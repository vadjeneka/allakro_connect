import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-product"
export default class extends Controller {
  static targets = ['modal']
  connect() {
  }

  display() {
    this.modalTarget.modal.remove("hidden")
    this.modalTarget.modal.add("block")
  }
}
