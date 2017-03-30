<!--#include file="ccorner/connect.asp" -->
<%toon=4%>
<%Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Function CheckCAPTCHA(valCAPTCHA)
	SessionCAPTCHA = Trim(Session("CAPTCHA"))
	Session("CAPTCHA") = vbNullString
	if Len(SessionCAPTCHA) < 1 then
        CheckCAPTCHA = False
        exit function
    end if
	if CStr(SessionCAPTCHA) = CStr(valCAPTCHA) then
	    CheckCAPTCHA = True
	else
	    CheckCAPTCHA = False
	end if
End Function
%>
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
<%

naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	strCAPTCHA = Trim(Request.Form("strCAPTCHA"))
	if CheckCAPTCHA(strCAPTCHA) = true then
		naam = Replace(naam, "'", "´")
		voornaam = trim(request("voornaam"))
		voornaam = Replace(voornaam, "'", "´")
		wachtwoord1 = trim(request("wachtwoord1"))
		wachtwoord2 = trim(request("wachtwoord2"))
		email = trim(request("email"))
		if voornaam = "" or wachtwoord1 = "" or wachtwoord2 = "" then %>
			<p>U hebt niet alle gegevens ingevuld, probeer opnieuw.</p>
		<%elseif wachtwoord1 <> wachtwoord2 then%>
			<p>Uw wachtwoord komt niet overeen, probeer opnieuw.</p>
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
						"'" & wachtwoord1 & "', '" & email & "',0)"
			con.execute sqlString
			sqlString = "SELECT matchnr FROM tblpronowedstrijden ORDER BY matchnr"
			rs.open sqlstring
			while not rs.eof
				sqlString = "INSERT INTO tblpronostiek VALUES(" & mnr & ", " & rs("matchnr") & ", null)"
				con.execute sqlString
				rs.movenext
			wend
			rs.close%>
			<p>Proficiat, <%=voornaam%>&nbsp;<%=naam%>, u bent succesvol geregistreerd. 
			U kan nu <a href="pronoinloggen.asp?dn=<%=mnr%>" class=hotnews>inloggen</a> om uw pronostiek voor de volgende speeldag te geven.</p>
		<%end if
	else
		verkeerde = true	
	end if
end if%>



<form name="registreren" method="POST" action="pronoregistreren.asp">
<table width="450" border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td colspan="4" nowrap align="center" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Geef uw gegevens om te registreren</td>
	</tr>
	<tr> 
		<td>Naam:</td>
		<td><input name="naam" type="text" id="naam" tabindex="1" value="<%=naam%>" size="40" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	<tr> 
		<td>Voornaam:</td>
		<td><input name="voornaam" type="text" id="voornaam" tabindex="1" value="<%=voornaam%>" size="40" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	<tr> 
		<td>Wachtwoord:</td>
		<td><input name="wachtwoord1" type="password" id="wachtwoord1" tabindex="2" size="40" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	<tr> 
		<td>Herhaal wachtwoord:</td>
		<td><input name="wachtwoord2" type="password" id="wachtwoord2" tabindex="3" size="40" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	<tr> 
		<td>E-mailadres:</td>
		<td><input name="email" type="text" id="email" tabindex="4" value="<%=email%>" size="40" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	  <tr><td colspan="2">
	  <%if verkeerde = true then%>
			<b>U hebt een verkeerd getal ingegeven, probeer opnieuw</b><br>
	  		Vul ter controle onderstaand getal in het volgende veld in:
	  <%else%>
	  		Vul ter controle onderstaand getal in het volgende veld in:
	  <%end if%>
	  </td>
	  </tr>
	  <tr>
	  	<td><img src="aspcaptcha.asp" alt="This Is CAPTCHA Image" width="86" height="21" /></td>
		<td><input name="strCAPTCHA" type="text" id="strCAPTCHA" tabindex="5" maxlength="8" /></td>
	  </tr>
	<tr> 
		<td align="center" bgcolor="#DDDDDD" colspan="2"><input type="submit" name="Submit" value="Registreren" tabindex="6" style="background-color='#FFFF00';"> 
		</td>
	</tr>
</table>
</form>
<script language="javascript">
  document.registreren.naam.focus();
</script>
</div>
</body>
</html>
<%con.close%>