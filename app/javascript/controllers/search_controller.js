import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['minPrice', 'maxPrice', 'category', 'location']

  initialize() {
    this.formData = new FormData();
    document.addEventListener("turbolinks:load", ()=>{
      const query = window.location.search
      const parameters = new URLSearchParams(query)
      console.log("turbolinks",parameters.get("price[min]"))
      console.log("turbolinks",parameters.getAll("categories[]"))
      this.minPriceTarget.value = parseInt(parameters.get("price[min]"))

      
     })

  
  }

  connect() {
  }

  // getMinPrice() {
  //   console.log('min price', this.minPriceTarget.value)
  // }

  // getMaxPrice() {
  //   console.log('max price', this.maxPriceTarget.value)
  // }

  performSearch() {
    const minPrice = this.minPriceTarget.value
    const maxPrice = this.maxPriceTarget.value
    const categories = this.categoryTargets.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value)
    const locations = this.locationTargets.filter(checkbox => checkbox.checked).map(checkbox => checkbox.value)

    // console.log('categories', categories)
    console.log('locations', locations)

    this.formData.append("price[min]", minPrice)
    this.formData.append("price[max]", maxPrice)
    if (categories.length > 0) {
      categories.forEach((category) => {
        this.formData.append('categories[]',category)
      })
    } else {
      this.formData.delete('categories[]')
    }

    if (locations.length > 0) {
      locations.forEach((location) => {
        this.formData.append('locations[]',location)
      })
    } else {
      this.formData.delete('locations[]')
    }

    const submitUrl = new URLSearchParams(this.formData).toString();
    const path = `/products?${submitUrl}`

    // console.log('path', path);
    Turbolinks.visit(path)
  }

}
