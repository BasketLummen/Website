<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Gebruikers</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Gebruikers</font></p>
<%
ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 1


dim order(3)
order(0) = ""
order(1) = "lastlogin DESC, "
order(2) = "loginaantal DESC, "


sqlString = "SELECT lidid, naam, voornaam, soort, blocked, lastlogin, loginaantal " &_
			"FROM tblusers, tblleden WHERE lidid = id AND soort > 1 " &_
			"ORDER BY blocked,"&order(ord)&"naam, voornaam"
rs.open sqlString
%>
<table>
	<tr>
		<th nowrap>id</th>
		<th nowrap><a href="gebruikers.asp?ord=0">naam</a></th>
		<th nowrap>voornaam</th>
		<th nowrap><a href="gebruikers.asp?ord=1">Laatste login</a></th>
		<th nowrap><a href="gebruikers.asp?ord=2">Aantal</a></th>
	</tr>
<%while not rs.eof
	if rs("blocked") = 1 then
		kl = "#DDDDDD"
	elseif rs("soort") = 2 then
		kl = "#FF0000"
	elseif rs("soort") = 3 then
		kl = "#0099FF"
	elseif rs("soort") = 4 then
		kl = "#00CC00"
	else
		kl = "#FFFFFF"
	end if%>
	<tr	bgcolor="<%=kl%>" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" onclick="document.location='gebruikerwijzigen.asp?id=<%=rs("lidid")%>'" style="cursor:hand;cursor:pointer;">
		<td nowrap><%=rs("lidid")%></td>
		<td nowrap><%=rs("naam")%></td>
		<td nowrap><%=rs("voornaam")%></td>
		<td nowrap><%=rs("lastlogin")%></td>
		<td nowrap align="center"><%=rs("loginaantal")%></td>
	</tr>
	<%rs.movenext
wend
rs.close%>

</table>
</div></body>
</html>
