import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["togglableElement"]
  connect() {
    flatpickr(this.element, {minDate: "today"})}

    fire() {
      this.togglableElementTarget.classList.toggle("d-none");
    }
}
