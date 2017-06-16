var showNextMatch = function(){
  repository.nextMatch(function(match){
    repository.currentOrganisation(function(org){
      var d = new Date(match.jsDTCode);
      $("#next-top-title span").text(d.toLocaleString(window.navigator.language, {weekday: 'long'}));
      /* looks like local time is stored as if it were utc? */
      $("#next-bottom-title span").text(d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + d.toLocaleString(window.navigator.language, {month: 'long'}) + " | " + ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2));    
    
      org.teams.forEach(function(team){
          if(team.guid == match.tTGUID || team.guid == match.tUGUID){
              $("#next-vs").text(team.naam.replace("Basket Lummen ", ""));
          }
      });

      var homesrc = vbl.teamimage(match.tTGUID);
      var awaysrc = vbl.teamimage(match.tUGUID);
      $("#next-home-team-logo img").attr("src", homesrc);
      $("#next-away-team-logo img").attr("src", awaysrc);
  
      $("#next-middle .container").css("visibility", "visible");
    });
  });
};


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadOrganization();
  repository.loadMatches();
});

var orgloaded = false;
var matchesloaded = false;

$.topic("vbl.organisation.loaded").subscribe(function () {
    orgloaded = true;
    if(matchesloaded == true){
        showNextMatch();
    }
});

$.topic("vbl.matches.loaded").subscribe(function () {
    matchesloaded = true;
    if(orgloaded == true){
        showNextMatch();
    }
});

$.topic("vbl.members.loaded").subscribe(function () {

});

repository.initialize(orgId);



setInterval(function(){
  var width = $("#partners ul li:first-child img").outerWidth();
  $("#partners ul li:first-child").animate({
      opacity: 0, // animate slideUp
      marginLeft: '-' + width + 'px'
      }, 'slow', 'swing', function() {
      var el = $(this).detach();
      $("#partners ul").append(el);
      el.css({ 'opacity' : 1, 'margin-left' : 0 });
      });		
}, 5000);

var center = function(){
	$("img.focus-center").each(function(i, img) {
		var offset = ($(window).width() - $(img).width()) / 2;
		if(offset < -($(window).width() / 4) || $(img).css('margin-left') != "0px"){
			$(img).animate({
				marginLeft: offset + 'px'
			}, 'slow', 'swing', function() {});
		}
	});
}

$('#myCarousel').bind('slide.bs.carousel', function (e) {
	center();
});
$('#myCarousel').bind('slid.bs.carousel', function (e) {
	center();
});
$(window).resize(function(){
	center();
});
center();


function initMap() {
    var uluru = {lat: 50.991189, lng: 5.18965};
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: uluru
    });
    /*var marker = new google.maps.Marker({
      position: uluru,
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