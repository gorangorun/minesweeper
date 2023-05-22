import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['email', 'name', 'width', 'height', 'mines', 'submit']

  connect() {
    console.log('connect')
  }

  generate() {
    this.emailTarget.value = this.email()
    this.nameTarget.value = this.randomString()
    this.widthTarget.value = this.randomInt()
    this.heightTarget.value = this.randomInt()
    this.minesTarget.value = this.randomInt(1, this.maxMines())
    this.submitTarget.click()
  }

  email() {
    return `${this.randomString()}@${this.randomString()}.tld`
  }

  name() {
    return this.randomString()
  }

  randomString() {
    return (Math.random() + 1).toString(36).substring(5);
  }

  randomInt(min = 2, max = 15) {
    return Math.floor(Math.random() * (max - min + 1) + min)
  }

  maxMines() {
    return this.widthTarget.value * this.heightTarget.value - 1
  }
}

