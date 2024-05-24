import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    coordinates: Array
  }

  connect() {
    this.map = L.map('map').setView(
      [59.92472143605738, 10.73411569091055], // a center-coordinate that is able to display all markers in Oslo.
      14
    );

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(this.map);

    this.coordinatesValue.forEach((coordinate) => {
      var marker = L.marker(coordinate.slice(1, 3));
      marker.id = coordinate[0]; // station id.
      marker.addTo(this.map).on('mouseover', (e) => {
        if (this.previous) {
          this.previous.classList.remove('active');
        }
        var stationAnchor = document.getElementById(e.target.id);
        stationAnchor.classList.add('active');
        stationAnchor.scrollIntoView();
        this.previous = stationAnchor;
      });
      marker.addTo(this.map).on('mouseout', (e) => {
        if (this.markerClicked) {
          this.markerClicked = false;
          return;
        }
        if (this.previous) {
          this.previous.classList.remove('active');
        }
        var stationAnchor = document.getElementById(e.target.id);
        stationAnchor.classList.remove('active');
        this.previous = null;
      });
      marker.addTo(this.map).on('click', (e) => {
        if (this.previous) {
          this.previous.classList.remove('active');
        }
        this.map.setView(e.target._latlng, 20);
        var stationAnchor = document.getElementById(e.target.id);
        stationAnchor.classList.add('active');
        this.previous = stationAnchor;
        this.markerClicked = true;
      });
    })
  }

  view(event) {
    if (this.previous) {
      this.previous.classList.remove('active');
    }
    if (event.target.nodeName != "A") {
      var element = event.target.closest('a');
      element.classList.add('active');
      this.previous = element;
    } else {
      event.target.classList.add('active');
      this.previous = event.target;
    }
    this.map.setView(event.params.coordinate, 20);
  }
}
