import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overly"
export default class extends Controller {
  static values = {
    tool: String
  }
  static targets = ["form"]
  connect() {

  }

   on() {
     this.formTarget.reset()
    document.getElementById("overlay").style.display = "block";
  }

   off(event) {

    if(event.target.id != "message_content")
    {
      document.getElementById("overlay").style.display = "none";
      // document.getElementById("messageForm").reset()
    }

  }

  // submitMessage(event){
  //  // url = `${this.formTarget.action}?query=${this.inputTarget.value}`

  //  event.preventDefault()
  //  const url = new Request(`${this.formTarget.action}?query=${this.toolValue}`);

  //   fetch(url, {headers: {"Accept": "text/plain"}, body: new FormData(this.formTarget)})
  //   .then(response => response.text())
  //   .then((data) => {
  //     console.log(data)
  //   })

  // }
}
