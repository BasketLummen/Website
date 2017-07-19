var getParameterByName = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
var teamid = decodeURIComponent(getParameterByName("teamid"));

$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
  
  repository.loadTeam(teamid);
});

$.topic("vbl.team.loaded").subscribe(function () {
   
});

$.topic("vbl.matches.loaded").subscribe(function () {
   
});

$.topic("vbl.members.loaded").subscribe(function () {

});

$( document ).ready(function() {
    $("#team-name").text(teamid)
});
