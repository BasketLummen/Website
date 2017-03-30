<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Stage -12</title>
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

<p align="center"><span class="NieuwsTitels style3">MINI-Basketkamp</span></p>

<p>2 dagen vol basketplezier onder begeleiding van de coaches van basket Lummen</p>

<p>WIE? Supermicroben (U8), microben (U10), benjamins (U12)<br>
  WAAR?		Gemeentelijke Sporthal Lummen.<br>
WANNEER? maandag 23/12 en maandag 30/12 van 9.00 tot 16.00 u.<br>
KOSTPRIJS? &euro; 15
 voor &eacute;&eacute;n dag, &euro; 20 voor twee dagen.<br>
INSCHRIJVING?	voor  20 december via onderstaand formulier</p>
<p>meer info via <a href="mailto:wendycastro@hotmail.be">wendycastro@hotmail.be</a> of 0472 56 41 85</p>
</p>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	naam = Replace(naam, "'", "´")
	ploeg = trim(request("ploeg"))

  sqlstring = "INSERT INTO tblmin12stage(naam,ploeg) VALUES('"&naam&"','"&ploeg&"')"
	con.execute sqlstring%>
    <p><b>Uw inschrijving is genoteerd.</b></p>
<%else
%>


<form method="post" action="stagemin12.asp">
<table>
	<tr>
      <td nowrap>Naam</td>
      <td nowrap><input type="text" name="naam" size="50" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
    </tr>
	<tr>
      <td nowrap>Ploeg</td>
      <td nowrap><select name="ploeg">
      <option value="Benjamins">Benjamins U12</option>
       <option value="Microben">Microben U10</option>
        <option value="Supermicroben">Supermicroben U8</option>
        </select>
     </td>
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
