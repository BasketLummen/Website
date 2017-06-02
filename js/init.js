window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction || {READ_WRITE: "readwrite"}; 
window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

if (!window.indexedDB) {
    console.warn("Browser doesn't support a stable version of IndexedDB.");
}

var request = window.indexedDB.open("basketlummen", 1);
request.onerror = function(event) {
  alert("Database error: " + event.target.errorCode);
};
request.onsuccess = function(event) {
  db = event.target.result;
};
request.onupgradeneeded = function(event) { 
  var db = event.target.result;

  var orgStore = db.createObjectStore("organisations", { keyPath: "orgID" });

  orgStore.transaction.oncomplete = function(event) {
    // Store values in the newly created objectStore.
    var tx = db.transaction("organisations", "readwrite").objectStore("organisations");
    // for (var i in customerData) {
    //   tx.add(customerData[i]);
    // }
  };
};

var worker;
if(typeof(Worker) !== "undefined") {
      if(typeof(worker) == "undefined") {
          worker = new Worker("/js/background.js");
      }
      worker.onmessage = function(event) {
          console.log( event.data );
      };
  } else {
      console.log("Web Worker not available.");
  }

if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/serviceworker.js').then(function(registration) {
      // Registration was successful
      console.log('ServiceWorker registration successful with scope: ', registration.scope);
    }, function(err) {
      // registration failed :(
      console.warn('ServiceWorker registration failed: ', err);
    });
  });
}
else{
  console.warn('ServiceWorker not available');
}