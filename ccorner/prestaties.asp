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
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
input {
	border: 1px solid #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #000000;
}
</style>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<p class="titel"><font size="3">Onkosten declaratie</font></p>

<%
if session("BL_soort") < 2 or session("BL_lidid") = 185 or session("BL_lidid") = 242 then
	lidid = trim(request("lidid"))
else
	lidid = session("BL_lidid")
end if

maand = trim(request("maand"))
if isnull(maand) or maand = "" then maand = month(date())
if maand > 6 then
	jaar = 2015
else
	jaar = 2016
end if


'opslaan van de prestaties
for i = 1 to 10
	dtm = trim(request("datum_"&i))
	if dtm <> "" and not isnull(dtm) then
		dtm = year(dtm)&"-"&month(dtm)&"-"&day(dtm)
		ploeg = trim(request("ploeg_"&i))
		activiteit = trim(request("activiteit_"&i))
		km = trim(request("km_"&i))
		if isnull(km) or km="" then km = 0
		sqlstring = "insert into tblprestaties(coach,ploeg,datum,activiteit,km) values("&session("BL_lidid")&","&ploeg&",'"&dtm&"',"&activiteit&","&km&")"
		con.execute sqlstring
	end if
next



'admins mogen alles zien
if session("BL_soort") < 2 or session("BL_lidid") = 185 or session("BL_lidid") = 242 then%>
<form name="jump0">
	<p class="nieuws">Coach / Speler <select name="menu" onChange="location=document.jump0.menu.options[document.jump0.menu.selectedIndex].value;" value="GO">
	<%sqlstring = "SELECT id, naam, voornaam FROM tblleden WHERE STATUS = 'A' AND (functie1 = 2 OR functie2 = 2) ORDER BY naam, voornaam"
	rs.open sqlstring
	if lidid = "" or isnull(lidid) then
		lidid = rs("id")
	end if
	while not rs.eof%>
			<option value="prestaties.asp?lidid=<%=rs("id")%>&amp;maand=<%=maand%>"<%
			if int(lidid) = rs("id") then
				%> selected="selected"<%
			end if
			%>><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
	    <%rs.movenext
	wend
	rs.close%>
		</select></p>
	</form> 

<%end if%>










<form name="jump1">
		<p class="nieuws">Maand <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=7"<%
			if int(maand) = 7 then
				%> selected="selected"<%
			end if
			%>>Juli</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=8"<%
			if int(maand) = 8 then
				%> selected="selected"<%
			end if
			%>>Augustus</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=9"<%
			if int(maand) = 9 then
				%> selected="selected"<%
			end if
			%>>September</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=10"<%
			if int(maand) = 10 then
				%> selected="selected"<%
			end if
			%>>Oktober</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=11"<%
			if int(maand) = 11 then
				%> selected="selected"<%
			end if
			%>>November</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=12"<%
			if int(maand) = 12 then
				%> selected="selected"<%
			end if
			%>>December</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=1"<%
			if int(maand) = 1 then
				%> selected="selected"<%
			end if
			%>>Januari</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=2"<%
			if int(maand) = 2 then
				%> selected="selected"<%
			end if
			%>>Februari</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=3"<%
			if int(maand) = 3 then
				%> selected="selected"<%
			end if
			%>>Maart</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=4"<%
			if int(maand) = 4 then
				%> selected="selected"<%
			end if
			%>>April</option>
			<option value="prestaties.asp?lidid=<%=lidid%>&amp;maand=5"<%
			if int(maand) = 5 then
				%> selected="selected"<%
			end if
			%>>Mei</option>
		</select></p>
	</form>



<table cellspacing="0">
<tr valign="top">
<th width="75">Datum<br>dd/mm/jjjj</th>
<th width="75">Ploeg</th>
<th width="75">Activiteit</th>
<th width="75">KM (event.)</th>
<th></th>
</tr>
<%
sqlstring = "SELECT id, tblPrestaties.coach, ploegnaam, datum, activiteit, km FROM tblPrestaties, tblPloegen WHERE ploegid = ploeg AND tblPrestaties.coach = "&lidid&" AND month(datum) = "&maand&" ORDER BY datum, ploegid, activiteit"
rs.open sqlstring

