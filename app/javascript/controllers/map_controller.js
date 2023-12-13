import { Controller } from "@hotwired/stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });

    this.addMarkersToMap();
    this.fitMapToMarkers();
  }

  addMarkersToMap() {
    if (this.markersValue.length > 0) {
      this.markersValue.forEach(marker => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
        const el = document.createElement('div');
        el.className = 'custom-marker'; // Classe pour le style du marqueur
        new mapboxgl.Marker(el)
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(this.map);
      });
    }
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
