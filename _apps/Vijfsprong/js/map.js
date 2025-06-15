function initVijfsprong() {
    var el = document.getElementById('vijfsprong');
    if(!el) return;

    var loc = {lat: 50.991189, lng: 5.18965};
    var map = new google.maps.Map(el, {
      zoom: 15,
      center: loc
    });
    /*var marker = new google.maps.Marker({
      position: loc,
      map: map
    });*/

    
  var infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);

  service.getDetails({ placeId: 'ChIJZRgmzYI7wUcRjEHmCqFIOFA' }, function(place, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
            place.formatted_address + '</div>');
        infowindow.open(map, this);
      });
      }
  });
}

function initOHVM() {
  var el = document.getElementById('ohvm');
  if(!el) return;

  var loc = {lat: 50.98634960469504, lng: 5.194314250017507}; 
    var map = new google.maps.Map(el, {
      zoom: 15,
      center: loc
    });
    /*var marker = new google.maps.Marker({
      position: loc,
      map: map
    });*/
  var infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);

  service.getDetails({ placeId: 'ChIJB9uhJ3k7wUcRLGCy9wDZbzA' }, function(place, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
            place.formatted_address + '</div>');
        infowindow.open(map, this);
      });
      }
  });
}

function initKambergen() {
  var el = document.getElementById('kambergen');
  if(!el) return;

  var loc = {lat: 50.973477484731156, lng: 5.123007369493038};
  var map = new google.maps.Map(el, {
    zoom: 15,
    center: loc
  });
  /*var marker = new google.maps.Marker({
    position: loc,
    map: map
  });*/
  var infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);

  service.getDetails({ placeId: 'ChIJkZ1Jd7A-wUcR4Bv5dTUY-Vk' }, function(place, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
          place.formatted_address + '</div>');
        infowindow.open(map, this);
      });
    }
  });
}

function initVelodroom() {
  var el = document.getElementById('velodroom');
  if(!el) return;

  var loc = {lat: 50.99415, lng: 5.26740};
  var map = new google.maps.Map(el, {
    zoom: 15,
    center: loc
  });
  /*var marker = new google.maps.Marker({
    position: loc,
    map: map
  });*/
  var infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);

  service.getDetails({ placeId: 'ChIJkZ1Jd7A-wUcR4Bv5dTUY-Vk' }, function(place, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
      });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
          place.formatted_address + '</div>');
        infowindow.open(map, this);
      });
    }
  });
}

function initMaps() {
  initVijfsprong();
  initOHVM();
  //initKambergen();
  initVelodroom();
}