import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['minPrice', 'maxPrice', 'category', 'location']

  initialize() {
    this.formData = new FormData();
  
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

    $(function () {
      if (localStorage && localStorage["checked"]) {
          var localStoredData = JSON.parse(localStorage["checked"]);
          var checkboxes = $("input[name='categorie']");
          for (var i = 0; i < checkboxes.length; i++) {
              for (var j = 0; j < localStoredData.length; j++) {
                  if (checkboxes[i].value == localStoredData[j]) {
                      checkboxes[i].checked = true;
                  }
              }
          }
          localStorage.removeItem('checked');
      }
      $("input[type=checkbox]").click(function () {
          var data = $("input[name='categorie']:checked").map(function () {
              return this.value;
          }).get();
          localStorage['checked'] = JSON.stringify(data);
          window.location.reload();
      });
  });   

    // console.log('path', path);

    window.location.href = path
  }

}
