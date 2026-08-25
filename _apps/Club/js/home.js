var showNextMatch = function(){
  repository.nextMatch(function(match){
    repository.currentOrganisation(function(org){
      var d = new Date(match.jsDTCode);
      $("#next-top-title span").text(d.toLocaleString(window.navigator.language, {weekday: 'long'}));
      /* looks like local time is stored as if it were utc? */
      $("#next-bottom-title span").text(d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + d.toLocaleString(window.navigator.language, {month: 'long'}) + " | " + ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2));    
    
      var vs = "";
      org.teams.forEach(function(team){
          if(team.guid == match.tTGUID|| team.guid == match.tUGUID){
            partnerTeamNames.forEach(function(teamName){
                vs = team.naam.replace(teamName, "");
            });           
          }
      });
      if(vs == ""){
        if( partnerTeamIds.indexOf(encodeURI(match.tTGUID)) > -1){
            partnerTeamNames.forEach(function(teamName){
                vs = match.tTNaam.replace(teamName, "");
            });
        }
        else if( partnerTeamIds.indexOf(encodeURI(match.tUGUID)) > -1){
            partnerTeamNames.forEach(function(teamName){
                vs = match.tUNaam.replace(teamName, "");
            });           
        }
      } 

      $("#next-vs").text(vs);

      var homesrc = vbl.teamimage(match.tTGUID);
      var awaysrc = vbl.teamimage(match.tUGUID);
      $("#next-home-team-logo img").attr("src", homesrc);
      $("#next-away-team-logo img").attr("src", awaysrc);
  
      $("#next-link").attr("href", "/match/?matchid=" + match.guid)
      $("#next-middle .container").css("visibility", "visible");

    });
  });
};


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
  repository.loadMatches();
});

var orgloaded = false;
var matchesloaded = false;

// assumes init loads the org
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