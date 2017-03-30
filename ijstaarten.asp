<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Ijstaarten</title>
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
	via = trim(request("via"))
	telnr = trim(request("telnr"))
	
	dim ijs(20)
	for i = 1 to 20
		if i <> 7 then
			ijs(i) = trim(request("ijs"&i))
			if isnull(ijs(i)) or ijs(i) = "" then 
				ijs(i) = 0
			end if
			ijs(i) = cint(ijs(i))
		end if
	next
	
	sqlstring = "INSERT INTO tblijstaarten(naam,via,telnr,ijs01,ijs02,ijs03,ijs04,ijs05,ijs06,ijs08,ijs09,ijs10,ijs11,ijs12,ijs13,ijs14,ijs15,ijs16,ijs17,ijs18,ijs19,ijs20,betaald) "&_ 
				"VALUES('"&naam&"','"&via&"','"&telnr&"','"&ijs(1)&"','" & ijs(2)&"','" & ijs(3)&"','" & ijs(4)&"','" & ijs(5)&"','" & ijs(6)&"','" & ijs(8)&"','" & ijs(9)&"','" & ijs(10)&"','" & ijs(11)&"','" & ijs(12)&"','" & ijs(13)&"','" & ijs(14)&"','" & ijs(15)&"','" & ijs(16)&"','" & ijs(17)&"','" & ijs(18)&"','" & ijs(19)&"','" & ijs(20)&"',0)"
	con.execute sqlstring	
	betalen = trim(request("betalen"))
	
	%>
    
