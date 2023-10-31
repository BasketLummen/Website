var clubmgmtimgbase = "https://clubmgmt.blob.core.windows.net/profiles/";
var clubmgmtleaguebaseuri = "https://clubmgmt-api-prd.azurewebsites.net/api/leagues/";
var clubmgmtorgbaseuri = "https://clubmgmt-api-prd.azurewebsites.net/api/organizations/";
var clubmgmtprofilebaseuri = "https://clubmgmt-api-prd.azurewebsites.net/api/profiles/";
var leagueId = "09346d48-da8b-4b66-ab72-c04bad59d3d8";

var clubmgmt = new function(){
    var self = this;

    this.getRequest = function(uri, callback){
        var xhttp = new XMLHttpRequest();
        xhttp.onload = function () { 
            callback(xhttp.status == 204 ? null : JSON.parse(xhttp.responseText)); 
        };
        xhttp.onerror = function xhrError () { console.error(this.statusText); }
        xhttp.open("GET", uri, true);
        xhttp.setRequestHeader("Content-type", "application/json");
        xhttp.send();    
    }

    this.postRequest = function(uri, body, callback){
        var xhttp = new XMLHttpRequest();
        xhttp.onload = function () { 
            callback(xhttp.status == 204 ? null : JSON.parse(xhttp.responseText)); 
        };
        xhttp.onerror = function xhrError () { console.error(this.statusText); }
        xhttp.open("POST", uri, true);
        xhttp.setRequestHeader("Content-type", "application/json");
        xhttp.send(body);    
    }
    
    //"{leagueid}/organizations/{orgId}/groups/{groupId}"
    this.mapTeam = function(groupId, o,callback){
        self.getRequest(clubmgmtleaguebaseuri + leagueId + "/organizations/" + o + "/groups/" + groupId, function(mapping){
            callback(mapping);           
        });
    }

     //{orgid}/groups/{groupid}
     this.loadTeam = function(groupId, o, callback){
        self.getRequest(clubmgmtorgbaseuri + o + "/groups/" + groupId, function(group){
            callback(group);           
        });
    }

    // map
    this.mapProfiles = function(profileIds, callback){
        self.postRequest(clubmgmtprofilebaseuri + "map", JSON.stringify({ profileIds: profileIds }), function(profiles){
            callback(profiles);           
        });
    }

    this.profileimage = function(profileId){
        return clubmgmtimgbase + profileId + "/" + profileId + ".jpg"; //?v=" + new Date();
    }

    this.teamspecificprofileimage = function(profileId, groupId){
        return clubmgmtimgbase + profileId + "/" + groupId + ".jpg"; //?v=" + new Date();
    }

}
