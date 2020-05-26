var getParameterByName = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
var vblteamid = getParameterByName("vblteamid");
var teamid = getParameterByName("teamid");
var partnerOrganizationId = getParameterByName("o");
var team;
var profiles;
var visualDate = new Date();

var renderNextMatch = function(){
  repository.nextMatchOfTeam(vblteamid, function(match){
        var src;
        var name;
        if(vblteamid != match.tTGUID){
            src = vbl.teamimage(match.tTGUID);
            name = match.tTNaam;
        }
        if(vblteamid != match.tUGUID){
            src = vbl.teamimage(match.tUGUID);
            name = match.tUNaam;
        }

        var d = new Date(match.jsDTCode);
        var div = $.template("#next-game-template",
        {
            matchuri: "/match/?matchid=" + match.guid,
            imgurl: "background: url(" + src +  "), url('/img/icon.jpg'); background-repeat: no-repeat; background-position: center center; background-size: cover;",
            name: name,
            day: d.toLocaleString(window.navigator.language, {weekday: 'long'}),
            date: d.toLocaleString(window.navigator.language, {day: 'numeric'}) + " " + d.toLocaleString(window.navigator.language, {month: 'long'}),
            time: ('0'+d.getUTCHours()).slice(-2) + ":" + ('0'+d.getMinutes()).slice(-2),
            location: match.accNaam
        });
        $("#next-game-placeholder").append(div);     
  });

  repository.futureMatchesOfTeam(vblteamid, function(match){
    var tr = $.template("#future-game-template", {
                date: match.datumString,
                time: match.beginTijd,
                home: match.tTNaam,
                away: match.tUNaam
            }, "tbody");
    var matchuri= "/match/?matchid=" + match.guid;
    tr.attr('onclick', 'window.document.location="' + matchuri + '";')
    $(".future-games").append(tr);
  });

repository.pastMatches(vblteamid, function(match){
    var tr = $.template("#past-game-template", {
                date: match.datumString,
                time: match.beginTijd,
                home: match.tTNaam,
                away: match.tUNaam,
                result: match.uitslag
            }, "tbody");
     var matchuri= "/match/?matchid=" + match.guid;
    tr.attr('onclick', 'window.document.location="' + matchuri + '";')
    $(".past-games").append(tr);
  });

};

var renderTeam = function(vblTeam, team, profiles){
      
    var qs = null;
    if(teamid != null){
        qs = "teamid=" + teamid; 
    }
    else if(vblteamid != null){
        qs = "vblteamid=" + vblteamid;   
    }
    if(partnerOrganizationId != null)    {
        qs += "&o=" + partnerOrganizationId;
    }

    $("#link-calendar").attr('href', '/teams/calendar/?' + qs);
    $("#link-results").attr('href', '/teams/results/?' + qs);

    if(team != null){
        $("#team-name").text(team.groupName);               
    }
    else if(vblTeam != null){
        $("#team-name").text(vblTeam.naam);
    }
    
    var imgurl = null;
    var fallbackimgurl = null;
    if(team != null){
        imgurl = "url('https://clubmgmt.blob.core.windows.net/groups/originals/" + team.groupId + ".jpg')";        
    }
    fallbackimgurl = "url('/img/team_placeholder.png')";

    var combined = null;
    if(imgurl){
        combined = imgurl;
    }
    if(fallbackimgurl){
        if(combined){
            combined += ", " + fallbackimgurl;
        }
        else{
            combined = fallbackimgurl;
        }
    }
    combined += ";";
    
    $("#team-photo").attr("style", "background: " + combined +  " background-repeat: no-repeat; background-position: center top; background-size: cover;"); 

    if(team != null)
    {      
        team.participations.forEach(function(p){
            var from = p.from != null ? new Date(p.from) :  null;
            var to = p.to != null ? new Date(p.to) :  null;
            if( from != null && from > visualDate || to != null && to <= visualDate ) return;

            var profile = profiles.filter(function(pr){ return pr.id == p.contactId; })[0];

            var contactName = (profile.publicShape.includeFirstName ? profile.firstName : "") +  (profile.publicShape.includeName ? " " + profile.name : "");
            
            if(p.roleName == "Player"){
                var div = $.template("#player-template",
                {
                    name: contactName,
                    // imgurl: '/img/members/' + pic +  '.jpg'        
                    imgscript: "background: " + (profile.publicShape.includePhoto ? "url('" + clubmgmt.teamspecificprofileimage(p.contactId, team.groupId) + "'), url('" + clubmgmt.profileimage(p.contactId) + "')," : "") + " url('/img/icon.jpg');  background-repeat: no-repeat; background-position: center; background-size: cover;"
                });
                $(".players .tiles").append(div); 
            }
            else if(p.roleName == "Head coach" || p.roleName == "Assistent coach" || p.roleName == "Shooting Coach" || p.roleName == "Physical coach" || p.roleName == "Team support manager" || p.roleName == "Physio"){
                var div = $.template("#staff-template",
                {
                    name: contactName,
                    role: p.roleName,
                    // imgurl: '/img/members/' + pic +  '.jpg'   
                    imgscript: "background: " + (profile.publicShape.includePhoto ? "url('" + clubmgmt.teamspecificprofileimage(p.contactId, team.groupId) + "'), url('" + clubmgmt.profileimage(p.contactId) + "')," : "") + " url('/img/icon.jpg');  background-repeat: no-repeat; background-position: center; background-size: cover;"       
                });
                $(".staff .tiles").append(div); 
            }
        });
    }   

    if(vblTeam && vblTeam.poules){
        vblTeam.poules.forEach(function(p){
            if(p.naam.indexOf("OEFEN") === -1){
                var rank = "-";
                if(p.teams){
                    p.teams.forEach(function(t){
                        if(t.guid == vblteamid){
                            rank = t.rangNr;
                        }
                    });
                }

                var div = $.template("#standings-template",
                {
                    name: p.naam,
                    rank: rank           
                });
                var a = $(div).find(".detail-toggle");
                a.attr('href', '/teams/standings/?' + qs + "&poule=" + p.guid)
                $(".results").append(div);        
            }  
        });
    }
};


