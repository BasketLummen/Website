var getParameterByName = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
var matchid = decodeURIComponent(getParameterByName("matchid"));

var renderMatchDetails = function(match) {
    var geocoder = new google.maps.Geocoder();
    var address = match.doc.accommodatieDoc.adres;
    var addressStr = address.straat + " " + address.huisNr + ", " + address.plaats;
    geocoder.geocode( { 'address': addressStr}, function(results, status) {
         if (status == google.maps.GeocoderStatus.OK) {
          if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
            var loc = results[0].geometry.location;

            var infowindow = new google.maps.InfoWindow();
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 15,
                center: loc
            });
            var marker = new google.maps.Marker({
                position: loc,
                map: map
            });
            google.maps.event.addListener(marker, 'click', function() {
                infowindow.setContent('<div><strong>' + match.doc.accommodatieDoc.naam + '</strong><br>' + addressStr + '</div>');
                infowindow.open(map, this);
            });
          }
         }
    });
    $("#acc-name").text(match.doc.accommodatieDoc.naam);
    $("#acc-address").text(addressStr);
    $("#acc-telephone").text(match.doc.accommodatieDoc.telefoon ? match.doc.accommodatieDoc.telefoon : "");
    $("#acc-web").text(match.doc.accommodatieDoc.website ? match.doc.accommodatieDoc.website : "");
}

$.topic("vbl.match.details.loaded").subscribe(function (match) {
     repository.getMatchDetails(matchid, function(match){
          renderMatchDetails(match);
     });  
});


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatchDetails(matchid);
});