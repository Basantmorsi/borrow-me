const ACCESS_TOKEN = 'pk.eyJ1IjoiYmFzYW50LW1vcnNpIiwiYSI6ImNsb3d0Z3N4NjB2aDMyanBiMGhwZjhlcHAifQ.EpWxQV6yOKkci_71jxXiRQ';

let autofillCollection;
let minimap;

// Form operation functions
function showMap() {
  const el = document.getElementById("minimap-container");
  el.classList.remove("none");
}
function hideMap() {
  const el = document.getElementById("minimap-container");
  el.classList.add("none");
}
function expandForm() {
  document.getElementById("manual-entry").classList.add("hide");
  document.querySelector(".secondary-inputs").classList.remove("hide");
  document.querySelector(".submit-btns").classList.remove("hide");
}
function collapseForm() {
  document.getElementById("manual-entry").classList.remove("hide");
  document.querySelector(".secondary-inputs").classList.add("hide");
  document.querySelector(".submit-btns").classList.add("hide");
}
function setValidationText(color, msg, clear = false) {
  const validationTextElement = document.getElementById("validation-msg");
  if (clear) validationTextElement.classList.add("none");
  validationTextElement.classList.remove("color-green", "color-red");
  validationTextElement.classList.add(`color-${color}`);
  validationTextElement.innerText = msg;
  validationTextElement.classList.remove("none");
}
function submitForm() {
  setValidationText("green", "Order successfully submitted.");
  setTimeout(() => {
  resetForm();
  }, 2500);
}
function resetForm() {
  const inputs = document.querySelectorAll("input");
  inputs.forEach(input => input.value = "");
  collapseForm();
  setValidationText("green", "", true)
  autofillCollection.update();
  minimap.feature = null;
}

// Bind functions to HTML buttons
document
  .getElementById("manual-entry")
  .addEventListener("click", expandForm);
document.getElementById("btn-reset").addEventListener("click", resetForm);

// Autofill initialization
document.getElementById("search-js").onload = () => {
mapboxsearch.config.accessToken = ACCESS_TOKEN;

autofillCollection = mapboxsearch.autofill({});

minimap = new MapboxAddressMinimap();
minimap.canAdjustMarker = true;
minimap.satelliteToggle = true;
minimap.onSaveMarkerLocation = (lnglat) => {
console.log(`Marker moved to ${lnglat}`);
};
const minimapContainer = document.getElementById("minimap-container");
minimapContainer.appendChild(minimap);

autofillCollection.addEventListener(
    "retrieve",
    async (e) => {
      expandForm();
      if (minimap) {
      minimap.feature = e.detail.features[0];
      showMap();
      }
    }
);

// Add confirmation prompt to shipping address
const form = document.querySelector("form");
form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const result = await mapboxsearch.confirmAddress(form, {
        minimap: true,
        skipConfirmModal: (feature) =>
        ['exact', 'high'].includes(
        feature.properties.match_code.confidence
        )
    });
    if (result.type === 'nochange') submitForm();
});
}
