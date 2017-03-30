<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Rock Herk</title>
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

<p align="center"><span class="NieuwsTitels style3">Rock Herk</span></p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	beoordeling = trim(request("beoordeling"))
	volgende = trim(request("volgende"))
	verbeteringen = trim(request("verbeteringen"))
	verbeteringen = Replace(verbeteringen, chr(13) & chr(10), "<br>")
	verbeteringen = Replace(verbeteringen, "'", "´")
	opmerkingen = trim(request("opmerkingen"))
	opmerkingen = Replace(opmerkingen, chr(13) & chr(10), "<br>")
	opmerkingen = Replace(opmerkingen, "'", "´")
	
  sqlstring = "INSERT INTO tblrockherk(naam,algemeen,volgende,verbeteringen,opmerkingen) VALUES('"&naam&"','"&beoordeling&"','"&volgende&"','" & verbeteringen&"','" & opmerkingen&"')"
	con.execute sqlstring	%>
    <p>Bedankt voor uw medewerking.</p>
<%else
%>
<p>

<p>Gelieve hieronder uw opmerkingen over Rock Herk in te vullen.</p>
<p>Alvast bedankt.</p>
<form method="post" action="rockherk.asp">
<table>
	<tr>
      <td nowrap>Naam :</td>
      <td nowrap><input type="text" name="naam" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	<tr>
      <td nowrap>Algemene beoordeling (punten op 5):</td>
      <td nowrap><select name="beoordeling">
      <option value="5">5</option>
       <option value="4">4</option>
        <option value="3" selected>3</option>
         <option value="2">2</option>
          <option value="1">1</option>
           <option value="0">0</option></select>
     </td>
    </tr>
	<tr>
      <td nowrap valign="top">Kunnen we in 2012 opnieuw beroep op u doen?</td>
      <td nowrap><input type="radio" name="volgende" value="ja" checked> Ja, naar alle waarschijnlijkheid wel<br><input type="radio" name="volgende" value="geen idee"> geen idee<br><input type="radio" name="volgende" value="nee"> Nee, naar alle waarschijnlijkheid niet<br>
		</td>
    </tr>
    <tr>
    <td colspan="2">Mogelijke verbeteringen (geef belangrijkste eerst)</td>
    </tr>
    <tr>
    <td>&nbsp;</td>
    <td><textarea name="verbeteringen" rows="15" cols="50"></textarea></td></tr>
    <tr>
    <td colspan="2">Algemene opmerkingen</td>
    </tr>
    <tr>
    <td>&nbsp;</td>
    <td><textarea name="opmerkingen" rows="15" cols="50"></textarea></td></tr>  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden"style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
</div>
</body>
</html>
