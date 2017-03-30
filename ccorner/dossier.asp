<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Liddossier</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td, tr, select, input {
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
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 800px;">
<%
id = trim(request("id"))
soort = trim(request("soort"))
uitleg = trim(request("uitleg"))
if uitleg <> "" and not isnull("uitleg") then
	seizoen = trim(request("seizoen"))
	ploeg = trim(request("ploeg"))
	datum = trim(request("datum"))
	uitleg = replace(uitleg,"'","´")
	
	sqlString = "INSERT INTO tbldossiers VALUES("&soort&", "&id&", "&seizoen&", "&ploeg&", '"&_
				year(datum)&"-"&month(datum)&"-"&day(datum)&"','"&uitleg&"', "&session("BL_lidid")&")"
	con.execute sqlstring
	%>
	<p>Gegevens toegevoegd.</p>
<%end if

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

sqlString = "SELECT naam, voornaam, ploeg1, ploeg2 " &_
			"FROM tblleden WHERE id = " & id
rs.open sqlString

ploeg = rs("ploeg1")

toon = true
if session("BL_soort") > 2 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE lidid = " & session("BL_lidid") &_
				" AND (ploegid = " & rs("ploeg1")
	if not isnull(rs("ploeg2")) AND rs("ploeg2") <> "" then
		sqlString = sqlString & " OR ploegid = " & rs("ploeg2")
	end if
	sqlString = sqlString & ")"
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true then%>
	<p>
	<table width="600" cellspacing="0" cellpadding="3" class="menuTitels" onMouseover="this.style.backgroundColor='#FFFFAA';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand">
  <tr align="center">
  	<td bgcolor="#000099" width="125" ><a href="lidwijzigen.asp?id=<%=id%>" class="menuLinks2">Contactgegegens</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=1&id=<%=id%>" class="menuLinks2">Sportief dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="dossier.asp?soort=2&id=<%=id%>" class="menuLinks2">Medisch dossier</a></td>
  	<td bgcolor="#000099" width="125"><a href="aanwperspeler.asp?id=<%=id%>" class="menuLinks2">Aanwezigheden</a></td>
  </tr>
  </table></p>
	<p class="NieuwsTitels"><font size="3">
	<%if soort = 1 then%>
		Sportief 	
	<%else%>
		Medisch 
	<%end if%>
	dossier <%=rs("voornaam")%>&nbsp;<%=rs("naam")%></font></p>
	<p>
	<table width="100%">
	<tr>
		<th>Seizoen</th>
		<th>Ploeg</th>
		<th>Datum</th>
		<th>Uitleg</th>
		<th>Toegevoegd</th>
	</tr>
	<%
	rs.close
	sqlString = "SELECT tblseizoenen.seizoen, ploeg, ploegnaam, datum, uitleg, naam, voornaam " &_
			"FROM tbldossiers " &_
			"LEFT JOIN tblseizoenen ON tbldossiers.seizoen = tblseizoenen.seizoenid " &_
			"LEFT JOIN tblploegen ON tbldossiers.ploeg = ploegid " &_
			"LEFT JOIN tblleden ON tbldossiers.auteur = id " &_
			"WHERE lidid = " & id & " AND soort = " & soort &_
			" ORDER BY tbldossiers.seizoen DESC, datum DESC"
	rs.open sqlSTring
	while not rs.eof%>
		<tr bgcolor="#FFFFFF">
		<td valign="top" nowrap><%=rs("seizoen")%></td>
		<td valign="top" nowrap><%=rs("ploegnaam")%></td>
		<td valign="top" nowrap><%=rs("datum")%></td>
		<td valign="top"><%=rs("uitleg")%></td>
		<td valign="top" nowrap="nowrap"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
		</tr>
		<%rs.movenext
	wend
	rs.close%>
	<form method="post" action="dossier.asp?soort=<%=soort%>&id=<%=id%>">
		<tr>
		<td valign="top"><select name="seizoen">
		<%sqlString = "SELECT * FROM tblSeizoenen WHERE seizoenid > 36 ORDER BY seizoenid"
		rs.open sqlstring
		while not rs.eof
			%><option value="<%=rs("seizoenid")%>"
			<%if rs("seizoenid") = 41 then%>
				selected
			<%end if%>
			><%=rs("seizoen")%></option><%
			rs.movenext
		wend
		rs.close%>
		</select></td>
		<td valign="top"><select name="ploeg">
		<%sqlString = "SELECT * FROM tblploegen WHERE actief = TRUE ORDER BY ploegid"
		rs.open sqlstring
		while not rs.eof
			%><option value="<%=rs("ploegid")%>"<%
			if rs("ploegid") = ploeg then
				%> selected<%
			end if%>><%=rs("ploegnaam")%></option><%
			rs.movenext
		wend
		rs.close%>
		</select></td>
		<td valign="top"><input type="text" name="datum" value="<%=date()%>" size="10"></td>
		<td valign="top"><textarea cols="50" rows="3" name="uitleg"></textarea></td>
		<td valign="top"><input type="submit" value="toevoegen" />
		</tr>
	</form>
	</table>
	<p>
	<img src="../img/driehoek_rood.gif" /> 
	<%if soort=1 then%>
		<a href="dossier.asp?soort=2&id=<%=id%>" class="NieuwsLinks">Medisch dossier</a>
	<%else%>
		<a href="dossier.asp?soort=1&id=<%=id%>" class="NieuwsLinks">Sportief dossier</a>	
	<%end if%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<img src="../img/driehoek_rood.gif" /> <a href="lidwijzigen.asp?id=<%=id%>" class="NieuwsLinks">Lid details</a></p>
	<p><input type="submit" value="wijzigen"></p>
<%end if%>
</div>
</body>
</html>
