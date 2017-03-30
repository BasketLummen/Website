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
<!--#include file="connect.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Basket Lummen - Onkosten</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style>
td {
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
td.aanw {
	border-bottom: #000000 solid 1px;
	border-right: #000000 solid 1px;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background:#FFFFFF;
	border-bottom: #000000 solid 1px;
	border-right: #000000 solid 1px;
}
select {
	background-color:#FFFFFF;
}
input {
	border: 1px solid #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #000000;
}
</style>
<body style="background-color:#FFFFFF">
<%
maand = trim(request("maand"))
if isnull(maand) or maand = "" then maand = month(date())
if maand > 6 then
	jaar = 2015
else
	jaar = 2016
end if
%>
<p class="titel"><font size="3">Onkosten overzicht per paand</font></p>
<form name="jump1">
		<p class="nieuws">Maand <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
			<option value="prestaties_overzicht.asp?maand=7"<%
			if int(maand) = 7 then
				%> selected="selected"<%
			end if
			%>>Juli</option>
			<option value="prestaties_overzicht.asp?maand=8"<%
			if int(maand) = 8 then
				%> selected="selected"<%
			end if
			%>>Augustus</option>
			<option value="prestaties_overzicht.asp?maand=9"<%
			if int(maand) = 9 then
				%> selected="selected"<%
			end if
			%>>September</option>
			<option value="prestaties_overzicht.asp?maand=10"<%
			if int(maand) = 10 then
				%> selected="selected"<%
			end if
			%>>Oktober</option>
			<option value="prestaties_overzicht.asp?maand=11"<%
			if int(maand) = 11 then
				%> selected="selected"<%
			end if
			%>>November</option>
			<option value="prestaties_overzicht.asp?maand=12"<%
			if int(maand) = 12 then
				%> selected="selected"<%
			end if
			%>>December</option>
			<option value="prestaties_overzicht.asp?maand=1"<%
			if int(maand) = 1 then
				%> selected="selected"<%
			end if
			%>>Januari</option>
			<option value="prestaties_overzicht.asp?maand=2"<%
			if int(maand) = 2 then
				%> selected="selected"<%
			end if
			%>>Februari</option>
			<option value="prestaties_overzicht.asp?maand=3"<%
			if int(maand) = 3 then
				%> selected="selected"<%
			end if
			%>>Maart</option>
			<option value="prestaties_overzicht.asp?maand=4"<%
			if int(maand) = 4 then
				%> selected="selected"<%
			end if
			%>>April</option>
			<option value="prestaties_overzicht.asp?maand=5"<%
			if int(maand) = 5 then
				%> selected="selected"<%
			end if
			%>>Mei</option>
		</select></p>
	</form>
<%
'Coaches

sqlstring = "SELECT id, naam, voornaam FROM tblleden WHERE STATUS = 'A' AND (functie1 = 2 OR functie2 = 2) ORDER BY naam, voornaam"
rs.open sqlstring

%>

<table cellspacing="0">
<tr valign="top">
<th width="75">Naam</th>
<th width="75">Trainingen</th>
<th width="75">Vervangingstrainingen</th>
<th width="75">Matchen</th>
<th width="75">Peanuts</th>
<th width="75">KM</th>
</tr>
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

while not rs.eof
	sqlstring = "SELECT id, tblPrestaties.coach, datum, activiteit, km FROM tblPrestaties, tblPloegen WHERE ploegid = ploeg AND tblPrestaties.coach = "&rs("id")&" AND month(datum) = "&maand&" ORDER BY datum, ploegid, activiteit"
	rs1.open sqlstring		
	trainingen = 0
	vervanging = 0
	kmtot = 0
	matchen = 0
	peanuts = 0
	while not rs1.eof	
		kmtot = kmtot + rs1("km")
		Select case rs1("activiteit")
			case 1:
				trainingen = trainingen + 1
			case 2:
				matchen = matchen + 1
			case 3:
				peanuts = peanuts + 1
			case 4:
				vervanging = vervanging + 1
		end select
		rs1.movenext
	wend%>
	<tr>
    	<td class="aanw" nowrap="nowrap"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
    	<td align="center" class="aanw"><%=trainingen%></td>
     	<td align="center" class="aanw"><%=vervanging%></td>
	   	<td align="center" class="aanw"><%=matchen%></td>
    	<td align="center" class="aanw"><%=peanuts%></td>
    	<td align="center" class="aanw"><%=kmtot%></td>
    </tr>
	<%rs1.close
	rs.movenext
wend
rs.close
%>
</table>

<p>&nbsp;</p>
<form><input type=button name=print value="Afdrukken" onClick="javascript:window.print()" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#33FF00';" onmouseout="style.backgroundColor=''"></form>
</body>
</html>
<%
con.close%>
