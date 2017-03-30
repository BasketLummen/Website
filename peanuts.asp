<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Peanuts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
club = trim(request("club"))
if club <> "" and not isnull(club) then
	naam = trim(request("naam"))
	email = trim(request("email"))
	beginners = trim(request("beginners"))
	matig = trim(request("matig"))
	gevorderd = trim(request("gevorderd"))
	sqlstring = "INSERT INTO tblpeanuts(club,naam,email,beginners,matig,gevorderd) values('"&club&"','"&naam&"','"&email&"','"&beginners&"','"&matig&"','"&gevorderd&"')"
	con.execute sqlstring
	%>	
	<p>Uw inschrijving is genoteerd</p>
<%else%>
<p align="center" class="NieuwsTitels"><font size="4">Inschrijven Peanutstornooi</font></p>
<p>Op vrijdag 11/11 organiseert Basket Lummen opnieuw het jaarlijks 
peanutstornooi.<br>
Dit zal doorgaan van 9u - 12u in Sporthal Vijfsprong (Sportweg 8, Lummen).</p>
<p> Gelieve in te schrijven voor 6/11 via onderstaand formulier</p>
<p>Uw inschrijving is pas bevestigd wanneer u een antwoordmail hebt ontvangen van Bea Coenen. Heeft u deze niet ontvangen op 6/11, gelieve dan contact te nemen via <a href="mailto:coenenbea@hotmail.com">coenenbea@hotmail.com</a>.</p>
<form name="myform" id="myform" method="post" action="peanuts.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr>
      <td nowrap="nowrap" >Naam club</td>
      <td nowrap="nowrap" >
        <input name="club" type="text" id="club" tabindex="1" size="50">
        </td>
    </tr>
    <tr>
      <td nowrap="nowrap" >Naam verantwoordelijke</td>
      <td nowrap="nowrap" ><input name="naam" type="text" id="naam" tabindex="1" size="50"></td>
    </tr>
    <tr>
      <td nowrap="nowrap" >E-mail verantwoordelijke</td>
      <td nowrap="nowrap" ><input name="email" type="text" id="email" tabindex="1" size="50"></td>
    </tr>
    <tr>
      <td colspan="2" valign="top" nowrap="nowrap">Aantal ploegjes</td>
    </tr>
    <tr>
      <td nowrap="nowrap" valign="top"><blockquote>
        <p>Beginners</p>
      </blockquote></td>
      <td nowrap="nowrap" >
        <input name="beginners" type="text" id="beginners" tabindex="2" size="5" maxlength="5">
        </td>
    </tr>
    <tr>
      <td nowrap="nowrap" valign="top"><blockquote>
        <p>Matig</p>
      </blockquote></td>
      <td nowrap="nowrap" ><input name="matig" type="text" id="matig" tabindex="2" size="5" maxlength="5"></td>
    </tr>
    <tr>
      <td nowrap="nowrap" valign="top"><blockquote>
        <p>Gevorderd</p>
      </blockquote></td>
      <td nowrap="nowrap" ><input name="gevorderd" type="text" id="gevorderd" tabindex="2" size="5" maxlength="5"></td>
    </tr>
  </table>
  <br>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="3" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
</form>
<%end if%>
<div id="overzicht"></div>
</div>
</body>
</html>
