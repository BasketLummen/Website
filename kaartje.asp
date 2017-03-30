<%toon=2%>
<html>
<head>
<title>Kaartje</title>
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<%reeks=request("reeks")%>
<table>
<tr><td>
<iframe src="http://www.basketlummen.be/google.asp?reeks=<%=reeks%>" width="550" height="620" frameborder="0"  scrolling="no">></iframe>
</td>
<td nowrap valign="top">
<p><a href="kaartje.asp?reeks=1113">2de landelijke dames B</a></p>
<p><a href="kaartje.asp?reeks=203">Land. Juniors C</a></p>
<p><a href="kaartje.asp?reeks=303">Land. Kadetten C</a></p>
<p><a href="kaartje.asp?reeks=402">Land. Miniemen B</a></p>
<p><a href="kaartje.asp?reeks=1302">Land. Kad.Dames B</a></p>

</td>
</tr>
</table>
</div>
</body>
</html>