trainingen = 0
vervanging = 0
kmtot = 0
matchen = 0
peanuts = 0
while not rs.eof	
	kmtot = kmtot + rs("km")%>
	<tr>
    	<td align="center" class="aanw"><%=rs("datum")%></td>
        <td class="aanw"><%=rs("ploegnaam")%></td>
        <td class="aanw"><%
		Select case rs("activiteit")
			case 1:
				response.Write("Training")
				trainingen = trainingen + 1
			case 2:
				response.Write("Match")
				matchen = matchen + 1
			case 3:
				response.Write("Peanuts")
				peanuts = peanuts + 1
			case 4:
				response.Write("Vervangingstraining")
				vervanging = vervanging + 1
		end select
		%></td>
        <td align="center" class="aanw"><%=rs("km")%></td>
<td align="center" onClick="if(confirm('Bent u zeker dat u deze prestatie wilt verwijderen?',false))document.location='prestverwijderen.asp?id=<%=rs("id")%>';" class="aanw">
			<img src="../img/delete.gif" alt="Verwijderen" border="0" style="cursor:hand;cursor:pointer;"></td> 
           
    </tr>
	<%rs.movenext
wend
rs.close
%>
</table>
<p class="nieuws"><b>
Totaal aantal trainingen = <%=trainingen%><br />
Totaal aantal vervangingstrainingen = <%=vervanging%><br />
Totaal aantal km = <%=kmtot%><br />
Totaal aantal matchen = <%=matchen%><br />
Totaal aantal peanuts = <%=peanuts%></b></p>
<p class="titel"><font size="3">Toevoegen prestaties</font></p>

<form method="post" action="prestaties.asp">
	<table cellspacing="0">
	<tr valign="top">
	<th width="75">Datum<br>dd/mm/jjjj</th>
	<th width="75">Ploeg</th>
	<th width="75">Activiteit</th>
    <th width="75">Km (event.)</th>
	</tr>
	<%
	if session("BL_soort") > 2 then
		sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
					"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
					"ORDER BY ploegid"
		rs.open sqlString
		if not rs.eof then
			ploegcoach=rs("ploegid")
		end if
		rs.close
	elseif session("BL_lidid") then
		ploegcoach = 6
	end if
	
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
	rs.open sqlString
	for i = 1 to 10%>
		<tr>
		<td class="aanw"><input type="text" name="datum_<%=i%>" id="datum_<%=i%>" size="10"></td>
        <td class="aanw"><select name="ploeg_<%=i%>">
		<%while not rs.eof%>
			<option value="<%=rs("ploegid")%>"<%
				if rs("ploegid") = ploegcoach then
					%> selected<%
				end if
			%>><%=rs("ploegnaam")%></option>
			<%rs.movenext
		wend
		rs.movefirst
		%></select>
       </td>
		<td class="aanw" align="center"><select name="activiteit_<%=i%>" id="activiteit_<%=i%>" class="clsActiviteit">
		<option value="1">Training</option>
		<option value="4">Vervangingstraining</option>		
		<option value="2">Match</option>		
		<option value="3">Peanuts</option>				
		</select></td>
        <td class="aanw"><input type="text" name="km_<%=i%>" id="km_<%=i%>" />
		</tr>
	<%next%>
	</table>
	<p><input type="submit" value="opslaan" style="cursor:pointer;cursor:hand;" onmouseover="style.backgroundColor='#33FF00';" onmouseout="style.backgroundColor=''"></p>
	</form>
<%
if session("BL_soort") < 2 or session("BL_lidid") = 185 or session("BL_lidid") = 242 then%>

<form><input type=button name=print value="Afdrukken" onClick="javascript:window.print()" style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#33FF00';" onmouseout="style.backgroundColor=''"></form>
<p><a href="#" onClick="window.open('prestaties_overzicht.asp?maand=<%=maand%>','','width=750,height=600,scrollbars=yes,resizable=yes,toolbar=yes');return(false)" class="link">Overzicht per maand</a></p>
<%elseif session("BL_soort") = 6 then%>
	<p><a href="index.asp" class="link">Uitloggen</a></p>


<%end if%>
</div>
</body>
</html>
<%
con.close%>
