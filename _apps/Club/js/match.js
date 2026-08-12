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

var renderMatchDetails = function(match, org) {

    $("#poule").text(match._default.pouleNaam);
    var d = new Date(match._default.jsDTCode);
    // d appears to be a UTC date, but using current local time
    var year = d.getUTCFullYear();
    var month = d.getUTCMonth();
    var day = d.getUTCDate();
    var hours = d.getUTCHours();
    var minutes = d.getUTCMinutes();
    var seconds = d.getUTCSeconds();
    var realDate = new Date(year, month, day, hours, minutes, seconds);

    $("#next-top-title span").text(d.toLocaleString(window.navigator.language, {weekday: 'long'}));
    /* date value is local time, but timezone offset still applied */
    $("#next-bottom-title span").text(d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + realDate.toLocaleString(window.navigator.language, {month: 'long'}) + " | " + ('0'+realDate.getHours()).slice(-2) + ":" + ('0'+realDate.getMinutes()).slice(-2));    

    var vs = "VS";
    $("#home-team").text(match._default.teamThuisNaam);
    $("#away-team").text(match._default.teamUitNaam);

    $("#next-vs").text(vs);

    var homesrc = vbl.teamimage(match._default.teamThuisGUID);
    var awaysrc = vbl.teamimage(match._default.teamUitGUID);
    $("#next-home-team-logo img").attr("src", homesrc);
    $("#next-away-team-logo img").attr("src", awaysrc);

    $("#next-middle .container").css("visibility", "visible");

    var geocoder = new google.maps.Geocoder();
    var address = match._default.accommodatieDoc.adres;
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
                infowindow.setContent('<div><strong>' + match._default.accommodatieDoc.naam + '</strong><br>' + addressStr + '</div>');
                infowindow.open(map, this);
            });
          }
         }
    });
    $("#acc-name").text(match._default.accommodatieDoc.naam);
    $("#acc-address").text(addressStr);
    $("#acc-telephone").text(match._default.accommodatieDoc.telefoon ? match._default.accommodatieDoc.telefoon : "");
    $("#acc-web").text(match._default.accommodatieDoc.website ? match._default.accommodatieDoc.website : "");

    $("#division").text(match._default.wedID.substring(0, 8));
    $("#game-nr").text(match._default.wedID.substring(8));
    $("#mat").text(org.stamNr);

    if(match._default.wedOff){
        match._default.wedOff.forEach(function(off){
            $('#officials').append($('<tr>').append($('<td>').text(off)));
        });
    }    


    if(realDate.getTime() < Date.now()){
        $("#result-header").show();

        if(match._default.uitslag != null && match._default.uitslag.length > 0){
            $('#results').text(match._default.uitslag);
            $("#result-container").show();
        }
        else{
            $("#result-form-container").show();
        }
    }
    bindForm(match);
}

var bindForm = function(match){
    var form = $('#result-form-container form');
   
    var teamThuisGUID = match._default.teamThuisGUID;
    var teamUitGUID = match._default.teamUitGUID

    var rules = {
        homescore: {
            required: true
        },
        awayscore: {
            required: true
        },
        pin: {
            required: pin
        }
    };

    // set up form validation messages
    var messages = {
        homescore: {
            required: "*"
        },
        awayscore: {
            required: "*"
        },
        pin: {
            required: "*"
        }
    };


    form.validate({
        onkeyup: false,
        rules: rules,
        messages: messages,
        submitHandler: function (f) {

            var home = form.find('#homescore').val();
            var away = form.find('#awayscore').val();
            var pin = form.find('#pin').val();

            vbl.putUitslag(matchid, home, away, pin, teamThuisGUID, teamUitGUID, function(uitslag){
                $('#results').text(uitslag);
                $("#result-container").show();
                $("#result-form-container").hide();
            },
            function(){
                $("#message").text("Pincode onjuist of verwerking niet mogelijk!")
            });

            return false;
        }
    });
            
}

$.topic("vbl.match.details.loaded").subscribe(function (match) {
     repository.getMatchDetails(matchid, function(match){
         repository.currentOrganisation(function(org){
            renderMatchDetails(match, org);
         });
     });  
});


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatchDetails(matchid);
});