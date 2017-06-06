importScripts('/js/vbl.js');
importScripts('/js/repository.js');

onmessage = function(e) {
  console.log('Message received from main script');
  
  var cmd = JSON.parse(e.data);

  if(cmd.what == "loadOrganization"){
    repository.loadOrganization(cmd.orgId);
  }

  console.log('Posting message back to main script');
  postMessage('done');
}

console.log("Web worker started")