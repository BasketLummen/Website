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

naam = request("naam")
email = request("email")
if (naam <> "" and not isnull(naam)) or (email <> "" and not isnull(email)) then
	lidgeld = request("lidgeld")
	andere = request("andere")

	sqlstring = "INSERT INTO tblhulpvraag2(naam,email,lidgeld,opmerkingen) VALUES('"&naam&"','"&email&"',"&lidgeld&",'"&andere&"')"
	con.execute sqlstring%>
	<p>Uw formulier is verzonden</p>
    <p>Het bestuur dankt u voor uw medewerking.</p>
<%else


%>
 <p>Tijdens de algemene vergadering van 20/12/2010 heeft het bestuur opgeroepen tot hulp. Deze hulp kan er velerlei manieren komen. Om verder te onderzoeken hoe deze eventuele hulp gekanaliseerd kan worden, willen we vragen om snel even enkele vragen te beantwoorden:</p>

<p><b>U kan helaas door omstandigheden niet helpen.</b></p>



<form method="post" action="vraaghulp2.asp" id="invulForm">
  <table><tr><td valign="top">Naam</td><td width="250"><input type="text" name="naam" size="50" class="required" id="cname" minlength="2"></td></tr>
  <tr><td valign="top">E-mail</td><td width="250"><input tabindex="text" name="email" size="50" value="<%=email%>" id="cmail" class="required email"></td></tr></table>
<p>Vindt U het problematische dat het lidgeld van Basket Lummen op middenlange termijn drastisch ( = x 2) zou toenemen?</p>
<p><input type="radio" value="1" name="lidgeld"> Ja&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" value="0" name="lidgeld"> Nee</p>
<p>Andere voorstellen of opmerkingen:<br>
<textarea name="andere" cols="50" rows="7"></textarea></p>
<p><input type="submit" value="verzenden" class="submit" style="cursor:hand;cursor:pointer"></p>
 </form>
 <%end if%>
</div>
</body>
</html>
