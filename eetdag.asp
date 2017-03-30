<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Eetdag</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	vide = trim(request("vide"))
	stoofvlees = trim(request("stoofvlees"))
	halvehaan = trim(request("halvehaan"))
	hamburgers = trim(request("hamburgers"))
	koudeschotel = trim(request("koudeschotel"))
	veggie =  trim(request("veggie"))
	
	sqlstring = "INSERT INTO tbleetdag(naam,vide,stoofvlees,halvehaan,hamburgers,koudeschotel,veggie) VALUES('"&naam&"','"&vide&"','"&stoofvlees&"','" & halvehaan&"','" & hamburgers&"','" & koudeschotel&"','" & veggie &"')"
	con.execute sqlstring	%>
    
<p align="center"><span class="NieuwsTitels style3">Eetdag Basket Lummen</span></p>
<p align="center">zondag 23 oktober</p>
<p align="center">De Kalen Dries te Meldert<br>
  van 11 u. tot 14 u. en van 17 u. tot 20 u.</p>
    
  <table border="0" align="center">
    <tr>
	<td width="20">&nbsp;</td>
	  <td valign="top">
      		<p>Bedankt voor uw bestelling</p>
            <p>Gelieve deze pagina af te drukken en mee te brengen op de eetdag</p>
           	<hr>
            <%
			sqlstring = "SELECT id FROM tbleetdag WHERE id = LAST_INSERT_ID()"
			rs.open sqlstring
			%>
            <%rs.close%>
            <h3>Naam: <%=naam%></h3>
            <table border="1" cellspacing="0">
             	<tr><td>&nbsp;</td><td width="10" align="center">Aantal</td></tr>
           		<tr><td>Vide</td><td align="center"><%=vide%></td></tr>
            	<tr><td>Balletjes in tomatensaus</td><td align="center"><%=stoofvlees%></td></tr>            
            	<tr><td>Halve haan</td><td align="center"><%=halvehaan%></td></tr>            
            	<tr><td>Hamburgers</td><td align="center"><%=hamburgers%></td></tr>            
            	<tr><td>koudeschotel</td><td align="center"><%=koudeschotel%></td></tr>            
            	<tr><td>Vegetarisch</td><td align="center"><%=veggie%></td></tr>            
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
<p align="center"><span class="NieuwsTitels style3">Eetdag Basket Lummen</span></p>
<p align="center">zondag 23 oktober</p>
<p align="center">De Kalen Dries te Meldert<br>
  van 11 u. tot 14 u. en van 17 u. tot 20 u.</p>
  
<!--form name="eetdag" method="post" action="eetdag.asp">
  <table border="0" align="center">
    <tr> 
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>aantal</td>
    </tr>
    <tr> 
      <td nowrap>Vid&eacute;: </td>
      <td nowrap width="35">&euro; 12 </td>
      <td nowrap align="center"> 
          <input name="vide" type="text" id="vide" tabindex="1" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">        </td>
    </tr>
    <tr> 
      <td nowrap>Balletjes in tomatensaus : </td>
      <td nowrap width="35">&euro; 12 </td>
      <td nowrap align="center"> 
          <input name="stoofvlees" type="text" id="stoofvlees" tabindex="2" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">        </td>
    </tr>
    <tr> 
      <td nowrap>Halve haan : </td>
      <td nowrap width="35">&euro; 12 </td>
      <td nowrap align="center"> 
          <input name="halvehaan" type="text" id="halvehaan" tabindex="3" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">        </td>
    </tr>
    <tr> 
      <td nowrap>2 hamburgers : </td>
      <td nowrap width="35">&euro; 6 </td>
      <td nowrap align="center"> 
          <input name="hamburgers" type="text" id="hamburgers" tabindex="4" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">        </td>
    </tr>
    <tr>
      <td nowrap>Koude schotel met zalm : </td>
      <td nowrap>&euro; 15 </td>
      <td nowrap align="center"><input name="koudeschotel" type="text" id="koudeschotel" tabindex="5" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">      </td>
    </tr>
    <tr> 
      <td nowrap>Vegetarisch : </td>
      <td nowrap width="35">&euro; 12 </td>
      <td nowrap align="center"> 
          <input name="veggie" type="text" id="veggie" tabindex="3" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;">        </td>
    </tr>
    <tr align="right" bgcolor="#000000"> 
      <td colspan="3" nowrap><font color="#FFFFFF">Totaal &euro; 
        <input name="betalen" type="text" onChange="calcrows()" value="0" size="4" maxlength="4" readonly="true" style="background-color:#000000;color:#FFFFFF;text-align:center;border-color:#000000;"></font></td>
    </tr>
  </table>
  <p align="center"> <span class="tgstrechts">Bij al deze maaltijden zijn frieten inbegrepen.</span>
  </p>
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="6" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="10" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
    <script language="JavaScript">

function calcrows(){
 	var avide = (document.eetdag.vide.value*1);
	var astoofvlees = (document.eetdag.stoofvlees.value*1);
	var ahalvehaan = (document.eetdag.halvehaan.value*1); 
	var ahamburgers = (document.eetdag.hamburgers.value*1);
	var akoudeschotel = (document.eetdag.koudeschotel.value*1);
	var aveggie = (document.eetdag.veggie.value*1);

	var betalen1 = (((avide+astoofvlees+ahalvehaan+aveggie)*12)+(ahamburgers*6)+(akoudeschotel*15));
	document.eetdag.betalen.value = betalen1;
}
</script>
</form-->
<%end if%>
</div>
</body>
</html>
