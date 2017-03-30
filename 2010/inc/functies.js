function getXMLHTTPRequest() {
	try {
		req = new XMLHttpRequest();
	}
	catch(err1) {
		try {
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (err2) {
			try {
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (err3) {
				req = false;
			}
		}
	}
	return req;
}

var http = getXMLHTTPRequest();

function getNieuws() {
	var myurl = 'http://www.basketlummen.be/2010/inc/getnieuws.asp';
	myRand = parseInt(Math.random()*999999999999999);
	var modurl = myurl+"?rand="+myRand;
	http.open("GET", modurl, true);
	http.onreadystatechange = useHttpResponseNieuws;
	http.send(null);
}

function useHttpResponseNieuws() {
	if (http.readyState == 4) {
		if(http.status == 200) {
			var xmldata=http.responseXML //retrieve result as an XML object
			var rssentries=xmldata.getElementsByTagName("bericht")
			for (var i=0; i<rssentries.length; i++){
				document.getElementById('titel1'+i).innerHTML = rssentries[i].getElementsByTagName('datum')[0].firstChild.nodeValue+" - "+rssentries[i].getElementsByTagName('onderwerp')[0].firstChild.nodeValue;
				document.getElementById('nieuws1'+i).innerHTML = rssentries[i].getElementsByTagName('nieuws')[0].firstChild.nodeValue;
			}
			$("#accordion1").accordion({'clearStyle': true});	
		}
	}
}


