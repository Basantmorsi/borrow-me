import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overly"
export default class extends Controller {
  connect() {

  }

   on() {
    document.getElementById("overlay").style.display = "block";
  }

   off() {
    document.getElementById("overlay").style.display = "none";
  }
}
