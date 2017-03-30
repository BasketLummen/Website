<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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
<title>Basket Lummen - Sponsors</title>
<script type="text/javascript" src="jquery-1.4.2.js"></script> 
<script type="text/javascript" src="jquery.floatheader.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#sponsortabel").floatHeader();  
});     
</script>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
select {
	background-color: #FFFFFF;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menusponsors.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%if Session("BL_soort") < 5 then%>
<p class="NieuwsTitels"><font size="3">Sponsors</font></p>

<%

status1=trim(request("status"))
if status1="" or isnull(status1) then status1 = 1
%>
<form name="jump">
<p>Status <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<option value="sponsorlijst.asp?status=1"<%
		if status1 = "1" then%>
			selected<%
		end if%>>Actieve sponsor</option>
		<option value="sponsorlijst.asp?status=2"<%
		if status1 = "2" then%>
			selected<%
		end if%>>Actief in natura</option>
		<option value="sponsorlijst.asp?status=3"<%
		if status1 = "3" then%>
			selected<%
		end if%>>Niet gecontacteerd</option>
		<option value="sponsorlijst.asp?status=4"<%
		if status1 = "4" then%>
			selected<%
		end if%>>Geen interesse</option>
		<option value="sponsorlijst.asp?status=5"<%
		if status1 = "5" then%>
			selected<%
		end if%>>Geen optie</option>
	</select>
</p>
</form>
<%
sqlString = "SELECT id, naam, adres, tblsponsors.postnr, gemeente, btw, " &_
			"telnr, email, contact, verantwoordelijke, bedrag, status, contactdatum, opmerkingen " &_
			"FROM (tblsponsors, tblgemeenten) WHERE tblsponsors.postnr = tblgemeenten.postnr AND status = " & status1 &_
			" ORDER BY naam"
rs.open sqlString
%>


<table id="sponsortabel">
<thead>
	<tr>
		<th nowrap>id</th>
		<th nowrap>naam</th>
		<th nowrap>adres</th>
		<th nowrap>gemeente</th>
        <th nowrap>btw</th>
        <th nowrap>telnr</th>
        <th nowrap>e-mail</th>
		<th nowrap>contactpersoon</th>
		<th nowrap>verantwoordelijke</th>
		<th nowrap>bedrag</th>
		<th nowrap>contactdatum</th>
	</tr>
</thead>
<tbody>
<%while not rs.eof%>
		<tr onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor='#FFFFFF'" onclick="document.location='sponsorwijzigen.asp?id=<%=rs("id")%>'" style="cursor:hand;cursor:pointer;" bgcolor="#FFFFFF">
		<td nowrap valign="top"><%=rs("id")%></td>
		<td nowrap valign="top"><b><%=rs("naam")%></b></td>
		<td nowrap valign="top"><%=rs("adres")%></td>
		<td nowrap valign="top"><%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></td>
		<td nowrap valign="top"><%=rs("btw")%></td>
		<td nowrap valign="top"><%=rs("telnr")%></td>
		<td nowrap valign="top"><%=rs("email")%></td>
		<td nowrap valign="top"><%=rs("contact")%></td>
		<td nowrap valign="top"><%=rs("verantwoordelijke")%></td>
		<td nowrap valign="top"><%=rs("bedrag")%></td>
		<td nowrap valign="top"><%=rs("contactdatum")%></td>
	</tr>
	<%rs.movenext
wend
rs.close%>
</tbody>
</table>
<%else%>
	<p> Enkel toegankelijk voor bestuur en sponsorcel.</p>
<%end if%>
</div></body>
</html>
