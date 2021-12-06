import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range-effect"
export default class extends Controller {
  static targets = ['rangeLeftThumb','rangeRightThumb','rangeBarColor','rangeFirst','rangeLast', 'inputContainerLeft','inputContainerRight']

  initialize(){
    this.minprice = 500
    this.maxprice = 1000000
    this.min = 500
    this.max = 1000000
    this.minthumb = 0
    this.maxthumb = 0
  }
  connect() {
    const defaultMinPrice = this.rangeFirstTarget.getAttribute('data-value')
    const defaultMaxPrice = this.rangeLastTarget.getAttribute('data-value')
    this.rangeFirstTarget.max = this.max
    this.rangeFirstTarget.min = this.min
    this.rangeLastTarget.max = this.max
    this.rangeLastTarget.min = this.min
    this.rangeFirstTarget.value =  defaultMinPrice || this.min
    this.rangeLastTarget.value =  defaultMaxPrice || this.max
    this.mintrigger()
    this.maxtrigger()
  }
  mintrigger() {
    if (parseInt(this.rangeFirstTarget.value) >= (parseInt(this.rangeLastTarget.value))-500){
      this.rangeFirstTarget.value = parseInt(this.rangeLastTarget.value) - 500
    }
    this.minprice = Math.min(this.rangeFirstTarget.value, this.maxprice - 500)
    this.minthumb = Math.ceil(((this.minprice - this.min) / (this.max - this.min)) * 100)
    this.rangeBarColorTarget.style.left = ''+this.minthumb+'%'
    this.rangeLeftThumbTarget.style.left = ''+this.minthumb+'%'
    this.inputContainerLeftTarget.value = this.rangeFirstTarget.value
  }
  maxtrigger() {
    if (parseInt(this.rangeLastTarget.value)  <= (parseInt(this.rangeFirstTarget.value))+500){
      this.rangeLastTarget.value = parseInt(this.rangeFirstTarget.value) + 500
    }
    this.maxprice = Math.max(this.rangeLastTarget.value, this.minprice + 500);
    this.maxthumb = Math.floor(100 - (((this.maxprice - this.min) / (this.max - this.min)) * 100))
    this.rangeBarColorTarget.style.right = ''+this.maxthumb+'%'
    this.rangeRightThumbTarget.style.right = ''+this.maxthumb+'%'
    this.inputContainerRightTarget.value = this.rangeLastTarget.value
  }
  changeRangeFirstValue() {
    if (parseInt(this.inputContainerLeftTarget.value) >= 500){
      this.validationLeft()
      this.rangeFirstTarget.value = this.inputContainerLeftTarget.value
      this.mintrigger()
    }else{
      this.inputContainerLeftTarget.value = 500
      this.validationLeft()
      this.rangeFirstTarget.value = this.inputContainerLeftTarget.value
      this.mintrigger()
    }
  }
  changeRangeLastValue() {
    if (parseInt(this.inputContainerRightTarget.value) >= 500){
      this.validationRight()
      this.rangeLastTarget.value = this.inputContainerRightTarget.value
      this.maxtrigger()
    }else{
      this.inputContainerRightTarget.value = 1000000
      this.validationRight()
      this.rangeLastTarget.value = this.inputContainerRightTarget.value
      this.maxtrigger()
    }
  }
  validationRight() {
    if (parseInt(this.inputContainerRightTarget.value) <= parseInt(this.inputContainerLeftTarget.value)){
      this.inputContainerLeftTarget.value = parseInt(this.inputContainerRightTarget.value) - 500
    }else{
      this.rangeLastTarget.value = this.inputContainerRightTarget.value
    }
  }
  validationLeft() {
    if (parseInt(this.inputContainerLeftTarget.value) >= parseInt(this.inputContainerRightTarget.value)){
      this.inputContainerRightTarget.value = parseInt(this.inputContainerLeftTarget.value) + 500
    }
    else{
      this.rangeFirstTarget.value = this.inputContainerLeftTarget.value
    }
  }
}
