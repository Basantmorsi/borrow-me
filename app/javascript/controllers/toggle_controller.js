import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "cards", "edit", "editCard", "profileLink"]

  connect() {}

  toggleEdit(event) {
    const url = new Request(event.target.dataset.toggleUrl);
    console.log(event.target.dataset.toggleFinder)
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.editCardTarget.innerHTML = data;
        this.toggleVisibility(); // Toggle visibility after updating content
      })
  }


  profile(event)
  {
      event.preventDefault()
      // event.stopPropagation()
      console.log(event.target.dataset.toggleUrl)
      const url = new Request(this.profileLinkTarget.href);

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.cardsTarget.innerHTML = data;
      })
    //this.cardsTarget.append("<%= j render(:partial => 'devise/registrations/edit') %>");


  }

  toggleVisibility() {
    this.editCardTarget.classList.toggle('d-none');
  }

  toggle(event) {
    event.preventDefault()
    const selected = document.querySelector('.selected');
    if (selected !== null) {
      selected.classList.toggle('selected');
    }
    event.target.classList.toggle('selected');

    const url = new Request(event.target.dataset.toggleUrl);
    console.log(url)

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.cardsTarget.innerHTML = data;
        //this.toggleVisibility(); // Toggle visibility after updating content
      })
  }

  fetchContent(request) {
    fetch(request)
      .then((response) => {
        if (response.status == 200) {
          response.text().then((text) => {
            this.cardsTarget.innerHTML = text;
            this.toggleVisibility(); // Toggle visibility after updating content
          });
        } else {
          console.log("Couldn't load data");
        }
      })
  }

  toggleModify(event) {
    console.log(event.target.dataset.toggleFinder)
    const target = document.getElementById(event.target.dataset.toggleFinder)
    target.classList.toggle("d-none")
  }
}
