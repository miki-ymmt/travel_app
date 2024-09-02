import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-range"
export default class extends Controller {
  static targets = ["from","to"]

  connect() {
    //stimulusに接続された時に呼び出される
    this.fromTarget.min = this.sysdate
    this.toTarget.min = this.sysdate
  }

  updateTo() {
    //FromがクリアされたらToもクリアする
    if (!this.fromTarget.value) {
      this.toTarget.min = this.sysdate
      this.toTarget.value = ""
      return
    }

    //Fromが変更されたらToのminを変更する
    this.toTarget.min = this.fromTarget.value

    //ToがFromを超えないようにする
    if (this.toTarget.value && this.toTarget.value < this.fromTarget.value) {
      this.toTarget.value = this.fromTarget.value
    }
  }

  get sysdate() {
    return new Date().toISOString().split('T')[0]
  }
}
