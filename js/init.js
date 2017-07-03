var orgId = "BVBL1176";

window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction || {READ_WRITE: "readwrite"}; 
window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

// if ('serviceWorker' in navigator) {
//   window.addEventListener('load', function() {
//     navigator.serviceWorker.register('/serviceworker.js').then(function(registration) {
//       // Registration was successful
//       console.log('ServiceWorker registration successful with scope: ', registration.scope);
//     }, function(err) {
//       // registration failed :(
//       console.warn('ServiceWorker registration failed: ', err);
//     });
//   });
// }
// else{
//   console.warn('ServiceWorker not available');
// }

var getParameterByName = function (name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

$.topic("repository.initialized").subscribe(function () {
  repository.loadOrganization();
});

var order = ["HSE", "DSE", "J21", "M21", "J19", "M19", "J16", "M16", "J14", "M14", "G14", "G12", "G10", "G8", "G6"];
$.topic("vbl.organisation.loaded").subscribe(function () {
    repository.currentOrganisation(function(org){
        var sortedTeams = org.teams.sort(function(t1, t2){
            var naam1 = t1.naam.replace("Basket Lummen ", "");
            var code1 = naam1.substring(0, 3);
            var index1 = order.indexOf(code1);
            var naam2 = t2.naam.replace("Basket Lummen ", "");
            var code2 = naam2.substring(0, 3);
            var index2 = order.indexOf(code2);

            if(index1 == index2){
                var last1 = naam1.slice(-1);
                var last2 = naam2.slice(-1);
                if(last1 < last2) return -1;
                if(last1 > last2) return 1;
                return 0;
            }
            else{
                return index1 - index2;
            }
        });
        sortedTeams.forEach(function(team){
            var naam = team.naam.replace("Basket Lummen ", "");
            var markup = "<li><a href=\"#\">" + naam + "</a></li>";
            if(naam.startsWith("HSE") || naam.startsWith("DSE")){
                $(markup).insertBefore("#teams-menu-separator");
            }
            else{
                 $("#teams-menu").append(markup);
            }           
        });
    });
   
});
