<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Stage</title>
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

<p align="center"><span class="NieuwsTitels style3">Kerststage U14-U12-U10-U8</span></p>

<p>Het is weer bijna vakantie, dus is het ook weer tijd voor onze jaarlijkse kerststage. <br>
  <br>
  Heb jij ook zin om je basketskills bij te schaven? Schrijf je dan nu in voor onze kerststage!
  <br>
  <br>
  <strong>De U8/U10-kadees</strong> (van Eva en Marlies, Audrey, Loes, Hanne en Andreas) <br>
  kunnen komen zweten op dinsdag 3/1 en woensdag 4/1  van 10u tot 13u. <br>
  <br>
  <strong>De U12-helden</strong> (van Davina en Peter, Caro) <br>
  zijn welkom op dinsdag 3/1 en donderdag 5/1 van 13u tot 16u. <br>
  <br>
  <strong>De U14-sterren</strong> (van Brecht en Stefan) <br>
  kunnen komen trainen op woensdag 4/1 en donderdag 5/1 van 13u tot 16u. <br>
  <br>
  Inschrijving kost 5 euro per halve dag. <br>
  Je kan dit overschrijven op rekeningnummer&nbsp;BE16 3630 4262 5274.</p>
<p>Inschrijven kan via onderstaand formulier</p>
</p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	ploeg = trim(request("ploeg"))
	dinsdag = trim(request("dinsdag"))
	woensdag  = trim(request("woensdag"))
	donderdag = trim(request("donderdag"))
	

  sqlstring = "INSERT INTO tblmin12stage(naam,ploeg,dinsdag,woensdag,donderdag) VALUES('"&naam&"','"&ploeg&"','"&dinsdag&"','"&woensdag&"','"&donderdag&"')"
	con.execute sqlstring%>
    <p><b>Uw inschrijving is genoteerd.</b></p>
<%else
%>


<form method="post" action="stage.asp">
<table>
	<tr>
      <td nowrap>Naam</td>
      <td nowrap><input type="text" name="naam" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
<tr>
      <td nowrap>Ploeg</td>
      <td nowrap><select name="ploeg">
     <option value="U12">U14</option>
    <option value="U12">U12</option>
       <option value="U10">U10</option>
        <option value="U8">U8</option>
        </select>
     </td>
    </tr>
    <tr>
    <td colspan="2">
    <label for="dinsdag"><input type="checkbox" name="dinsdag" id="dinsdag">
    &nbsp;Dinsdag 3/1</label> <label for="woensdag"><input type="checkbox" name="woensdag" id="woensdag">
    &nbsp;woensdag 4/1 </label><label for="donderdag"><input type="checkbox" name="donderdag" id="donderdag">
    &nbsp;donderdag 5/1</label></td>
    </tr>
	 </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden"style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
