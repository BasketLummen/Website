var vblprotocol = "http";
var vblbase = "vblcb.wisseq.eu/VBLCB_WebService/data"

var vbl = new function(){
    var self = this;
    this.getRequest = function(uri, callback){
        var xhttp = new XMLHttpRequest();
        xhttp.onload = function () { callback(JSON.parse(xhttp.responseText)); };
        xhttp.onerror = function xhrError () { console.error(this.statusText); }
        xhttp.open("GET", uri, true);
        xhttp.setRequestHeader("Content-type", "application/json");
        xhttp.send();    
    }
    this.getUrl = function(path, query){
        return vblprotocol + "://" + vblbase + "/" + path + "?" + query;
    }


    this.orgDetail = function(orgId, callback){
        self.getRequest(self.getUrl("OrgDetailByGuid", "issguid=" + orgId), callback);
    }

    this.members = function(orgId, callback){
        self.getRequest(self.getUrl("RelatiesByOrgGuid", "orgguid=" + orgId), callback);
    }

    this.matches = function(orgId, callback){
        self.getRequest(self.getUrl("OrgMatchesByGuid", "issguid=" +  orgId), callback);
    }
}