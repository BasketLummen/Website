var getParameterByName = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
});

$.topic("vbl.organisation.loaded").subscribe(function () {
   
});

$.topic("vbl.matches.loaded").subscribe(function () {
   
});

$.topic("vbl.members.loaded").subscribe(function () {

});

$( document ).ready(function() {
    var teamid = decodeURIComponent(getParameterByName("teamid"));
    $("#team-name").text(teamid)
});
