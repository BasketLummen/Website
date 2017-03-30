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
select, td.aanw {
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	border-bottom: #000000 solid 1px;
	border-right: #000000 solid 1px;
	background-color: #FFFFFF;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background:#FFFFFF;
	border-bottom: #000000 solid 1px;
	border-right: #000000 solid 1px;
}
</style>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
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
		response.Redirect("aanwtoevoegen.asp?id="&rs("ploegid"))
	end if	
	
	Set rs1 = Server.CreateObject("ADODB.Recordset")
	rs1.activeconnection = con%>

	<p class="NieuwsTitels"><font size="3">Aanwezigheden op training</font></p>
	<table border="0" cellspacing="0"><tr><td bgcolor="#FFFFFF">
	<form name="jump">
		<p>Ploeg <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
		<%while not rs.eof%>
			<option value="aanwtoevoegen.asp?id=<%=rs("ploegid")%>"<%
			if int(ploegid) = rs("ploegid") then
				%> selected="selected"<%
			end if
			%>><%=rs("ploegnaam")%></option>
			<%rs.movenext
		wend
		rs.close%>
		</select></p>
	</form></td>
	<td valign="top">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="aanwezigheden bekijken" style="cursor:pointer;cursor:hand;" onclick="document.location='aanwezigheden.asp?id=<%=ploegid%>'"onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" ></td>
	</tr></table>

	
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
	
	Set rsCodes = Server.CreateObject("ADODB.Recordset")
	rsCodes.activeconnection = con
	sqlstring = "SELECT code, omschrijving FROM tblaanwcodes ORDER BY code"
	rsCodes.open sqlstring
	
	sqlstring = "SELECT id, voornaam, naam FROM tblleden WHERE (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ")"&_
				" AND status = 'A' AND (functie1 = 1 OR functie2= 1) ORDER BY naam, voornaam"
	rs.open sqlstring
	dim spelersid(30)
	
	terug = 0
	for i = 1 to 10
		dtm = trim(request("datum_"&i))
		if dtm <> "" and not isnull(dtm) then
			terug = 1
			dtm = year(dtm)&"-"&month(dtm)&"-"&day(dtm)
			srt = trim(request("soort_"&i))
			sqlstring = "INSERT INTO tbltrainingen(datum,soort,ploeg,auteur) VALUES('"&dtm&"','"&srt&"',"&ploegid&", " &session("BL_lidid") & ")"
			con.execute sqlstring
			sqlstring = "SELECT id FROM tbltrainingen WHERE id = LAST_INSERT_ID()"
			rs1.open sqlstring
			tr = rs1("id")
			rs1.close
			while not rs.eof
				aanwezig = trim(request("aanw_"&i&"_"&rs("id")))
				sqlstring = "INSERT INTO tblaanwezigheden VALUES("&tr&","&rs("id")&","&aanwezig&")"
				con.execute sqlstring
				rs.movenext
			wend
			rs.movefirst
		end if
	next
	if terug = 1 then
		response.Redirect("aanwezigheden.asp?id="&ploegid)
	end if
	%>
	
	<form method="post" action="aanwtoevoegen.asp?id=<%=ploegid%>">
	<table cellspacing="0">
	<tr valign="top">
	<th width="75">Datum<br>dd/mm/jjjj</th>
	<th width="75">Soort</th>
	<%aantal = 0
	while not rs.eof
		aantal = aantal + 1%>
		<th><%=rs("voornaam")%><br><%=rs("naam")%></th>	
		<%spelersid(aantal) = rs("id")
		rs.movenext
	wend%>
	</tr>
	<%for i = 1 to 10%>
		<tr>
		<td class="aanw"><input type="text" name="datum_<%=i%>" id="datum_<%=i%>" size="10"></td>
		<td class="aanw"><select name="soort_<%=i%>" id="soort_<%=i%>">
		<option value="T">Training</option>
		<option value="M">Match</option>		
		<option value="S">Stage</option>				
		</select></td>
		<%for j = 1 to aantal%>
			<td class="aanw">
			<select name="aanw_<%=i%>_<%=spelersid(j)%>" id="aanw_<%=i%>_<%=spelersid(j)%>">
			<%while not rsCodes.eof%>
				<option value="<%=rsCodes("code")%>"><%=rsCodes("omschrijving")%></option>
				<%rsCodes.movenext
			wend
			rsCodes.movefirst%>
			</select>
			</td>
		<%next%>
		</tr>
	<%next%>
	</table>
	<p><input type="submit" value="opslaan" style="cursor:pointer;cursor:hand;"></p>
	<p><font size="1">Aanwezig ++ = intensiteit extreem goed || Aanwezig + = intensiteit goed || Aanwezig = intensiteit juist voldoende || Aanwezig - = intensiteit onvoldoende<br />Verwittigd = verwittigd afwezig || Afwezig = afwezig zonder verwittiging</font></p>
	</form>
</div>
</body>
</html>
<%rsCodes.close
rs.close
end if
end if
con.close%>
