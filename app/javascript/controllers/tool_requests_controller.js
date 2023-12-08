// app/javascript/controllers/tool_requests_controller.js
import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails"; // Import Turbo to trigger TurboStreams

export default class extends Controller {
  static targets = ["togglableElement", "card"];

  connect() {
    console.log("connected");
  }

  // Your existing fire method
  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
  }

  // New method for approving tool requests
  async approve() {
    const toolRequestId = this.element.getAttribute("data-tool-request-id");
    console.log(toolRequestId);

    try {
      // Send an AJAX request to approve the tool request
      const response = await fetch(`/tool_requests/${toolRequestId}/approve`, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document.getElementsByName('csrf-token')[0].content,
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      // Fetch the updated content for the 'cards' container and replace its HTML
      // console.log(this.cardTarget)
      const cardsContainer = document.querySelector('[data-toggle-target="cards"]');
      const updatedContent = await fetch('/tool_requests');
      console.log(updatedContent.status)
      const updatedHTML = await updatedContent.text();
      console.log(updatedHTML)
      cardsContainer.innerHTML = updatedHTML;

    } catch (error) {
      console.error("Error:", error);
    }
  }
}
