import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-img-on-create"

var img_list = []
var array_db = []
export default class extends Controller {
  static targets =['imgGetter','divDisplaying', 'hiddenField','ImgDatabase','imgDiv']
  connect() {
    img_list = []
  }
  hideFiles(i){
    console.log(document.getElementById(""+i.params.id+""))
    document.getElementById(""+i.params.id+"").remove()
    this.hiddenFieldTarget.value = [...array_db, i.params.id]
    // console.log(this.hiddenFieldTarget.value)
  }

  displayImage(){
    if ((img_list.length+this.ImgDatabaseTargets.length) > 5){
      alert('You can only choose 6 images')
    }else{
      for (let i = 0; i < this.imgGetterTarget.files.length; i++) {
        img_list.push(this.imgGetterTarget.files[i])
        img_list = [...new Set(img_list)]
      }
      this.imgDivTargets.forEach(element => {
        element.remove()
      });
      if (this.imgGetterTarget.files) {
        for (let i = 0; i < img_list.length; i++) {
          this.divDisplayingTarget.innerHTML += "<span class='relative mx-1 bg-black' data-display-img-on-create-target='imgDiv'> <span class='cursor-pointer absolute top-1 left-2 z-10' data-display-img-on-create-target='deleteImage' data-action='click->display-img-on-create#deleteImg' data-display-img-on-create-id-param='"+i+"'> <i class='fal fa-times text-xl text-white'></i> </span> <img src="+URL.createObjectURL(img_list[i])+" class='h-52 w-full rounded-sm object-cover border opacity-80 border-gray-300' /></span>"
        }
      }
    }
  }
  deleteImg(items){
    img_list.splice(items.params.id,1)
    var ele = new DataTransfer()
    this.imgDivTargets.forEach(element => {
      element.remove()
    })
    for (let i = 0; i < img_list.length; i++) {
      ele.items.add(img_list[i])
      this.divDisplayingTarget.innerHTML += "<span class='relative mx-1 bg-black' data-display-img-on-create-target='imgDiv'> <span class='cursor-pointer absolute top-1 left-2 z-10' data-display-img-on-create-target='deleteImage' data-action='click->display-img-on-create#deleteImg' data-display-img-on-create-id-param='"+i+"'> <i class='fal fa-times text-xl text-white'></i> </span> <img src="+URL.createObjectURL(img_list[i])+" class='h-52 w-full rounded-sm object-cover border opacity-80 border-gray-300' /></span>"
    }
    this.imgGetterTarget.files = ele.files
  }
  filledInputFile(){
    // var ele = new DataTransfer()
    for (let i = 0; i < img_list.length; i++) {
      // ele.addElement(img_list[i])
      this.imgGetterTarget.files[i] = img_list[i]
    }

    console.log('dta', img_list)
    // this.imgGetterTarget.files = img_list;
    console.log('target', this.imgGetterTarget.files)
  }
}
