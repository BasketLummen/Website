function loadLeaflet(done) {
  if (window.L) {
    done();
    return;
  }

  var existingScript = document.querySelector('script[data-leaflet]');
  if (existingScript) {
    existingScript.addEventListener('load', done, { once: true });
    return;
  }

  var script = document.createElement('script');
  script.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js';
  script.crossOrigin = '';
  script.setAttribute('data-leaflet', 'true');
  script.onload = done;
  document.body.appendChild(script);
}

function configureLeafletMarkerIcons() {
  if (!window.L || !L.Icon || !L.Icon.Default) return;

  L.Icon.Default.mergeOptions({
    iconRetinaUrl: '/css/images/marker-icon-2x.png',
    iconUrl: '/css/images/marker-icon.png',
    shadowUrl: '/css/images/marker-shadow.png'
  });
}

function initLeafletMap(elementId, lat, lng, title, address) {
  var el = document.getElementById(elementId);
  if (!el) return;

  configureLeafletMarkerIcons();
  var map = L.map(el).setView([lat, lng], 15);
  map.attributionControl.setPosition('bottomleft');
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  var marker = L.marker([lat, lng], {
    icon: L.icon({
      iconUrl: '/css/images/marker-icon.png',
      iconRetinaUrl: '/css/images/marker-icon-2x.png',
      shadowUrl: '/css/images/marker-shadow.png',
      iconSize: [25, 41],
      iconAnchor: [12, 41],
      popupAnchor: [1, -34],
      shadowSize: [41, 41]
    })
  }).addTo(map);
  marker.bindPopup('<div><strong>' + title + '</strong><br>' + address + '</div>');
}

function initMaps() {
  loadLeaflet(function () {
    initLeafletMap('vijfsprong', 50.991189, 5.18965, 'De Vijfsprong', 'Sportweg 8, 3560 Lummen, Belgium');
    initLeafletMap('ohvm', 50.98634960469504, 5.194314250017507, 'OHVM', 'Pastoor Frederickxstraat 9, 3560 Lummen, Belgium');
    initLeafletMap('velodroom', 50.99415, 5.2674, 'Velodroom', 'Kerkstraat 151, 3550 Heusden-Zolder, Belgium');
  });
}

$(function () {
  initMaps();
});