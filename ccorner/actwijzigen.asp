<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3"
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
select {
	background-color: #FFFFFF;
	}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Activiteiten</font></p>
<%
id = trim(request("id"))
soort = trim(request("soort"))
if soort <> "" and not isnull(soort) then
	begindatum = trim(request("begindatum"))
	beginuur = trim(request("beginuur"))
	einddatum = trim(request("einddatum"))
	einduur = trim(request("einduur"))
	naam = trim(request("naam"))
	omschrijving = trim(request("omschrijving"))
	locatie = trim(request("locatie"))
	link = trim(request("link"))
	if isnull(beginuur) or beginuur = "" then beginuur = "00:00"
	if isnull(einduur) or einduur = "" then einduur = "00:00"
	begindatum = cdate(begindatum)
	sqlstring = "UPDATE tblactiviteiten SET " &_
		"soort = " & soort & ", begindatum = '"&year(begindatum)&"-"&month(begindatum)&"-"&day(begindatum)&" "&beginuur&":00', "
	if isnull(einddatum) or einddatum = "" then
		sqlstring  = sqlstring & " einddatum = NULL,"
	else
		sqlstring  = sqlstring & " einddatum = '"&year(einddatum)&"-"&month(einddatum)&"-"&day(einddatum)&" "&einduur&":00', "
	end if
	sqlstring = sqlstring & " titel = '"&naam&"', omschrijving = '"&omschrijving&"', locatie = '"&locatie&"', link = '"&link&"', auteur = "&session("BL_lidid") & " WHERE id = " & id
	con.execute sqlstring
	response.Redirect("activiteiten.asp")
end if



sqlString = "SELECT * FROM tblActiviteiten WHERE id = " & id
rs.open sqlString

%>

<p class="NieuwsTitels"><font size="3">Activiteit wijzigen</font></p>
<form method="post" action="actwijzigen.asp?id=<%=id%>">
<table bgcolor="#FFFFFF">

<tr><td>Soort</td>
<td><select name="soort">
		<option value="1"<%if rs("soort") = 1 then response.Write(" selected")%>>Sportief</option>
		<option value="2"<%if rs("soort") = 2 then response.Write(" selected")%>>Extra-sportief</option>
		<option value="3"<%if rs("soort") = 3 then response.Write(" selected")%>>Extern Lummen</option>
	</select>
</td></tr>
<tr><td>Begindatum</td><td><input type="text" name="begindatum" size="12" value="<%=day(rs("begindatum"))%>/<%=month(rs("begindatum"))%>/<%=year(rs("begindatum"))%>" /> <font size="1">(dd/mm/jjjj)</font> - 
Uur <input type="text" name="beginuur" size="7" value="<%=FormatDateTime(rs("begindatum"),4)%>" /> <font size="1">(uu:mm)</font></td></tr>
<tr><td>Einddatum (ev.)</td><td><input type="text" name="einddatum" size="12"
<%if rs("einddatum") <> "" and not isnull(rs("einddatum")) then%>
 	value="<%=day(rs("einddatum"))%>/<%=month(rs("einddatum"))%>/<%=year(rs("einddatum"))%>"
<%end if%>
 /> <font size="1">(dd/mm/jjjj)</font> -  
Uur <input type="text" name="einduur" size="7" 
<%if rs("einddatum") <> "" and not isnull(rs("einddatum")) then%>
 	value="<%=FormatDateTime(rs("einddatum"),4)%>"
<%end if%>
/> <font size="1">(uu:mm)</font></td></tr>
<tr><td>Naam</td><td><input type="text" name="naam" size="60" value="<%=rs("titel")%>" /></td></tr>
<tr><td valign="top">Omschrijving</td><td><textarea name="omschrijving" cols="50" rows="4"><%=rs("omschrijving")%></textarea></td></tr>
<tr><td>Locatie</td><td><input type="text" name="locatie" size="60" value="<%=rs("locatie")%>" /></td></tr>
<tr><td>Externe link</td><td><input type="text" name="link" size="60" value="<%=rs("link")%>" /></td></tr>
</table>
<p><input type="submit" value="wijzigen" /></p>
</form>



</div></body>
</html>
<%
con.close%>