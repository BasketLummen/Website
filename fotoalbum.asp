<!--#include file="connect.asp"-->
<%
reeks=trim(request("reeks"))
nr=trim(request("nr"))
if isnull(nr) or nr = "" then nr = 1
nr = int(nr)
set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con
%>
<%toon=5%>
<html>
<head>
<title>Basket Lummen - Fotoalbum</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
	<p>De foto's staan op onze facebookpagina: <a href="https://www.facebook.com/pg/basketlummen/photos/?tab=albums" target="_parent">https://www.facebook.com/pg/basketlummen/photos/?tab=albums</a></p>
</div>
</body>
</html>
