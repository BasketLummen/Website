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
<title>Basket Lummen - Ledenlijst</title>
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
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">

<p class="NieuwsTitels"><font size="3">Gebruiker wijzigen</font></p>
<%
id = trim(request.QueryString("id"))

soort = trim(request.Form("soort"))

if soort <> "" and not isnull(soort) then
	sqlString = "UPDATE tblusers SET "
	if soort = "admin" then
		sqlString = sqlstring & "soort = 2, blocked = 0 "
	elseif soort = "bestuur" then
		sqlString = sqlstring & "soort = 3, blocked = 0 "
	elseif soort = "cellen" then
		sqlString = sqlstring & "soort = 4, blocked = 0 "
	elseif soort = "coach" then
		sqlString = sqlstring & "soort = 5, blocked = 0 "
	elseif soort = "geblokkeerd" then
		sqlString = sqlstring & "soort = 5, blocked = 1 "
	end if
	sqlString = sqlstring & "WHERE lidid = " & id
	con.execute sqlString
	sqlString = "DELETE FROM tblploegedit WHERE lidid = " & id
	con.execute sqlString
	if soort = "coach" or soort = "cellen" then
		sqlString = "SELECT ploegid FROM tblploegen WHERE actief = 1 ORDER BY ploegid"
		rs.open sqlString
		
		while not rs.eof
			pl = trim(request.Form("pl"&rs("ploegid")))
			if pl = "ok" then
				sqlString = "INSERT INTO tblploegedit VALUES(" & id & ", " & rs("ploegid") & ")"
				con.execute sqlString
			end if
			rs.movenext
		wend
	end if
	response.Redirect("gebruikers.asp")
else

sqlString = "SELECT lidid, naam, voornaam, soort, blocked " &_
			"FROM tblusers, tblleden WHERE lidid = id AND soort > 1 AND lidid = " & id
rs.open sqlString

if not rs.eof then%>
<p><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></p>
<form method="post" action="gebruikerwijzigen.asp?id=<%=id%>">
<p>Niveau 
<select name="soort">
<option value="admin"<%if rs("soort") = 2 then response.Write(" selected")%>>Adminstrator</option>
<option value="bestuur"<%if rs("soort") = 3 then response.Write(" selected")%>>Bestuur</option>
<option value="cellen"<%if rs("soort") = 4 then response.Write(" selected")%>>Cellen</option>
<option value="coach"<%if rs("soort") = 5 then response.Write(" selected")%>>Coach</option>
<option value="geblokkeerd"<%if rs("blocked") = 1 then response.Write(" selected")%>>Geblokkeerd</option>
</select></p>
<p class="crij">Uitleg:<br />
Administrator: volledige toegang, inclusief gebruikers wijzigen, sporthalbezetting wijzigen en de documenten van de jeugdcoördinator bekijken.<br />
Bestuur: volledige toegang, maar kan geen gebruikers wijzigen en de documenten van de jeugdcoördinator bekijken.<br />
Coach: leden van zijn eigen ploeg(en) bekijken en wijzigen, van andere ploegen enkel de namen en geboortedatum zien.<br />
Geblokkeerd: kan niet meer inloggen.
</p>

<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con%>
	<p>Ploegen (enkel aan te passen voor coaches):
	<table bgcolor="silver">
	<tr bgcolor="#FFFFFF">
	
	<%rs.close
	sqlString = "SELECT ploegid FROM tblploegedit WHERE lidid = " & id & " ORDER BY ploegid"
	rs.open sqlString

	sqlString = "SELECT ploegid, ploegnaam FROM tblploegen WHERE actief = 1 ORDER BY ploegid"
	rs1.open sqlString
	while not rs1.eof
			tel = tel + 1%>
			<td>
		<label for="<%=rs1("ploegid")%>">
		<input type="checkbox" value="ok" name="pl<%=rs1("ploegid")%>" id="<%=rs1("ploegid")%>" 
		<%if not rs.eof then
			if rs("ploegid") = rs1("ploegid") then%>
				checked
				<%rs.movenext
			end if
		end if%>
		/> 
		<%=rs1("ploegnaam")%>
		</label></td>
		<%rs1.movenext
			if tel = 4 then
				tel = 0
				%></tr><tr bgcolor="#FFFFFF"><%
			end if
	wend
	rs1.close%></tr></table>
	<p><input type="submit" value="opslaan" /></p>
	</form>
<%end if
end if
rs.close%>

</div></body>
</html>
