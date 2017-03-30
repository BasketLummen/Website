<!--#include file="ccorner/connect.asp" -->
<%sh=trim(request("sh"))
sqlString = "SELECT club FROM tblClubsporthal WHERE (sh1 = " & sh & " or sh2 = " & sh & ") ORDER BY stamnr"
rs.open sqlString
while not rs.eof
	ploegen = ploegen & rs("club") & ", "
	rs.movenext
wend
rs.close
if len(ploegen) > 3 then 
	ploegen = left(ploegen, len(ploegen)-2)
end if
 
sqlString = "SELECT sporthalnaam, sporthaladres, postnr, gemeente, tijd, km, weg " &_
			"FROM (tblSporthallen INNER JOIN tblRoutes ON tblSporthallen.sporthalnr = tblRoutes.sporthalnr) " &_ 
			"INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr " &_ 
			"WHERE tblRoutes.sporthalnr = " & sh & " ORDER BY routenr"
rs.open sqlString
if rs.eof then%>
	Routebeschrijving nog niet beschikbaar.
<%else
end if%>
	<html>
	<head>
	<title><%=rs("sporthalnaam")%> - <%=rs("gemeente")%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="opmaak.css" rel="stylesheet" type="text/css">
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAjITo7VA7pueZLeBaAghOfRRFtTCyHp5g4gjaoOhTQx5UyKR1YhQNdl1wABoF3aFzKgH1HNIZd6fcnA"
      type="text/javascript"></script>
    <script type="text/javascript">
    //<![CDATA[
    function load() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(50.8286,4.0175), 16);
		var marker = new GMarker(map.getCenter());
		map.addOverlay(marker);
		map.openInfoWindow(map.getCenter(), document.createTextNode("<%=rs("sporthalnaam")%>, <%=rs("sporthaladres")%>, <%=rs("postnr")%> <%=rs("gemeente")%>"));
      }
    }
    //]]>
    </script>
</head>
	
	<body onload="load()" onunload="GUnload()">
<script language="JavaScript">
if (window.print) {
document.write('<form>'
+ '<p align="center"><input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></p></form>');
}
</script>
	<div id="map" style="width: 600px; height: 450px"></div>
	<a href="http://maps.google.com/maps?f=q&hl=nl&q=50.8286,4.0175&layer=&ie=UTF8&z=16&ll=50.828602,4.017498&spn=0.009488,0.026994&om=1">klik hier om uw route te berekenen</a>
</body>
</html>
