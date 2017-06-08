var dbversion = 2;

var repository = new function(){
    var self = this;
    this.initialize = function(orgId){
        self.orgId = orgId;

        if(typeof(Worker) !== "undefined") {
            if(typeof(worker) == "undefined") {
                self.worker = new Worker("/js/background.js");
            }
            self.worker.onmessage = function(event) {
                console.log( event.data );
            };
        } else {
            console.warn("Web Worker not available.");
        }

        if (indexedDB) {  

            var request = indexedDB.open(orgId, dbversion);
            request.onerror = function(event) {
                console.warn("Database error: " + event.target.errorCode);
            };
            request.onsuccess = function(event) {
                self.db = event.target.result;

                // if(self.worker != null){
                //     //       self.worker.postMessage(JSON.stringify({what:"loadOrganization", orgId:self.orgId}))
                //     // }
                self.loadOrganization(self.orgId);
                self.loadMembers(self.orgId);
               
            };
            request.onupgradeneeded = function(event) { 
                self.db = event.target.result;
                self.ensureOrganisationsStore();
                self.ensureMembersStore();
            };

        }
        else
        {
            console.warn("Browser doesn't support a stable version of IndexedDB.");
        }
    }

    this.ensureOrganisationsStore =  function(){
        if (!self.db.objectStoreNames.contains('organisations')) {
            var orgStore = self.db.createObjectStore("organisations", { keyPath: "guid" });

        }
    }

     this.ensureMembersStore =  function(b){
         if (!self.db.objectStoreNames.contains('members')) {
            var memberStore = self.db.createObjectStore("members", { keyPath: "relGuid" });
         }
    }

    this.loadOrganization = function(orgId){
        vbl.orgDetail(orgId, function(orgs){
            var tx = self.db.transaction("organisations", "readwrite").objectStore("organisations");
            orgs.forEach(function(o){
               tx.add(o);
            });            
        }); 
    }

    this.loadMembers = function(orgId){
        vbl.members(orgId, function(members){
            var tx = self.db.transaction("members", "readwrite").objectStore("members");
            members.forEach(function(m){
               tx.add(m);
            });            
        }); 
    }
}

