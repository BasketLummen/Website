function loadLeaflet(done) {
  if (window.L) {
    done();
    return;
  }

  if (!document.querySelector('link[data-leaflet]')) {
    var stylesheet = document.createElement('link');
    stylesheet.rel = 'stylesheet';
    stylesheet.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
    stylesheet.crossOrigin = '';
    stylesheet.setAttribute('data-leaflet', 'true');
    document.head.appendChild(stylesheet);
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

function initLeafletMap(elementId, lat, lng, title, address) {
  var el = document.getElementById(elementId);
  if (!el) return;

  var map = L.map(el).setView([lat, lng], 15);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  var marker = L.marker([lat, lng]).addTo(map);
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