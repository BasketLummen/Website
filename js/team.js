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

var renderNextMatch = function(){
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
            time: ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2),
            location: match.accNaam
        });
        $("#next-game-placeholder").append(div);
  });

  repository.futureMatches(teamid, function(match){
    var tr = $.template("#future-game-template", {
                date: match.datumString,
                time: match.beginTijd,
                home: match.tTNaam,
                away: match.tUNaam
            }, "tbody");
    $(".future-games").append(tr);
  });

repository.pastMatches(teamid, function(match){
    var tr = $.template("#past-game-template", {
                date: match.datumString,
                time: match.beginTijd,
                home: match.tTNaam,
                away: match.tUNaam,
                result: match.uitslag
            }, "tbody");
    $(".past-games").append(tr);
  });

};

var renderTeam = function(team){
    $("#team-name").text(team.naam);

    if(team.spelers){
        team.spelers.forEach(function(p){
            var div = $.template("#player-template",
            {
                name: p.naam,
                birthDate: p.sGebDat,
                imgurl: '/img/icon.jpg'           
            });
            $(".players .tiles").append(div);          
        });
    }
    else{
        var div = $.template("#message-template", {
            message: "Spelers nog niet geregistreerd"
        });
        $(".players .tiles").append(div);
    }

    if(team.tvlijst){
        team.tvlijst.forEach(function(tv){
            var div = $.template("#staff-template",
            {
                name: tv.naam,
                role: tv.tvCaC,
                imgurl: '/img/icon.jpg'           
            });
            $(".staff .tiles").append(div);          
        });
    }
    else{
        var div = $.template("#message-template", {
            message: "Staf nog niet geregistreerd"
        });
        $(".staff .tiles").append(div);
    }

     if(team.poules){
        team.poules.forEach(function(p){
            if(p.naam.indexOf("OEFEN") === -1){
                var entries = [];
                var rank = "-";
                if(p.teams){
                    p.teams.forEach(function(t){
                        if(t.guid == teamid){
                            rank = t.rangNr;
                        }

                        var tr = $.template("#standings-entry-template", {
                            nr: t.rangNr,
                            team: t.naam,
                            played: t.wedAant,
                            wins: t.wedWinst,
                            draws: t.wedGelijk,
                            losses:  t.wedVerloren,
                            points: t.wedPunt
                        }, "tbody")
                        entries.push(tr);
                    });
                }

                var div = $.template("#standings-template",
                {
                    name: p.naam,
                    rank: rank           
                });
                var table = $(div).find(".detail");
                entries.forEach(function(e){
                    table.append(e);
                });
                $(".results").append(div);        
            }  
        });
    }

    $(".detail-toggle").click(function(){
        $(this).parent().nextAll(".detail:first").toggle();  
        return false;
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
           renderTeam(team);
            $("#team-dashboard").css("visibility", "visible");
        }
        if(!team){
            $("#team-name").text("Team niet gevonden");
        }
    });     
});

$.topic("vbl.matches.loaded").subscribe(function () {
   renderNextMatch();
});

$.topic("vbl.members.loaded").subscribe(function () {

});

$( document ).ready(function() {
    
});
