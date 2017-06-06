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

        if (window.indexedDB) {  

            var request = window.indexedDB.open(orgId, 1);
            request.onerror = function(event) {
                console.warn("Database error: " + event.target.errorCode);
            };
            request.onsuccess = function(event) {
                self.db = event.target.result;
            };
            request.onupgradeneeded = function(event) { 
                var db = event.target.result;

                var orgStore = db.createObjectStore("organisations", { keyPath: "guid" });

                orgStore.transaction.oncomplete = function(event) {

                // if(self.worker != null){
                //     console.log('Sending command to worker');
                //     self.worker.postMessage(JSON.stringify({what:"loadOrganization", orgId:orgId}))
                // }
                // else{
                    self.loadOrganization(orgId);
                // }
               
                };
            };

        }
        else
        {
            console.warn("Browser doesn't support a stable version of IndexedDB.");
        }
    }

    this.loadOrganization = function(orgId){
        console.log("hello from load organization");
        vbl.orgDetail(orgId, function(org){
            var l = org[0];
            var tx = self.db.transaction("organisations", "readwrite").objectStore("organisations");
            tx.add(l);
        });
        

         // Store values in the newly created objectStore.
               
    }
}

