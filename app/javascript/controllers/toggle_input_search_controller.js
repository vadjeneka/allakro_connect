import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-input-search"
export default class extends Controller {
  static targets = ['iconNavbar','inputSpan','btnSearch']
  connect() { 
    // console.log('connecting to data-controller="toggle-input-search"')
  }

  toggleSearch(){
    if (this.btnSearchTarget.style.display != 'none'){
      this.iconNavbarTarget.classList.remove('flex')
      this.iconNavbarTarget.classList.add('hidden')
      this.inputSpanTarget.classList.remove('hidden')
      this.inputSpanTarget.parentElement.classList.remove('w-1/3')
      this.inputSpanTarget.parentElement.classList.add('w-full')
      this.inputSpanTarget.classList.add('flex')
      this.btnSearchTarget.style.display = 'none'
    }
    else{
      this.iconNavbarTarget.classList.remove('hidden')
      this.iconNavbarTarget.classList.add('flex')
      this.inputSpanTarget.classList.add('hidden')
      this.inputSpanTarget.classList.remove('flex')
      this.inputSpanTarget.parentElement.classList.remove('w-full')
      this.inputSpanTarget.parentElement.classList.add('w-1/3')
      this.btnSearchTarget.style.display = 'block'
    }
    
  }
}
