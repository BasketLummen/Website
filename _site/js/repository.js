var dbversion = 3;

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
                $.topic("db.openerror").publish();
            };
            request.onsuccess = function(event) {
                self.db = event.target.result;

                // if(self.worker != null){
                //     //       self.worker.postMessage(JSON.stringify({what:"loadOrganization", orgId:self.orgId}))
                //     // }
                self.loadOrganization(self.orgId);
                self.loadMembers(self.orgId);
                self.loadMatches(self.orgId);

                console.log("Database opened");
                $.topic("db.opened").publish();
               
            };
            request.onupgradeneeded = function(event) { 
                console.log("Database upgrade needed");
                self.db = event.target.result;
                self.ensureOrganisationsStore();
                self.ensureMembersStore();
                self.ensureMatchesStore();
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

    this.ensureMatchesStore =  function(b){
         if (!self.db.objectStoreNames.contains('matches')) {
            var matchesStore = self.db.createObjectStore("matches", { keyPath: "guid" });
            matchesStore.createIndex("jsDTCode", "jsDTCode")
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

    this.loadMatches = function(orgId){
        vbl.matches(orgId, function(matches){
            var tx = self.db.transaction("matches", "readwrite").objectStore("matches");
            matches.forEach(function(m){
               tx.add(m);
            });            
        }); 
    }

    this.currentOrganisation = function(callback){
        var tx = self.db.transaction("organisations", "readonly");
        var store = tx.objectStore("organisations");

        store.openCursor().onsuccess = function(e) {
            var cursor = e.target.result;
            if(cursor) {
                var key = cursor.key;
                var match = cursor.value;
                if(callback) callback(match);
            }
        }
    }

    this.futureMatches = function(callback){
        var tx = self.db.transaction("matches", "readonly");
        var store = tx.objectStore("matches");
        var index = store.index("jsDTCode");

        var today = new Date();

        var range = IDBKeyRange.lowerBound(today.getTime());
        index.openCursor(range).onsuccess = function(e) {
            var cursor = e.target.result;
            if(cursor) {
                var key = cursor.key;
                var match = cursor.value;
                if(callback) callback(match);
                cursor.continue();
            }
        }
    }

     this.nextMatch = function(callback){
        var tx = self.db.transaction("matches", "readonly");
        var store = tx.objectStore("matches");
        var index = store.index("jsDTCode");

        var today = new Date();

        var range = IDBKeyRange.lowerBound(today.getTime());
        index.openCursor(range).onsuccess = function(e) {
            var cursor = e.target.result;
            if(cursor) {
                var key = cursor.key;
                var match = cursor.value;
                if(callback) callback(match);
            }
        }
    }

    this.nextMatchOfTeam = function(teamId, callback){
        var tx = self.db.transaction("matches", "readonly");
        var store = tx.objectStore("matches");
        var index = store.index("jsDTCode");

        var today = new Date();

        var range = IDBKeyRange.lowerBound(today.getTime());
        index.openCursor(range).onsuccess = function(e) {
            var cursor = e.target.result;
            if(cursor) {
                var key = cursor.key;
                var match = cursor.value;
                if(match.tTGuid == teamId || match.tUGuid == teamId)
                {
                    if(callback) callback(match);
                }
                else{
                    cursor.continue();
                }                
            }
        }
    }
}

