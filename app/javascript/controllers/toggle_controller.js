import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["tab", "cards"]
  connect() {
    console.log("toggle controller")
  }
  toggle(event) {
    const selected = document.querySelector('.selected');
    if (selected !== null) {
      selected.classList.toggle('selected');
    }
    event.target.classList.toggle('selected');

    this.request = new Request(event.target.dataset.toggleUrl);
    this.fetchContent(this.request);
  }

  fetchContent(request) {
    fetch(request)
      .then((response) => {
        if (response.status == 200) {
          response.text().then((text) => this.cardsTarget.innerHTML = text);
        } else {
          console.log("Couldn't load data");
        }
      })
  }
}
