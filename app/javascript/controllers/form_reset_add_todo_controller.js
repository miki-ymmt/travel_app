import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-reset-add-todo"
export default class extends Controller {
  reset() {
    console.log("reset function called"); // デバッグメッセージを表示
    this.element.reset()
  }
}