<p align="center"><span class="NieuwsTitels style3">Ijstaarten</span></p>
    
  <table border="0" align="center">
    <tr>
	<td width="20">&nbsp;</td>
	  <td valign="top">
      		
            <%
			sqlstring = "SELECT id FROM tblijstaarten WHERE id = LAST_INSERT_ID()"
			rs.open sqlstring			
			%>
            <p>Bedankt voor uw bestelling</p>
            <p>U kan overschrijven naar ING-nummer BE16 3630 4262 5274. Uw bestelling is pas defenitief na betaling van <b>€ <%=betalen%></b>.<br>
			<p>De ijstaarten kunnen afgehaald worden aan de sporthal Vijfsprong in Lummen enkel op 19 december 2014 tussen 17.00u en 21.00u. </p>
            <p>U kan deze pagina afdrukken als bewijs van uw bestelling.</p>
           	<hr>
            <h1><%=rs("id")%></h1>
            <%rs.close%>
            <h3>Naam: <%=naam%></h3>
            <p>Via: <%=via%></p>
            <p>Telnr: <%=telnr%></p>
                <table border="1" align="center" cellspacing="0">
                    <tr>
                      <td align="center" nowrap>Nr</td>
                      <td nowrap>Inhoud</td> 
                      <td nowrap>Product</td>
                      <td nowrap>Prijs</td>
                      <td nowrap>aantal</td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>1</td>
                      <td nowrap>6 x 130 ml</td> 
                      <td nowrap><strong>mini stronkjes</strong> vanille-chocolade </td>
                      <td nowrap width="35">&euro; 8,50 </td>
                      <td nowrap align="center"><%=ijs(1)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>2</td>
                      <td nowrap>4 x 130 ml</td> 
                      <td nowrap><strong>sterretjes</strong> speculoos</td>
                      <td nowrap width="35">&euro; 7,00</td>
                      <td nowrap align="center"><%=ijs(2)%> </td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>3</td>
                      <td nowrap>4 x 130 ml</td> 
                      <td nowrap><strong>mini-hartjes</strong> vanille</td>
                      <td nowrap width="35">&euro; 7,00 </td>
                      <td nowrap align="center"><%=ijs(3)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>4</td>
                      <td nowrap>4 x 150 ml</td> 
                      <td nowrap><strong>mini-ijsbeer</strong> vanille</td>
                      <td nowrap width="35">&euro; 14,50</td>
                      <td nowrap align="center"><%=ijs(4)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>5</td>
                      <td nowrap>4 x 150 ml</td>
                      <td nowrap><strong>santa claus</strong> bekers vanille</td>
                      <td nowrap>&euro; 14,00</td>
                      <td nowrap align="center"><%=ijs(5)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>6</td>
                      <td nowrap>4 x 130 ml</td>
                      <td nowrap><strong>mini assortiment</strong> 1 stronkje, 1 sterretje, 1 hartje, 1 ijsbeer</td>
                      <td nowrap>&euro; 8,50</td>
                      <td nowrap align="center"><%=ijs(6)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>8</td>
                      <td nowrap>1,6 l</td>
                      <td nowrap><strong>siberienne</strong> vanille, jocondo biscuit, Grand Marnier, meringue</td>
                      <td nowrap> &euro; 30,00</td>
                      <td nowrap align="center"><%=ijs(8)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>9</td>
                      <td nowrap>1,2 l</td>
                      <td nowrap><strong>gastro grootmoedersstronk</strong> vanille-mokka-slagroom</td>
                      <td nowrap>&euro; 20,00</td>
                      <td nowrap align="center"><%=ijs(9)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>10</td>
                      <td nowrap>1,2 l</td>
                      <td nowrap><strong>gastro grootmoedersstronk </strong>vanille-chocolade-slagroom</td>
                      <td nowrap>&euro; 20,00</td>
                      <td nowrap align="center"><%=ijs(10)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>11</td>
                      <td nowrap>800 ml</td>
                      <td nowrap><strong>vacherin</strong> vanille/sherbet frambozen</td>
                      <td nowrap>&euro; 15,00</td>
                      <td nowrap align="center"><%=ijs(11)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>12</td>
                      <td nowrap>850 ml</td>
                      <td nowrap><strong>slapende kerstman</strong> vanillebiscuit en slagroom</td>
                      <td nowrap>&euro; 15,00</td>
                      <td nowrap align="center"><%=ijs(12)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>13</td>
                      <td nowrap>1,2 l</td>
                      <td nowrap><strong>resto grootmoedersstronk</strong> koffie-tiramisu-slagroom</td>
                      <td nowrap>&euro; 20,00</td>
                      <td nowrap align="center"><%=ijs(13)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>14</td>
                      <td nowrap>1,4 l</td>
                      <td nowrap><strong>resto kerstronk</strong> vanille-chocolade</td>
                      <td nowrap>&euro; 10,50</td>
                      <td nowrap align="center"><%=ijs(14)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>15</td>
                      <td nowrap>1,4 l</td>
                      <td nowrap><strong>resto kerstronk</strong> vanille-mokka</td>
                      <td nowrap>&euro; 10,50</td>
                      <td nowrap align="center"><%=ijs(15)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>16</td>
                      <td nowrap>1 l</td>
                      <td nowrap><strong>resto kerstronk</strong> vanille</td>
                      <td nowrap>&euro; 8,50</td>
                      <td nowrap align="center"><%=ijs(16)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>17</td>
                      <td nowrap>1 l</td>
                      <td nowrap><strong>resto kerstronk</strong> vanille-aardbeien</td>
                      <td nowrap>&euro; 8,50</td>
                      <td nowrap align="center"><%=ijs(17)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>18</td>
                      <td nowrap>1 l</td>
                      <td nowrap><strong>resto kerstronk</strong> vanille-pralin&eacute;</td>
                      <td nowrap>&euro; 8,50</td>
                      <td nowrap align="center"><%=ijs(18)%></td>
                    </tr>
                    <tr>
                      <td align="center" nowrap>19</td>
                      <td nowrap>1 l</td>
                      <td nowrap><strong>resto kerstronk</strong> stracciatella</td>
                      <td nowrap>&euro; 9,00</td>
                      <td nowrap align="center"><%=ijs(19)%></td>
                    </tr>
                  </table>                <p align="center">
					<script language="JavaScript">
                    if (window.print) {
                    document.write('<form>'
                    + '<input type=button name=print value="Afdrukken" '
                    + 'onClick="javascript:window.print()"></form>');
                    }
                   
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
<p align="center"><span class="NieuwsTitels style3">Ijstaarten</span></p>
<p>Beste basketliefhebbers,</p>
<p>  Met de verkoop van ijstaarten, om lekker van te smullen 
  tijdens de feestdagen, kunnen jullie je favoriete sportclub 
  sponsoren.<br>
  De opbrengst is volledig ten voordele van Basket Lummen.<br>
  Om praktische redenen vragen we onderstaand formulier VOOR 2 december 2015 in te vullen. Enkel vooraf betaalde bestellingen kunnen geleverd worden.  U kan overschrijven naar ING-nummer BE16 3630 4262  5274.</p>
<p>  De ijstaarten kunnen afgehaald worden aan de sporthal Vijfsprong in Lummen enkel op 18 december 2015 tussen 17.00u en 21.30u.
</p>
<p><a href="ijsparadijs_kerst2015.pdf" target="_blank">Bekijk de folder via deze link</a></p>
  
