import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["tab", "cards", "edit", "editCard"]
  connect() {
  }
  toggleEdit(event) {
    const url = new Request(event.target.dataset.toggleUrl);

     // url = `${this.formTarget.action}?query=${this.inputTarget.value}`

    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.editCardTarget.innerHTML = data
      })
  }
  toggle(event) {
    const selected = document.querySelector('.selected');
    if (selected !== null) {
      selected.classList.toggle('selected');
    }
    event.target.classList.toggle('selected');

    const url = new Request(event.target.dataset.toggleUrl);

     // url = `${this.formTarget.action}?query=${this.inputTarget.value}`

    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.cardsTarget.innerHTML = data
      })

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
