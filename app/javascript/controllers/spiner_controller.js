import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner", "submitButton"]

  connect() {
    this.element.addEventListener("turbo:submit-start", this.showSpinner.bind(this))
    this.element.addEventListener("turbo:submit-end", this.hideSpinner.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("turbo:submit-start", this.showSpinner.bind(this))
    this.element.removeEventListener("turbo:submit-end", this.hideSpinner.bind(this))
  }

  showSpinner() {
    this.spinnerTarget.classList.remove('hidden')
    this.submitButtonTarget.disabled = true
  }

  hideSpinner() {
    this.spinnerTarget.classList.add('hidden')
    this.submitButtonTarget.disabled = false
  }
}