<form name="ijstaarten" method="post" action="ijstaarten.asp">
  <table border="1" align="center" cellspacing="0">
    <tr>
      <td align="center" nowrap>Nr</td>
      <td nowrap>Inhoud</td> 
      <td nowrap>Product</td>
      <td nowrap>Prijs</td>
      <td nowrap>aantal</td>
    </tr>
    <tr>
      <td align="center" nowrap>1</td>
      <td nowrap>6 x 130 ml</td> 
      <td nowrap><strong>mini stronkjes</strong> vanille-chocolade </td>
      <td nowrap width="35">&euro; 8,50 </td>
      <td nowrap align="center"> 
          <input name="ijs1" type="text" id="ijs1" tabindex="1" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>        </td>
    </tr>
    <tr>
      <td align="center" nowrap>2</td>
      <td nowrap>4 x 130 ml</td> 
      <td nowrap><strong>sterretjes</strong> speculoos</td>
      <td nowrap width="35">&euro; 7,00</td>
      <td nowrap align="center"> 
          <input name="ijs2" type="text" id="ijs2" tabindex="2" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>        </td>
    </tr>
    <tr>
      <td align="center" nowrap>3</td>
      <td nowrap>4 x 130 ml</td> 
      <td nowrap><strong>mini-hartjes</strong> vanille</td>
      <td nowrap width="35">&euro; 7,00 </td>
      <td nowrap align="center"> 
          <input name="ijs3" type="text" id="ijs3" tabindex="3" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>        </td>
    </tr>
    <tr>
      <td align="center" nowrap>4</td>
      <td nowrap>4 x 150 ml</td> 
      <td nowrap><strong>mini-ijsbee</strong>r vanille</td>
      <td nowrap width="35">&euro; 14,50</td>
      <td nowrap align="center"> 
          <input name="ijs4" type="text" id="ijs4" tabindex="4" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'>        </td>
    </tr>
    <tr>
      <td align="center" nowrap>5</td>
      <td nowrap>4 x 150 ml</td>
      <td nowrap><strong>santa claus</strong> bekers vanille</td>
      <td nowrap>&euro; 14,00</td>
      <td nowrap align="center"><input name="ijs5" type="text" id="ijs5" tabindex="5" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>6</td>
      <td nowrap>4 x 130 ml</td>
      <td nowrap><strong>mini assortiment</strong> 1 stronkje, 1 sterretje, 1 hartje, 1 ijsbeer</td>
      <td nowrap>&euro; 8,50</td>
      <td nowrap align="center"><input name="ijs6" type="text" id="ijs6" tabindex="6" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>8</td>
      <td nowrap>1,6 l</td>
      <td nowrap><strong>siberienne</strong> vanille, jocondo biscuit, Grand Marnier, meringue</td>
      <td nowrap> &euro; 30,00</td>
      <td nowrap align="center"><input name="ijs8" type="text" id="ijs8" tabindex="7" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>9</td>
      <td nowrap>1,2 l</td>
      <td nowrap><strong>gastro grootmoedersstronk</strong> vanille-mokka-slagroom</td>
      <td nowrap>&euro; 20,00</td>
      <td nowrap align="center"><input name="ijs9" type="text" id="ijs9" tabindex="8" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>10</td>
      <td nowrap>1,2 l</td>
      <td nowrap><strong>gastro grootmoedersstronk </strong>vanille-chocolade-slagroom</td>
      <td nowrap>&euro; 20,00</td>
      <td nowrap align="center"><input name="ijs10" type="text" id="ijs10" tabindex="9" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>11</td>
      <td nowrap>800 ml</td>
      <td nowrap><strong>vacherin</strong> vanille/sherbet frambozen</td>
      <td nowrap>&euro; 15,00</td>
      <td nowrap align="center"><input name="ijs11" type="text" id="ijs11" tabindex="10" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>12</td>
      <td nowrap>850 ml</td>
      <td nowrap><strong>slapende kerstman</strong> vanillebiscuit en slagroom</td>
      <td nowrap>&euro; 15,00</td>
      <td nowrap align="center"><input name="ijs12" type="text" id="ijs12" tabindex="11" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>13</td>
      <td nowrap>1,2 l</td>
      <td nowrap><strong>resto grootmoedersstronk</strong> koffie-tiramisu-slagroom</td>
      <td nowrap>&euro; 20,00</td>
      <td nowrap align="center"><input name="ijs13" type="text" id="ijs13" tabindex="12" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>14</td>
      <td nowrap>1,4 l</td>
      <td nowrap><strong>resto kerstronk</strong> vanille-chocolade</td>
      <td nowrap>&euro; 10,50</td>
      <td nowrap align="center"><input name="ijs14" type="text" id="ijs14" tabindex="13" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>15</td>
      <td nowrap>1,4 l</td>
      <td nowrap><strong>resto kerstronk</strong> vanille-mokka</td>
      <td nowrap>&euro; 10,50</td>
      <td nowrap align="center"><input name="ijs15" type="text" id="ijs15" tabindex="14" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>16</td>
      <td nowrap>1 l</td>
      <td nowrap><strong>resto kerstronk</strong> vanille</td>
      <td nowrap>&euro; 8,50</td>
      <td nowrap align="center"><input name="ijs16" type="text" id="ijs16" tabindex="15" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>17</td>
      <td nowrap>1 l</td>
      <td nowrap><strong>resto kerstronk</strong> vanille-aardbeien</td>
      <td nowrap>&euro; 8,50</td>
      <td nowrap align="center"><input name="ijs17" type="text" id="ijs17" tabindex="16" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>18</td>
      <td nowrap>1 l</td>
      <td nowrap><strong>resto kerstronk</strong> vanille-pralin&eacute;</td>
      <td nowrap>&euro; 8,50</td>
      <td nowrap align="center"><input name="ijs18" type="text" id="ijs18" tabindex="17" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr>
      <td align="center" nowrap>19</td>
      <td nowrap>1 l</td>
      <td nowrap><strong>resto kerstronk</strong> stracciatella</td>
      <td nowrap>&euro; 9,00</td>
      <td nowrap align="center"><input name="ijs19" type="text" id="ijs19" tabindex="18" onChange="calcrows()" value="0" size="2" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;" onkeypress='return event.charCode >= 48 && event.charCode <= 57'></td>
    </tr>
    <tr align="right" bgcolor="#000000"> 
      <td colspan="5" nowrap><font color="#FFFFFF">Totaal &euro; 
        <input name="betalen" type="text" onChange="calcrows()" value="0" size="4" maxlength="4" readonly="true" style="background-color:#000000;color:#FFFFFF;text-align:center;border-color:#000000;"></font></td>
    </tr>
  </table>
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="20" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Bestelling via (naam speler + ploeg :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="via" size="50" tabindex="21" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Telefoonnummer :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="telnr" size="50" tabindex="22" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="22" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>
    <script language="JavaScript">

function calcrows(){
 	var aijs1 = (document.ijstaarten.ijs1.value*1);
 	var aijs2 = (document.ijstaarten.ijs2.value*1);
 	var aijs3 = (document.ijstaarten.ijs3.value*1);
 	var aijs4 = (document.ijstaarten.ijs4.value*1);
 	var aijs5 = (document.ijstaarten.ijs5.value*1);
 	var aijs6 = (document.ijstaarten.ijs6.value*1);
 	var aijs8 = (document.ijstaarten.ijs8.value*1);
 	var aijs9 = (document.ijstaarten.ijs9.value*1);
 	var aijs10 = (document.ijstaarten.ijs10.value*1);
 	var aijs11 = (document.ijstaarten.ijs11.value*1);
 	var aijs12 = (document.ijstaarten.ijs12.value*1);
 	var aijs13 = (document.ijstaarten.ijs13.value*1);
 	var aijs14 = (document.ijstaarten.ijs14.value*1);
 	var aijs15 = (document.ijstaarten.ijs15.value*1);
 	var aijs16 = (document.ijstaarten.ijs16.value*1);
 	var aijs17 = (document.ijstaarten.ijs17.value*1);
 	var aijs18 = (document.ijstaarten.ijs18.value*1);
 	var aijs19 = (document.ijstaarten.ijs19.value*1);

	var betalen1 = (((aijs2+aijs3)*7)+((aijs1+aijs6+aijs16+aijs17+aijs18)*8.5)+(aijs19*9)+((aijs14+aijs15)*10.5)+(aijs5*14)+(aijs4*14.5)+(aijs11+aijs12*15)+((aijs9+aijs10+aijs13)*20)+(aijs8*30));
	document.ijstaarten.betalen.value = betalen1;
}
</script>
</form>
<%end if%>
</div>
</body>
</html>
