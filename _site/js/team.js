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

var showNextMatch = function(){
  repository.nextMatchOfTeam(teamid, function(match){
        var src;
        var name;
        if(teamid != match.tTGUID){
            src = vbl.teamimage(match.tTGUID);
            name = match.tTNaam;
        }
        if(teamid != match.tUGUID){
            src = vbl.teamimage(match.tUGUID);
            name = match.tUNaam;
        }

        var d = new Date(match.jsDTCode);
        var div = $.template("#next-game-template",
        {
            imgurl: src,
            name: name,
            day: d.toLocaleString(window.navigator.language, {weekday: 'long'}),
            date: d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + d.toLocaleString(window.navigator.language, {month: 'long'}),
            time: ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2)
        });
        $("#next-game-placeholder").append(div);

    // repository.currentOrganisation(function(org){
    //   var d = new Date(match.jsDTCode);
    //   $("#next-top-title span").text(d.toLocaleString(window.navigator.language, {weekday: 'long'}));
    //   /* looks like local time is stored as if it were utc? */
    //   $("#next-bottom-title span").text(d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + d.toLocaleString(window.navigator.language, {month: 'long'}) + " | " + ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2));    
    
    //   org.teams.forEach(function(team){
    //       if(team.guid == match.tTGUID || team.guid == match.tUGUID){
    //           $("#next-vs").text(team.naam.replace("Basket Lummen ", ""));
    //       }
    //   });

    //   var homesrc = vbl.teamimage(match.tTGUID);
    //   var awaysrc = vbl.teamimage(match.tUGUID);
    //   $("#next-home-team-logo img").attr("src", homesrc);
    //   $("#next-away-team-logo img").attr("src", awaysrc);
  
    //   $("#next-middle .container").css("visibility", "visible");
    // });
  });
};

$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
  
  repository.loadTeam(teamid);
});

$.topic("vbl.team.loaded").subscribe(function () {
    var team = repository.getTeam(teamid, function(team){
        if(team && team.guid == teamid){
            $("#team-name").text(team.naam);
            $("#team-dashboard").css("visibility", "visible");
        }
        if(!team){
            $("#team-name").text("Team niet gevonden");
        }
    });     
});

$.topic("vbl.matches.loaded").subscribe(function () {
   showNextMatch();
});

$.topic("vbl.members.loaded").subscribe(function () {

});

$( document ).ready(function() {
    $(".detail-toggle").click(function(){
        $(this).parent().nextAll(".detail:first").toggle();  
        return false;
    });
});
