<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->
<%toon=0%>
<html>
<head>
<title>BBQ</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, select, input {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
select {
	border: 1px solid #000099;
	background-color: #FFFFFF;
	}
-->
</style></head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">

      <table cellspacing="0" width="600" style="border: #000099 medium solid" align="center"><tr><td valign="top" align="center" width="210"><img src="barbecue.jpg"/></td>
      <td>
<h1 align="center"><font size="5">Barbecue Slotdag<br>
  zaterdag 21 mei 2016</font></h1>
<p align="center">Vanaf 18u00<br>
  Cafetaria sporthal Lummen</p>
<p align="center">15 euro voor 3 stukken vlees<br>13 euro voor 2 stukken vlees<br>
met bijhorende groenten en sausjes!</p>
<p align="center"><strong>Inschrijven voor dinsdag 17 mei</strong></p></td></tr></table>

<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	email = trim(request("email"))
	keuze1 = trim(request("keuze1"))
	keuze2 = trim(request("keuze2"))
	keuze3 = trim(request("keuze3"))
	sqlstring = "INSERT INTO tblbbq(naam,email,keuze1,keuze2,keuze3) VALUES('"&naam&"','"&email&"','"&keuze1&"','"&keuze2&"','" & keuze3&"')"
	con.execute sqlstring	%>
    
  <table border="0" align="center">
    <tr>
	<td width="20">&nbsp;</td>
	  <td valign="top">
      		<p>Bedankt voor uw bestelling</p>
            <p>Gelieve deze pagina af te drukken en mee te brengen op de slotdag</p>
           	<hr>
            <%
			sqlstring = "SELECT id FROM tblbbq WHERE id = LAST_INSERT_ID()"
			rs.open sqlstring
			%>
            <h1><%=rs("id")%></h1>
            <%rs.close%>
            <h3>Naam: <%=naam%></h3>
			<p>Keuze 1: <%=keuze1%></p>
            <p>Keuze 2: <%=keuze2%></p>
            <p>Keuze 3: <%=keuze3%></p>
                <p align="center">
					<script language="JavaScript"><!-- Begin
                    if (window.print) {
                    document.write('<form>'
                    + '<input type=button name=print value="Afdrukken" '
                    + 'onClick="javascript:window.print()"></form>');
                    }
                    // End -->
                    </script>
				 </p>
      </td>
      </tr>
     
      </table>
<%else
%>


<!--form name="barbecue" method="post" action="bbqslotdag.asp">
  <table border="0" align="center">
    <tr> 
      <td>Naam</td>
      <td><input type="text" name="naam" size="50" tabindex="1"></td>
    </tr>
    <tr> 
      <td>E-mail</td>
      <td><input type="text" name="email" size="50" tabindex="2"></td>
    </tr>
     <tr> 
      <td>Keuze 1</td>
      <td><select name="keuze1" tabindex="3">
      <option value="\"></option>
      <option value="Spiering">Kotelet Spiering</option>
      <option value="Varkensbrochette">Varkensbrochette</option>
      <option value="Rundsbrochette">Rundsbrochette</option>
      <option value="Chipolata">Chipolata</option>
 	  <option value="Kipfilet">Kipfilet</option>
      <option value="Scampi">Scampispies</option>
      <option value="Zalm">Zalm</option>
      <option value="Barbecueworst">Barbecueworst</option>
     </select></td>
    </tr>
    <tr> 
      <td>Keuze 2</td>
      <td><select name="keuze2" tabindex="3">
      <option value="\"></option>
      <option value="Spiering">Kotelet Spiering</option>
      <option value="Varkensbrochette">Varkensbrochette</option>
      <option value="Rundsbrochette">Rundsbrochette</option>
      <option value="Chipolata">Chipolata</option>
 	  <option value="Kipfilet">Kipfilet</option>
      <option value="Scampi">Scampispies</option>
      <option value="Zalm">Zalm</option>
      <option value="Barbecueworst">Barbecueworst</option>
      </select></td>
    </tr>
    <tr> 
      <td>Keuze 3</td>
      <td><select name="keuze3" tabindex="3">
      <option value="X"> </option>
      <option value="Spiering">Kotelet Spiering</option>
      <option value="Varkensbrochette">Varkensbrochette</option>
      <option value="Rundsbrochette">Rundsbrochette</option>
      <option value="Chipolata">Chipolata</option>
 	  <option value="Kipfilet">Kipfilet</option>
      <option value="Scampi">Scampispies</option>
      <option value="Zalm">Zalm</option>
      <option value="Barbecueworst">Barbecueworst</option>
      </select></td>
    </tr>
    <tr> 

    </tr>
    </table>
  <p align="center"> 
    <input type="submit" value="Verzenden" tabindex="4">
  </p>
</form-->
<%end if
%>
</div>

</body>
</html>
