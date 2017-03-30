<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4"
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
<title>Basket Lummen - Ledenlijst</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td,p  {
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
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con



ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 0
ploegid=trim(request("ploegid"))
if ploegid="" or isnull(ploegid) then ploegid = 1

dim order(11)
order(0) = ""
order(1) = "id, "
order(2) = "vblnr, "
order(3) = "geboortedatum, "
order(4) = "geslacht, "
order(5) = "aansluitingsdatum, "
order(6) = "status, "
order(7) = "ploegvorig, "
order(8) = "ploeg1, "
order(9) = "tblleden.niveau, "
order(10) = "functie1, "
if session("BL_soort") < 4 then
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true AND ploegid = "&ploegid&" ORDER BY ploegid"
	rs.open sqlString
elseif session("BL_soort") = 4 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"AND ploegid = "&ploegid&" ORDER BY ploegid"
	rs.open sqlString
end if
%>
<p class="NieuwsTitels"><font size="3"><%=rs("ploegnaam")%></font></p>
<%
rs.close
toon = true
if session("BL_soort") = 4 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE ploegid = " & ploegid & " AND lidid = " & session("BL_lidid")
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true then
	
	sqlString = "SELECT naam, voornaam, adres, tblleden.postnr, gemeente, geboortedatum, telnr, gsm, email, oudersgsm, oudersemail " &_ 
				"FROM (tblleden, tblgemeenten) " &_ 
				"WHERE tblleden.postnr = tblgemeenten.postnr AND (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ") " &_
				"ORDER BY " & order(ord) & "naam, voornaam"
	rs.open sqlString
	%>
	<table>
		<tr>
			<th nowrap>naam</th>
			<th nowrap>adres</th>
			<th nowrap>geboortedatum</th>
			<th nowrap>tel/gsm</th>
			<th nowrap>e-mail</th>
			<th nowrap>ouders gsm</th>
			<th nowrap>ouders e-mail</th>
		</tr>
	<%while not rs.eof
			%><tr>
			<td nowrap valign="top"><%=rs("naam")%>&nbsp;<%=rs("voornaam")%></td>
			<td nowrap valign="top"><%=rs("adres")%><br>
				<%=rs("postnr")%>&nbsp;<%=rs("gemeente")%></td>
			<td nowrap valign="top"><%=rs("geboortedatum")%></td>
			<td nowrap valign="top"><%=rs("telnr")%><br><%=rs("gsm")%></td>
			<td nowrap valign="top"><%=rs("email")%></td>
			<td nowrap valign="top"><%=rs("oudersgsm")%></td>
			<td nowrap valign="top"><%=rs("oudersemail")%></td>
		</tr>
		<%rs.movenext
	wend
	rs.close
end if%>

</table>
</div>
</body>
</html>
