import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["totalSum"]
  connect() {
    flatpickr(this.element, {minDate: "today"})}
}
