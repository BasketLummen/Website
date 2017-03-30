<%
seizoen = trim(request("s"))
if isnull(seizoen) then seizoen = ""
%>

<html>
<head>
<title>Basket Lummen - Competitie</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<base target="ploegframe">
</head>

<body onLoad="document.body.style.overflowX='hidden';">
<div id="Layer2" style="position:absolute; width:110px; z-index:0; background-color:#FFFF00; left: 0; top: 0;">
<!--#include file="inc/ploegen.asp" -->

</div>
</body>
</html>
