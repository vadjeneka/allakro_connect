import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['minPrice', 'maxPrice']

  connect() {
  }

  getMinPrice() {
    console.log('min price', this.minPriceTarget.value)
  }

  getMaxPrice() {
    console.log('max price', this.maxPriceTarget.value)
  }

}
