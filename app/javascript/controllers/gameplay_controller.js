import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['gameplay']
  static values = {
    url: String
  }

  connect() {
    console.log('connect')
  }

  swipe(e) {
    let x = e.currentTarget.dataset.x
    let y = e.currentTarget.dataset.y

    fetch(`${this.urlValue}?x=${x}&y=${y}`, {
      method: "PUT",
      headers: {
       'X-CSRF-Token': document.querySelector(`meta[name="csrf-token"]`).content,
       "Content-Type": "text/javascript",
      },
      body: JSON.stringify({ x: x, y: y })
    })
    .then(response => response.text())
    .then(html => this.gameplayTarget.innerHTML = html) 
  }
}

