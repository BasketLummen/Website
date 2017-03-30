<!--#include file="ccorner/connect.asp" -->
<html>
<head>
<title>Sporthal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<%sh=trim(request("sh"))
sponsor=trim(request("sponsor"))
sqlString = "SELECT sporthaladres, postnr, gemeente, sll, sspn, ll, spn " &_
			"FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr " &_ 
			"WHERE sporthalnr = " & sh
rs.open sqlString
if rs.eof then%>
	Sporthal is nog niet beschikbaar.
<%else
	response.Redirect("http://maps.google.com/maps?f=q&hl=nl&q="&rs("sporthaladres")&", "&rs("postnr")&", "&rs("gemeente")&"&sll="&rs("sll")&"&sspn="&rs("sspn")&"&layer=&ie=UTF8&z=15&ll="&rs("ll")&"&spn="&rs("spn")&"&om=1&iwloc=addr")
end if%>
<body>
</body>
</html>
