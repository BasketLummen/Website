<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Basket Lummen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jquery/jquery-1.4.2.min.js"></script> 
<script type="text/javascript" src="jquery/jquery.validate.min.js"></script>
<style type="text/css">
* { font-family: Verdana; font-size: 96%; }
label { width: 10em; float: left; }
label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
p { clear: both; }
.submit { margin-left: 12em; }
em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
  <script>
  $(document).ready(function(){
    $("#invulForm").validate();
  });
  </script>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">

<%
sub controle_invoer(x)
	if x = "yes" then
		sqlstring = sqlstring & "1,"
	else
		sqlstring = sqlstring & "0,"
	end if
end sub

naam = request("naam")
email = request("email")
if (naam <> "" and not isnull(naam)) or (email <> "" and not isnull(email)) then
	alle_evenementen = request("alle_evenementen")
	eetdag1 = request("eetdag1")
	eetdag2 = request("eetdag2")
	mtb = request("mtb")
	tierock = request("tierock")
	nieuwe_evenementen = request("nieuwe_evenementen")
	tafel_kind = request("tafel_kind")
	tafel_seniors = request("tafel_seniors")
	terreinafg = request("terreinafg")
	bestuur = request("bestuur")
	ploegafg = request("ploegafg")
	sponsors = request("sponsors")
	extra_middelen = request("extra_middelen")
	terrein_klaar = request("terrein_klaar")
	administratie = request("administratie")
	andere = request("andere")

	sqlstring = "INSERT INTO tblhulpvraag1(naam,email,alle_evenementen,eetdag1,eetdag2,mtb,tierock,nieuwe_evenementen,tafel_kind,tafel_seniors,terreinafg,bestuur,ploegafg,extra_sponsors,extra_middelen,terrein_klaarzetten,administratie,andere) VALUES('"&naam&"','"&email&"',"
	controle_invoer(alle_evenementen)
	controle_invoer(eetdag1)
	controle_invoer(eetdag2)
	controle_invoer(mtb)
	controle_invoer(tierock)
	controle_invoer(nieuwe_evenementen)
	controle_invoer(tafel_kind)
	controle_invoer(tafel_seniors)
	controle_invoer(terreinafg)
	controle_invoer(bestuur)
	controle_invoer(ploegafg)
	controle_invoer(sponsors)
	controle_invoer(extra_middelen)
	controle_invoer(terrein_klaar)
	controle_invoer(administratie)
	
	sqlstring = sqlstring &"'"&andere&"')"
	con.execute sqlstring%>
	<p>Uw formulier is verzonden</p>
    <p>Het bestuur dankt u voor uw medewerking.</p>
<%else


%>

 <p>Tijdens de algemene vergadering van 20/12/2010 heeft het bestuur opgeroepen tot hulp. Deze hulp kan er velerlei manieren komen. Om verder te onderzoeken hoe deze eventuele hulp gekanaliseerd kan worden, willen we vragen om snel even enkele vragen te beantwoorden:</p>

<p><b>U bent bereid waar mogelijk om de club te helpen.</b></p>

  <p>Hieronder vindt U een lijstje van mogelijkheden om de club te helpen. Gelieve aan te klikken (meerdere  mogelijkheden mogelijk) waartoe U bereid bent. Indien er functies in die lijst staan  die U reeds vervult, gelieve die ook opnieuw aan te klikken:</p>
<form method="post" action="vraaghulp1.asp" id="invulForm">
  <table><tr><td valign="top">Naam</td><td width="250"><input type="text" name="naam" size="50" class="required" id="cname" minlength="2"></td></tr>
  <tr><td valign="top">E-mail</td><td width="250"><input tabindex="text" name="email" size="50" value="<%=email%>" id="cmail" class="required email"></td></tr></table>
  <p>  Ik ben bereid  een handje toe te steken op de evenementen die Basket Lummen organiseert.<br>Lijst  van de evenementen:<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="alle_evenementen" value="yes"> 
   Alle evenementen wanneer mogelijk.<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="eetdag1" value="yes"> 
   Eetdag 1<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="eetdag2" value="yes"> 
   Eetdag 2<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="mtb" value="yes"> 
   Mountainbike<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="tierock" value="yes"> 
   Tierock<br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="nieuwe_evenementen" value="yes"> 
   Nieuwe evenementen<br/>
   <table><tr><td valign="top">
    <input type="checkbox" name="tafel_kind" value="yes"></td><td> 
    Ik ben bereid  om als tafelfunctionaris te functioneren in de ploeg(en) waar mijn kinderen  meespelen.</td></tr>
    <tr><td valign="top"><input type="checkbox" name="tafel_seniors" value="yes"></td><td> 
    Ik ben bereid  om als tafelfunctionaris te functioneren bij &eacute;&eacute;n van de senioren ploegen (Dames  A en B / Heren A en B)</td></tr>
    <tr><td valign="top"><input type="checkbox" name="terreinafg" value="yes"> </td><td>
    Ik ben bereid  als terreinafgevaardigde te functioneren.</td></tr>
    <tr><td valign="top"><input type="checkbox" name="bestuur" value="yes"> </td><td>
    Ik ben bereid  om als bestuurslid toetreden tot het bestuur.</td></tr>
    <tr><td valign="top"><input type="checkbox" name="ploegafg" value="yes"> </td><td>
    Ik ben bereid  om als ploegafgevaardigde / vrijwilliger te fungeren in de nieuw opgerichte  commissie die gaat trachten een aantal organisaties  op poten te zetten die de jeugdwerking verbeteren, en de communicatie en  interactie tussen het bestuur en de basis te verbeteren, te stroomlijnen.  Eerste vergadering is voorzien begin februari.</td></tr>
    <tr><td valign="top"><input type="checkbox" name="sponsors" value="yes"> </td><td>
    Ik kan aan een  aantal extra sponsors komen.</td></tr>
    <tr><td valign="top"><input type="checkbox" name="extra_middelen" value="yes"> </td><td>
    Ik kan aan een  aantal extra middelen voor de clubwerking komen (ballen, truitjes,  trainingstassen,...)</td></tr>
    <tr><td valign="top"><input type="checkbox" name="terrein_klaar" value="yes"> </td><td>
    Ik ben bereid  om te helpen met het klaarzetten en afbreken van het terrein voor de  wedstrijden van seniors H+D / A+B en andere zoals peanutstornooi startdag,  slotdag,...</td></tr>
    <tr><td valign="top"><input type="checkbox" name="administratie" value="yes"> </td><td>
    Ik ben bereid  op andere vlakken bijvoorbeeld administratie, artikels voor de nieuwsbrief,  foto&rsquo;s, website artikels enz&hellip; mee te werken.</td></tr></table>

<p>Andere voorstellen of opmerkingen:<br>
<textarea name="andere" cols="50" rows="7"></textarea></p>
<p><input type="submit" value="verzenden" class="submit" style="cursor:hand;cursor:pointer"></p>
 </form>
 <%end if%>
</div>
</body>
</html>
