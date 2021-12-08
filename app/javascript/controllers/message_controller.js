import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  static targets = ['container']
  connect() {
    let currentUser = document.getElementById('current-user')?.getAttribute('data-current-user')
    let messageUser = this.containerTarget?.getAttribute('data-message-user')
    this.addClass(currentUser, messageUser)
    // console.log(document.getElementById('current-user').value)
  }

  addClass(currentUser, messageUser) {
    console.log('current_user :',currentUser)
    if (currentUser == messageUser) {
      this.containerTarget.classList.add('rounded-br-none')
      this.containerTarget.classList.add('bg-red-500')
      this.containerTarget.classList.add('text-white')
      this.containerTarget.parentElement.classList.add('justify-end')
    } else {
      this.containerTarget.classList.add('bg-blue-400')
      this.containerTarget.classList.add('text-white')
      this.containerTarget.classList.add('rounded-tl-none')
      this.containerTarget.parentElement.classList.add('justify-start')
    }
    let messageDiv = document.getElementById('messages')
    messageDiv.scrollTop = messageDiv.scrollHeight - messageDiv.clientHeight
  }
}
