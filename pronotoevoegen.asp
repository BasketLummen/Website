<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="cconer/connect.asp" -->
<%
naam = trim(request("naam"))
naam = Replace(naam, "'", "´")
voornaam = trim(request("voornaam"))
voornaam = Replace(voornaam, "'", "´")
wachtwoord1 = trim(request("wachtwoord1"))
wachtwoord2 = trim(request("wachtwoord2"))
email = trim(request("email"))
%>
<%toon=4%>
<html>
<head>
<title>Basket Lummen - Pronostiek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<%if naam = "" or voornaam = "" or wachtwoord1 = "" or wachtwoord2 = "" then %>
	<p>U hebt niet alle gegevens ingevuld, probeer opnieuw.</p>
	<form method="post" action="pronoregistreren.asp">
	<input type=hidden name=naam value=<%=naam%>>
	<input type=hidden name=voornaam value=<%=voornaam%>>
	<input type=hidden name=email value=<%=email%>>
	<input type=submit value="Terug">
	</form>
<%elseif wachtwoord1 <> wachtwoord2 then%>
	<p>Uw wachtwoord komt niet overeen, probeer opnieuw.</p>
	<form method="post" action="pronoregistreren.asp">
	<input type=hidden name=naam value=<%=naam%>>
	<input type=hidden name=voornaam value=<%=voornaam%>>
	<input type=hidden name=email value=<%=email%>>
	<input type=submit value="Terug">
	</form>
<%else
	sqlString = "SELECT max(spelernr) AS mnr FROM tblpronodeelnemers"
	rs.open sqlString
	if isnull(rs("mnr")) or rs("mnr") = "" then
		mnr = 1
	else
		mnr = rs("mnr") + 1
	end if
	rs.close
	sqlString = "INSERT INTO tblpronodeelnemers VALUES(" & mnr & ", '" & naam & "', '" & voornaam & "', " &_ 
				"'" & wachtwoord1 & "', '" & email & "')"
	con.execute sqlString
	for i = 1 to 278
		sqlString = "INSERT INTO tblpronostiek VALUES(" & mnr & ", " & i & ", null)"
		con.execute sqlString
	next%>
	<p>Proficiat, <%=voornaam%>&nbsp<%=naam%>, u bent succesvol geregistreerd. U kan nu <a href="pronoinloggen.asp?dn=<%=mnr%>" class=hotnews>inloggen</a> om uw pronostiek voor de volgende speeldag te geven.</p>
<%end if%>
</div>
</body>

</html>