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
<title>Basket Lummen - Aanwezigheden</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style>
td.aanw {
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
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
</style>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con


ploegid = trim(request("id"))

if ploegid="" or isnull(ploegid) then ploegid = 0

if session("BL_soort") < 3 then
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
	rs.open sqlString
elseif session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"ORDER BY ploegid"
	rs.open sqlString
end if
if rs.eof then%>
	<p>Enkel beschikbaar voor coaches.</p>
<%else
	if ploegid = 0 then
		response.Redirect("aanwezigheden.asp?id="&rs("ploegid"))
	end if

	maand = trim(request("maand"))
	if isnull(maand) or maand = "" then maand = month(date())
	if maand = 6 then maand = 7
	if maand > 6 then
		jaar = 2014
	else
		jaar = 2015
	end if
	vorigedat = cdate("01/"&maand&"/"&jaar)-1%>

	<p class="NieuwsTitels"><font size="3">Aanwezigheden op training</font></p>
	<table border="0" cellspacing="0"><tr><td bgcolor="#FFFFFF">
	<form name="jump">
		<p>Ploeg <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
		<%while not rs.eof%>
			<option value="aanwezigheden.asp?id=<%=rs("ploegid")%>&amp;maand=<%=maand%>"<%
			if int(ploegid) = rs("ploegid") then
				%> selected="selected"<%
			end if
			%>><%=rs("ploegnaam")%></option>
			<%rs.movenext
		wend
		rs.close%>
		</select></p>
	</form></td>
	<td bgcolor="#FFFFFF">
	<form name="jump1">
		<p>Maand <select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=7"<%
			if int(maand) = 7 then
				%> selected="selected"<%
			end if
			%>>Juli</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=8"<%
			if int(maand) = 8 then
				%> selected="selected"<%
			end if
			%>>Augustus</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=9"<%
			if int(maand) = 9 then
				%> selected="selected"<%
			end if
			%>>September</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=10"<%
			if int(maand) = 10 then
				%> selected="selected"<%
			end if
			%>>Oktober</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=11"<%
			if int(maand) = 11 then
				%> selected="selected"<%
			end if
			%>>November</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=12"<%
			if int(maand) = 12 then
				%> selected="selected"<%
			end if
			%>>December</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=1"<%
			if int(maand) = 1 then
				%> selected="selected"<%
			end if
			%>>Januari</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=2"<%
			if int(maand) = 2 then
				%> selected="selected"<%
			end if
			%>>Februari</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=3"<%
			if int(maand) = 3 then
				%> selected="selected"<%
			end if
			%>>Maart</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=4"<%
			if int(maand) = 4 then
				%> selected="selected"<%
			end if
			%>>April</option>
			<option value="aanwezigheden.asp?id=<%=ploegid%>&amp;maand=5"<%
			if int(maand) = 5 then
				%> selected="selected"<%
			end if
			%>>Mei</option>
		</select></p>
	</form>
	</td>
	<td valign="top">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="aanwezigheden toevoegen" style="cursor:pointer;cursor:hand;" onclick="document.location='aanwtoevoegen.asp?id=<%=ploegid%>'"onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" ></td>
	</tr></table>
	<p><font size="1">Groen = intensiteit extreem goed || Wit = intensiteit goed || Geel = intensiteit juist voldoende || Oranje = intensiteit onvoldoende<br />V = verwittigd afwezig || 0 = afwezig zonder verwittiging || G = gekwetst || W = werk || S = studies || Va = Vakantie || Ng = Niet geselecteerd</font></p>

	
	<%
	toon = true
	if session("BL_soort") > 2 then 
		sqlString = "SELECT ploegid FROM tblploegedit WHERE ploegid = " & ploegid & " AND lidid = " & session("BL_lidid")
		rs1.open sqlString
		if rs1.eof then
			toon = false
		end if
		rs1.close
	end if
	if toon = true then
	

		Set rsTrain = Server.CreateObject("ADODB.Recordset")
		rsTrain.activeconnection = con
		sqlstring = "SELECT id, datum, soort FROM tbltrainingen WHERE ploeg = " & ploegid &_
					" AND (year(datum) = "&jaar&" AND (month(datum) = "&maand&""
		if maand = 8 then 'als het augustus is, moeten de trainingen van de laatste week juli ook weergegeven worden
			sqlstring = sqlstring & " OR month(datum) = 7"
		end if
		sqlstring = sqlstring & ")) ORDER BY datum, id"
		rsTrain.open sqlstring
		
		sqlstring = "SELECT id, voornaam, naam FROM tblleden WHERE (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ")"&_
					" AND status = 'A' AND (functie1 = 1 OR functie2= 1) ORDER BY naam, voornaam"
		rs.open sqlstring
		dim spelersid(30,2)
		
	
		%>
		
	
		<table cellspacing="0">
		<tr valign="top">
		<th width="75">Datum</td>
		<%aantal = 0
		while not rs.eof
			aantal = aantal + 1%>
			<th width="75" nowrap="nowrap"><%=rs("voornaam")%><br><%=rs("naam")%></th>	
			<%spelersid(aantal,0) = rs("id")
			spelersid(aantal,1) = 0
			rs.movenext
		wend
		rs.close%>
		<th width="75">Aantal</th>
		</tr>
		<%while not rsTrain.eof
			while (rsTrain("datum")-vorigedat) > 1
				vorigedat = vorigedat + 1%>
				<tr bgcolor="#BBBBBB"><td class="aanw"><%=weekdayname(weekday(vorigedat),true)%>&nbsp;<%=day(vorigedat)%>&nbsp;<%=monthname(month(vorigedat),true)%></td>
				<%for i = 1 to aantal + 2%>
					<td class="aanw">&nbsp;</td>
				<%next%>
				</tr>
			<%wend
			if rsTrain("soort") = "T" then
				kl = ""
			elseif rsTrain("soort") = "M" then
				kl = "#FFFF99"
			elseif rsTrain("soort") = "S" then
				kl = "#0099FF"
			end if%>
			<tr>
			<td bgcolor="<%=kl%>" class="aanw"><%=weekdayname(weekday(rsTrain("datum")),true)%>&nbsp;<%=day(rsTrain("datum"))%>&nbsp;<%=monthname(month(rsTrain("datum")),true)%></td>
			<%deelnemers = 0
			for i = 1 to aantal
				sqlstring = "SELECT code, aanwezig, korteomschr FROM tblaanwezigheden, tblaanwcodes " &_ 
							"WHERE aanwezig = code AND training="&rsTrain("id")&" AND speler = " & spelersid(i,0)
				rs.open sqlstring%>
				<%if rs.eof then%>
					<td bgcolor="#CCCCCC" class="aanw">&nbsp;</td>
				<%else
					select case rs("code")
						case 1 
							kl = "#33FF99"
						case 2
							kl = "#FFFFFF"
						case 3 
							kl = "#FFFF00"
						case 4
							kl = "#FF9900"
						case else
							kl = "#DDDDDD"
					end select
					if rs("aanwezig") > 0 and rs("aanwezig") < 5 then
						deelnemers = deelnemers + 1
						spelersid(i,1) = spelersid(i,1) + 1
					end if%>
					<td align="center" bgcolor="<%=kl%>" class="aanw"><%=rs("korteomschr")%>&nbsp;</td>
				<%end if
				rs.close
			next%>
			<td align="center" bgcolor="#FFFF99" class="aanw"><b><%=deelnemers%></b>&nbsp;</td>
			<td align="center" onClick="if(confirm('Bent u zeker dat u deze training wilt verwijderen?',false))document.location='aanwverwijderen.asp?id=<%=rsTrain("id")%>';" class="aanw">
			<img src="../img/delete.gif" alt="Verwijderen" border="0" style="cursor:hand;cursor:pointer;"></td>
			</tr>
			<%vorigedat = rsTrain("datum")
			rsTrain.movenext
		wend%>
		<tr bgcolor="#FFFF99"><td class="aanw"><b>Aantal</b></td>
		<%for i = 1 to aantal%>
			<td align="center" class="aanw"><b><%=spelersid(i,1)%></b>&nbsp;</td>
		<%next%></tr>
		</table>
		<%
		rsTrain.close
	end if
end if%>
</div>
</body>
</html>
<%
con.close%>