$.topic("repository.initialized").subscribe(function () {
  console.log("loading data");
   
  if(vblteamid != null){
    repository.loadTeam(vblteamid);
  }
  else if(teamid != null){   
    
    if(partnerOrganizationId == null){

        clubmgmt.mapTeam(teamid, orgId, function(map){
            if(map == null){            
                clubmgmt.loadTeam(teamid, orgId, function(t){
                    team = t;
                    // team.participations.forEach(function(p){});
                    var profileIds = team.participations.map(function(p){
                        return p.contactId;
                     });  
                    
                    clubmgmt.mapProfiles(profileIds, function(pr){
                        profiles = pr;
                        renderTeam(null, team, profiles);
                        $(".loading").hide();
                        $("#team-dashboard").css("visibility", "visible");  
                    });                      
                });                       
            }
            else{
                vblteamid = map.referenceId;
                clubmgmt.loadTeam(teamid, orgId, function(t){
                    team = t;
                    var profileIds = team.participations.map(function(p){
                        return p.contactId;
                     });  
                    clubmgmt.mapProfiles(profileIds, function(pr){
                        profiles = pr;
                        repository.loadTeam(vblteamid);  
                    });                            
                });
            }               
        });

    }
    else{
        clubmgmt.mapTeam(teamid, partnerOrganizationId, function(map){
            if(map == null){            
                clubmgmt.loadTeam(teamid, partnerOrganizationId, function(t){
                    team = t;
                    var profileIds = team.participations.map(function(p){
                        return p.contactId;
                     });  
                    clubmgmt.mapProfiles(profileIds, function(pr){
                        profiles = pr;
                        renderTeam(null, team, profiles);
                        $(".loading").hide();
                        $("#team-dashboard").css("visibility", "visible");  
                    });        
                });                        
            }
            else{
                vblteamid = map.referenceId;
                clubmgmt.loadTeam(teamid, partnerOrganizationId, function(t){
                    team = t;
                    var profileIds = team.participations.map(function(p){
                        return p.contactId;
                     });  
                    clubmgmt.mapProfiles(profileIds, function(pr){
                        profiles = pr;
                        repository.loadTeam(vblteamid);  
                    });         
                });
            }   
        });
    } 
  }
 
});

$.topic("vbl.team.loaded").subscribe(function () {
    repository.loadMatches();
    repository.getTeam(vblteamid, function(vblteam){

        renderTeam(vblteam, team, profiles);
        $(".loading").hide();
        $("#team-dashboard").css("visibility", "visible");

       /* if(vblteam && vblteam.guid == vblteamid){
          
        }
        if(!vblteam){
            $("#team-name").text("Team niet gevonden");
        }*/
    });     
});

$.topic("vbl.matches.loaded").subscribe(function () {
     renderNextMatch();   
});

$.topic("vbl.members.loaded").subscribe(function () {

});

$( document ).ready(function() {
    
});
