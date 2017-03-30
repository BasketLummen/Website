<!--#include file="ccorner/connect.asp" -->
<%
dim ploeg(11)

ploeg(0)="Basket Lummen"
ploeg(1)="XT Sint-Truiden"
ploeg(2)="Jaga Rad Hasselt"
ploeg(3)="Houthalen 2000"
ploeg(4)="Zolder"
ploeg(5)="Fonteyn Lommel"
ploeg(6)="TBB-Doss Tongeren"
ploeg(7)="Stevoort"
ploeg(8)="Optima Tessenderlo"
ploeg(9)="Houthalen 2000 B"
ploeg(10)="Bilzerse"

pl = trim(request("pl"))
if pl = "" or isnull(pl) then pl = 0

			'berekenen van de punten
			strPunten = "(SELECT tblpronostiek.Spelernr, tblpronowedstrijden.matchnr, If(tblpronowedstrijden.winnaar>0 And (tblpronowedstrijden.winnaar=tblpronostiek.prono),1,0) AS Punten " &_ 
						"FROM tblpronowedstrijden INNER JOIN tblpronostiek ON tblpronowedstrijden.matchnr = tblpronostiek.matchnr " &_
						"WHERE (thuisploeg = '" & ploeg(pl) & "' OR uitploeg = '"&ploeg(pl)&"') AND tblpronostiek.prono is not null AND tblpronowedstrijden.winnaar is not null) AS T_Punten"

strPunten = "(SELECT tblpronostiek.Spelernr, tblpronowedstrijden.matchnr, If(winnaar>0 And (winnaar=prono),1,0) AS punten " &_
 			"FROM tblpronowedstrijden INNER JOIN tblpronostiek ON tblpronowedstrijden.matchnr = tblpronostiek.matchnr) AS DerivedTable1 " &_
			"WHERE (thuisploeg = '" & ploeg(pl) & "' OR uitploeg = '"&ploeg(pl)&"') AND tblpronostiek.prono is not null AND tblpronowedstrijden.winnaar is not null) AS T_Punten"


			
			'berkenen van het klassement
			strKlas = "(SELECT tblpronodeelnemers.Spelernr, tblpronodeelnemers.naam, tblpronodeelnemers.voornaam, Sum(T_Punten.Punten) AS Totaal " &_
						"FROM tblpronodeelnemers INNER JOIN " & strPunten & " ON tblpronodeelnemers.Spelernr = T_Punten.Spelernr " &_
						"GROUP BY tblpronodeelnemers.Spelernr, tblpronodeelnemers.naam, tblpronodeelnemers.voornaam " &_
						"ORDER BY totaal DESC , tblpronodeelnemers.voornaam, tblpronodeelnemers.naam) AS T_Klassement"
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
<%=response.Write(sqlstring)%>
	<form><p align="center">
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Andere ploeg</option>
		<%for i = 0 to 11%>
			<option value="pronoploeg.asp?pl=<%=i%>"><%=ploeg(i)%></option>
		<%next%>
	</select></p>
	</form>

<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0">  <%=ploeg(pl)%></td>
	</tr>
	<%
	tel=0
	kleur="#FFFFFF"
	vorig = 9999
	while not rs.eof
		tel=tel+1
		if rs("Totaal") <> vorig then 'or rs("verschil") <> vorig2
			vorig = rs("Totaal")
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
		  ><%=rs("naam")%></td>
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
