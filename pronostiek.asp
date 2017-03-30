<!--#include file="ccorner/connect.asp" -->
<%
'berekenen van de punten
strPunten = "(SELECT tblpronostiek.Spelernr, tblpronowedstrijden.matchnr, If(winnaar>0 And (winnaar=prono),1,0) AS punten " &_
			"FROM tblpronowedstrijden INNER JOIN tblpronostiek ON tblpronowedstrijden.matchnr = tblpronostiek.matchnr) AS DerivedTable1"

'berkenen van het klassement
strKlas = "(SELECT tblpronodeelnemers.Spelernr, naam, voornaam, SUM(punten) AS totaal FROM tblpronodeelnemers INNER JOIN  " & strPunten &_
		  " ON tblpronodeelnemers.Spelernr = DerivedTable1.Spelernr GROUP BY tblpronodeelnemers.Spelernr, naam, voornaam " &_ 
		  "ORDER BY punten DESC, naam, voornaam) AS DerivedTable2"

sqlString = "SELECT naam, voornaam, totaal, spelernr FROM " & strKlas & " ORDER BY totaal DESC, naam, voornaam"




rs.open sqlString

%>
<%toon=4%>
<html>
<head>
<title>Basket Lummen - Pronostiek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<p>Na een seizoen onderbreking kan u opnieuw deelnemen aan de pronostiek-wedstrijd. </p>
<p>Elke speeldag kan u de winnaars voorspellen van alle Limburgse ploegen in de nationale en landelijke reeksen (heren en dames).</p>
<p>Je moet je hiervoor wel eerst registreren, <a href="pronoregistreren.asp">klik 
	  daarom eerst hier</a>. Dit moet je enkel de eerste keer doen. </p>
	<p> Als je je al geregistreerd hebt, staat je naam hieronder in het klassement. Om in te loggen klik 
	  je op je naam en geef je daarna je paswoord in. Dan kan je je pronostiek ingeven.</p>

<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0">  Klassement </td>
	</tr>
	<%
	tel=0
	kleur="#FFFFFF"
	vorig = 9999
	while not rs.eof
		tel=tel+1
		if cint(rs("Totaal")) <> vorig then 'or rs("verschil") <> vorig2
			vorig = cint(rs("Totaal"))
			'vorig2 = rs("verschil")
			sw=0
		else
			sw = 1
		end if
		%>
		<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" onClick="document.location.href='pronoinloggen.asp?dn=<%=rs("spelernr")%>'"> 
          <td width="35" align="center" class="prono2"<% 
		  if sw = 0 then%>
			  style="border-top: 1px solid #000099;"><%=tel%>
		  <%else%>
		  	>
		  <%end if%>&nbsp;
		  </td>
          <td nowrap class="prono2"<%
		  if sw=0 then%>
		   style="border-top: 1px solid #000099;"
		  <%end if%>
		  ><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
          <td class="prono2" width="50" align="center"<%
		  if sw = 0 then%>
		 	 style="border-top: 1px solid #000099;"><%=rs("Totaal")%>
		  <%else%>
		  	> 
		  <%end if%>&nbsp;	
		  </td>
          <!--<td width="70" align="center">
		  	<%'=rs("verschil")%>		  
		  </td>-->
        </tr>
		<%rs.movenext
	wend
rs.close
con.close
%>
</table>
</div>
</body>
</html>
