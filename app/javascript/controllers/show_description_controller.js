import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-description"
export default class extends Controller {
  static targets = ['iconDescription','descriptionText']
  connect() {
    // console.log('connected')
    // console.log('display: ',this.descriptionTextTarget.style.display)

  }

  toggleDescription(){
    // console.log(this.descriptionTextTarget.style.display)
    if (this.descriptionTextTarget.classList.contains('hidden')){
      this.descriptionTextTarget.classList.remove('hidden')
      this.descriptionTextTarget.classList.add('block')
      this.iconDescriptionTarget.classList.add('fa-chevron-up')
      this.iconDescriptionTarget.classList.remove('fa-chevron-down')
    }else{
      this.descriptionTextTarget.classList.remove('block')
      this.descriptionTextTarget.classList.add('hidden')
      this.iconDescriptionTarget.classList.remove('fa-chevron-up')
      this.iconDescriptionTarget.classList.add('fa-chevron-down')
    }
  }
}
