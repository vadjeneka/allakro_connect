import { Controller } from "@hotwired/stimulus"

var img_list = []
// Connects to data-controller="img-display-on-create-store"
export default class extends Controller {
  static targets = ['imgGetter','divDisplaying']
  connect() {
    img_list = []
  }
  displayImage(){
      img_list = []
      for (let i = 0; i < this.imgGetterTarget.files.length; i++) {
        img_list.push(this.imgGetterTarget.files[i])
        img_list = [...new Set(img_list)]
      }
      this.divDisplayingTarget.innerHTML = ''
      if (this.imgGetterTarget.files) {
        for (let i = 0; i < img_list.length; i++) {
          this.divDisplayingTarget.innerHTML += "<span class='relative mx-1 w-full' data-img-display-on-create-store-target='imgDiv'> <span class='cursor-pointer absolute top-1 left-2 z-10' data-img-display-on-create-store-target='deleteImage' data-action='click->img-display-on-create-store#deleteImg' data-img-display-on-create-store-id-param='"+i+"'> <i class='fal fa-times text-xl text-white'></i> </span> <img src="+URL.createObjectURL(img_list[i])+" class='h-96 w-full rounded-sm object-cover border opacity-80 border-gray-300' /></span>"
        }
      }
  }
  deleteImg(items){
    img_list.splice(items.params.id,1)
    var ele = new DataTransfer()
    this.divDisplayingTarget.innerHTML = ''
    for (let i = 0; i < img_list.length; i++) {
      ele.items.add(img_list[i])
      this.divDisplayingTarget.innerHTML += "<span class='relative mx-1 w-full' data-img-display-on-create-store-target='imgDiv'> <span class='cursor-pointer absolute top-1 left-2 z-10' data-img-display-on-create-store-target='deleteImage' data-action='click->img-display-on-create-store#deleteImg' data-img-display-on-create-store-id-param='"+i+"'> <i class='fal fa-times text-xl text-white'></i> </span> <img src="+URL.createObjectURL(img_list[i])+" class='h-96 w-full rounded-sm object-cover border opacity-80 border-gray-300' /></span>"
    }
    this.imgGetterTarget.files = ele.files
  }
}
