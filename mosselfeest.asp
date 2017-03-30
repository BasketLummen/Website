<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<%toon=0%>
<html>
<head>
<title>Mosselfeest</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function totaal(TheForm)
{
	TheForm.betalen.value = (eval(TheForm.mosselen.value)*18)+((eval(TheForm.vide.value)+eval(TheForm.halvehaan.value)+eval(TheForm.stoofvlees.value)+eval(TheForm.vegetarisch.value))*12)+(eval(TheForm.hamburgers.value)*6);
}
</script>
<style>
.csstotaal {
	background-color: #000000;
	color: #FFFFFF;
	border: none;
	text-align: center;
	font-weight: bold;
}
</style>
</head>

<body>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	mosselen = trim(request("mosselen"))
	vide = trim(request("vide"))
	stoofvlees = trim(request("stoofvlees"))
	halvehaan = trim(request("halvehaan"))
	vegetarisch = trim(request("vegetarisch"))
	hamburgers = trim(request("hamburgers"))
	
	sqlstring = "INSERT INTO tblmosselfeest(naam,mosselen,vide,stoofvlees,halvehaan,vegetarisch,hamburgers) VALUES('"&naam&"','"&mosselen&"','"&vide&"','"&stoofvlees&"','" & halvehaan&"','" & vegetarisch&"','" & hamburgers&"')"
	con.execute sqlstring	%>
    
<p align="center">Mosselfeest<br>
  zondag 19 februari</p>
<p align="center">Gildezaal Laren,<br>
  Hoogstraat, Lummen <br>
van 11 u. tot 14 u. en van 17 u. tot 20 u.</p>
  <table border="0" align="center">
    <tr>
	<td width="20">&nbsp;</td>
	  <td valign="top">
      		<p>Bedankt voor uw bestelling</p>
            <p>Gelieve deze pagina af te drukken en mee te brengen op de eetdag</p>
           	<hr>
            <h3>Naam: <%=naam%></h3>
            <table border="1" cellspacing="0">
             	<tr><td>&nbsp;</td><td width="10" align="center">Aantal</td></tr>
              	<tr><td>Mosselen</td><td align="center"><%=mosselen%></td></tr>            
            	<tr><td>Halve haan</td><td align="center"><%=halvehaan%></td></tr>            
         		<tr><td>Vide</td><td align="center"><%=vide%></td></tr>
            	<tr><td>Stoofvlees</td><td align="center"><%=stoofvlees%></td></tr>            
            	<tr><td>Vegetarisch</td><td align="center"><%=vegetarisch%></td></tr>            
            	<tr><td>Hamburgers</td><td align="center"><%=hamburgers%></td></tr>            
            </table>
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

<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">

<p align="center"><img src="varia/mossel.gif" width="275" height="236"></p>
<p align="center">Mosselfeest<br>
  zondag 19 februari</p>
<p align="center">Gildezaal Laren,<br>
  Hoogstraat, Lummen <br>
van 11 u. tot 14 u. en van 17 u. tot 20 u.</p>
<!--form name="mosselfeest" method="post" action="mosselfeest.asp">
  <table border="0" align="center">
    <tr> 
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>aantal</td>
    </tr>
    <tr>
      <td nowrap>Mosselen : </td>
      <td nowrap>&euro; 18 </td>
      <td nowrap align="center">
        <input name="mosselen" type="text" id="mosselen" tabindex="1" onChange="totaal(this.form)" value="0" size="2" maxlength="2">      </td>
    </tr>
    <tr>
      <td nowrap>Halve haan : </td>
      <td nowrap>&euro; 12</td>
      <td nowrap align="center">
        <input name="halvehaan" type="text" id="halvehaan" tabindex="2" onChange="totaal(this.form)" value="0" size="2" maxlength="2">      </td>
    </tr>
    <tr> 
      <td nowrap>Vid&eacute;: </td>
      <td nowrap width="35">&euro; 12</td>
      <td nowrap align="center"> 
          <input name="vide" type="text" id="vide" tabindex="3" onChange="totaal(this.form)" value="0" size="2" maxlength="2">      </td>
    </tr>
    <tr>
      <td nowrap>Stoofvlees: </td>
      <td nowrap>&euro; 12 </td>
      <td nowrap align="center"><input name="stoofvlees" type="text" id="stoofvlees" tabindex="4" onChange="totaal(this.form)" value="0" size="2" maxlength="2">
      </td>
    </tr>
    <tr>
      <td nowrap>Vegetarisch: </td>
      <td nowrap>&euro; 12 </td>
      <td nowrap align="center"><input name="vegetarisch" type="text" id="vegetarisch" tabindex="5" onChange="totaal(this.form)" value="0" size="2" maxlength="2">
      </td>
    </tr>
    <tr> 
      <td nowrap>2 hamburgers : </td>
      <td nowrap width="35">&euro; 6 </td>
      <td nowrap align="center"> 
          <input name="hamburgers" type="text" id="hamburgers" tabindex="6" onChange="totaal(this.form)" value="0" size="2" maxlength="2">      </td>
    </tr>
    <tr align="right" bgcolor="#000000"> 
      <td colspan="3" nowrap><font color="#FFFFFF">Totaal &euro; 
        <input name="betalen" type="text" class="csstotaal" value="0" size="4" maxlength="4" readonly="true">
      </font></td>
    </tr>
  </table>
  <p align="center"><span class="tgstrechts">Bij al deze maaltijden zijn frieten inbegrepen.</span> </p>
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="7">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">E-mail :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="email" size="50" tabindex="8">
        </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" value="Verzenden" tabindex="10">
  </p>
</form-->
<%end if%>
</div>

</body>
</html>
