import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    coordinates: Array
  }

  connect() {
    var map = L.map('map').setView(
      [59.92472143605738, 10.73411569091055], // a center-coordinate that is able to display all markers.
      14
    );

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    this.coordinatesValue.forEach((coordinate) => {
      L.marker(coordinate).addTo(map);
    })
  }
}
