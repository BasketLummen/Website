<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%reeks=request("reeks")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Google</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAjITo7VA7pueZLeBaAghOfRRFtTCyHp5g4gjaoOhTQx5UyKR1YhQNdl1wABoF3aFzKgH1HNIZd6fcnA"
      type="text/javascript"></script>
    <script type="text/javascript">
	<%
	if left(reeks,1) = 3 and len(reeks) = 6 then
		centraal = "51.02067, 5.47531"
		zoom = 10
	elseif reeks = 104 then
		centraal = "50.56928, 4.80103"
		zoom = 8
	else
		centraal = "51.03967, 4.87518"
		zoom = 9
	end if
	%>
	
	
		//load Google Map
		function load() {
		  if (GBrowserIsCompatible()) {
			var map = new GMap2(document.getElementById("map"));
			map.addControl(new GMapTypeControl());
			map.addControl(new GSmallMapControl());
			GDownloadUrl("xml/googlexml.asp?reeks=<%=reeks%>", function(data, responseCode) {
			map.setCenter(new GLatLng(<%=centraal%>), <%=zoom%>);
			var xml = GXml.parse(data);
			var markers = xml.documentElement.getElementsByTagName("marker");
			for (var i = 0; i < markers.length; i++) {
			      var point = new GLatLng(parseFloat(markers[i].getAttribute("lat")),
									  parseFloat(markers[i].getAttribute("lng")));
				  map.addControl(new GMapTypeControl());
				  var marker = new GMarker(point);
				  map.addOverlay(marker);
			}
				  }
				);
		  }
		}

    </script>
  </head>
  <body onload="load()" onunload="GUnload()">
    <div id="map" style="width: 530px; height: 600px"></div>
  </body>
</html>
