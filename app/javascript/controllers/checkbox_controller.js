import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("checkbox connected");
  }

  async preventRedirect(event) {
    event.preventDefault(); // Prevent the default behavior of the checkbox

    const checkbox = event.target;
    const toolId = checkbox.dataset.toolId;

    if (!toolId) {
      console.error("Tool ID is undefined.");
      return;
    }

    const isChecked = checkbox.checked;

    try {
      // Send an AJAX request to update tool.available
      const response = await fetch(`/tools/${toolId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ availability: isChecked })
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      // Handle success if needed
      const responseData = await response.json();
      console.log(responseData);

    } catch (error) {
      console.error('Error:', error);
    }
  }
}
