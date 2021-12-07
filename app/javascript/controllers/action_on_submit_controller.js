import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="action-on-submit"
export default class extends Controller {
  static targets = ['form','field','submitBtn']
  connect() {
    this.enableField()
  }

  emptyField(){
    console.log('kkk')
    this.fieldTarget.value = ''
  }
  enableField(){
    // console.log('Test')
    if (this.fieldTarget.value == ''){
      this.submitBtnTarget.disabled = true
      this.submitBtnTarget.classList.remove('bg-red-500')
      this.submitBtnTarget.classList.add('bg-gray-500')
    }else{
      this.submitBtnTarget.disabled = false
      this.submitBtnTarget.classList.add('bg-red-500')
      this.submitBtnTarget.classList.remove('bg-gray-500')
    }
  }
}
