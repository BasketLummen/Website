<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Extra activiteiten</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">

<p align="center"><span class="NieuwsTitels style3">Extra activieiten</span></p>

<p>Elke jaar is het voor ons als bestuur een gevecht om de financiële knoopjes aan mekaar te binden. Voor dit seizoen stelt zich een nieuwe uitdaging. We zijn een aantal belangrijke sponsors kwijt. De afgelopen maanden hebben we getracht hun te vervangen door nieuwe sponsors maar helaas slechts met een minimaal succes. Dus moeten we op zoek naar alternatieven. Door onze samenwerking met Zolder zijn we er in geslaagd om als vrijwilligers te mogen gaan helpen op een aantal evenementen in de Ethias Arena en Heizel.<br>
Doordat we een aantal vrijwilligers kunnen sturen om te helpen, kunnen we onze schatkist terug spijzen en onze club uit moeilijk vaarwater houden.<br>
Daarom willen we een beroep doen op jullie om te komen helpen. Hieronder vind je een formulier waar je kan inschrijven om te helpen.
</p>
<p>Wat hebben we nodig. Uiteraard je naam en ook je rijksregisternummer. Voorwaarden om te helpen: meerderjarig zijn, geen alcohol drinken tijdens het evenement, niet werkloos of bruggepensioneerd zijn. We willen beroep doen op iedereen: onze spelers, coaches, bestuursleden, ouders en supporters. En hopen dan ook dat we voldoende ‘chinese vrijwilligers’ vinden.</p>
<p>In het voorjaar volgen er opnieuw een aantal evenementen waar we als club een extraatje  verdienen, maar hierover later meer en eerst willen we een goed figuur slaan en onze helpende vrienden van Zolder niet ontgoochelen.</p>
</p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	rijksregister = trim(request("rijksregister"))
	gsmnr = trim(request("gsmnr"))
	email = trim(request("email"))
	keuze_1  = trim(request("keuze_1"))
	keuze_2  = trim(request("keuze_2"))
	keuze_3  = trim(request("keuze_3"))
	keuze_5  = trim(request("keuze_5"))
	keuze_6  = trim(request("keuze_6"))
	keuze_7  = trim(request("keuze_7"))
	keuze_8  = trim(request("keuze_8"))
	if keuze_1 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(1,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_2 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(2,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_3 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(3,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_5 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(5,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_6 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(6,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_7 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(7,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if
	if keuze_8 = "ok" then
		sqlstring = "INSERT INTO tblethiasdeelnemers(id,naam,rijksregister,gsmnr,email) VALUES(8,'"&naam&"','"&rijksregister&"','"&gsmnr&"','"&email&"')"
		con.execute sqlstring
	end if

 %>
    <p><b>Uw inschrijving is genoteerd. U krijgt een van de volgende dagen een bevestiging via e-mail.</b></p>
<%else
%>


<form method="post" action="extraactiviteiten.asp">
<table>
	<tr>
      <td nowrap>Naam</td>
      <td nowrap><input type="text" name="naam" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
    	<tr>
      <td nowrap>Rijksregisternummer</td>
      <td nowrap><input type="text" name="rijksregister" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	<tr>
      <td nowrap>GSM-nummer</td>
      <td nowrap><input type="text" name="gsmnr" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	<tr>
      <td nowrap>E-mail</td>
      <td nowrap><input type="text" name="email" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	 </table>
  <p>Duid aan welke activiteiten je wil helpen, je krijgt bevestiging via e-mail.</p>   
  <table border="1" cellspacing="0">
  <tr><td>Datum</td><td>Activiteit</td><td>Plaats</td><td>Uren</td><td align="center">Aantal<br>nodig</td><td align="center">Aantal<br>bevestigd</td><td>Keuze</td></tr>
  <%
  set rs2 = server.createobject("adodb.recordset")
  rs2.activeconnection = con
  sqlstring = "SELECT * FROM tblethiasactiviteiten WHERE datum >= CURDATE() ORDER BY datum, id"
  rs.open sqlstring
  while not rs.eof
  	sqlstring = "select COUNT(*) as totaal from tblethiasdeelnemers where akkoord = 1 and id = "&rs("id")
  	rs2.open sqlstring
  	%>
  	<tr>
  		<td><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td><td><%=rs("naam")%></td><td><%=rs("plaats")%></td><td><%=rs("uren")%></td><td align="center"><%=rs("aantal")%></td><td align="center"><%=rs2("totaal")%></td><td align="center">
        <%if cint(rs("aantal")) =< cint(rs2("totaal")) then%>
        	VOLZET
        <%else%>
        <input type="checkbox" value="ok" name="keuze_<%=rs("id")%>">
        <%end if%></td>
    </tr>
  	<%rs2.close
	rs.movenext
  wend
  %>
  
  
  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden"style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
