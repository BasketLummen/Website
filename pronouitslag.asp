<!--#include file="ccorner/connect.asp" -->
<%

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

sd = trim(request("sd"))
if sd="" or isnull(sd) then
	sqlString = "SELECT max(speeldag) AS nr FROM tblpronowedstrijden WHERE winnaar = 1 or winnaar = 2"
	rs.open sqlString
	if isnull(rs("nr")) then
		sd = 1
	else
		sd = rs("nr")
	end if

	rs.close	
	
end if

sqlString = "SELECT tblpronowedstrijden.matchnr, speeldag, thuisploeg, uitploeg, winnaar, Count(prono) AS aantal " &_
			"FROM tblpronowedstrijden LEFT JOIN tblPronostiek ON tblpronowedstrijden.matchnr = tblPronostiek.matchnr " &_
			"GROUP BY tblpronowedstrijden.matchnr, speeldag, thuisploeg, uitploeg, winnaar " &_
			"HAVING speeldag = " & sd

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
<p align="center">
	<form>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Andere speeldag</option>
		<%for i = 1 to 33%>
			<option value="pronouitslag.asp?sd=<%=i%>">Speeldag <%=i%></option>
		<%next%>
	</select>
	</form>
</p>



<table border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td colspan="4" nowrap align="center" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=sd%><sup>e</sup> Speeldag</td>
	</tr>
	<%if sd < 1 or sd > 33 then%>
		<tr> 
			<td colspan="4" align="center">Speeldag bestaat niet</td>
		</tr>
	<%else
		while not rs.eof%>
			<tr> 
			  	<td height="20" nowrap style="border-top: 1px solid #000099;<%
			 	if rs("winnaar") = 1 then %>
			  		 background-color:#FFFF00;<%
					 sqlstring = "SELECT count(matchnr) as juiste FROM tblpronostiek WHERE matchnr = " & rs("matchnr") & " and prono = 1"
					 rs1.open sqlstring
					 percentage = cint(rs1("juiste")) / cint(rs("aantal"))
					 rs1.close				 
				end if%>" nowrap>&nbsp;<%=rs("thuisploeg")%>
				</td>
				<td style="border-top: 1px solid #000099;" width="10" align="center">-</td>
				<td style="border-top: 1px solid #000099;<%
			 	if rs("winnaar") = 2 then
			  		 %> background-color:#FFFF00;<%
					 sqlstring = "SELECT count(matchnr) as juiste FROM tblpronostiek WHERE matchnr = " & rs("matchnr") & " and prono = 2"
					 rs1.open sqlstring
					 percentage = cint(rs1("juiste")) / cint(rs("aantal"))
					 rs1.close				 
				end if%>" nowrap>&nbsp;<%=rs("uitploeg")%> 
				</td>
			 	<td height="20" align="right" nowrap width="70" style="border-top: 1px solid #000099;">
			 	<%if rs("winnaar") <> "" and not isnull(rs("winnaar")) then%>
					<%=formatnumber(percentage*100,2)%>&nbsp;%
				<%end if%>&nbsp;
				</td>
			</tr>
			<%rs.movenext
		wend%>
      	</table>
		<br>
	<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
		<tr bgcolor="#DDDDDD"> 
			<td align="center" colspan="3" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0">  Uitslag </td>
		</tr>
			<%
			rs.close
			'berekenen van de punten
			strPunten = "(SELECT tblpronostiek.Spelernr, tblpronowedstrijden.matchnr, If(tblpronowedstrijden.winnaar>0 And (tblpronowedstrijden.winnaar=tblpronostiek.prono),1,0) AS Punten " &_ 
						"FROM tblpronowedstrijden INNER JOIN tblpronostiek ON tblpronowedstrijden.matchnr = tblpronostiek.matchnr " &_
						"WHERE tblpronowedstrijden.speeldag = " & sd & " AND tblpronostiek.prono is not null AND tblpronowedstrijden.winnaar is not null) AS T_Punten"
			
			'berkenen van het klassement
			strKlas = "(SELECT tblpronodeelnemers.Spelernr, tblpronodeelnemers.naam, tblpronodeelnemers.voornaam, Sum(T_Punten.Punten) AS Totaal " &_
						"FROM tblpronodeelnemers INNER JOIN " & strPunten & " ON tblpronodeelnemers.Spelernr = T_Punten.Spelernr " &_
						"GROUP BY tblpronodeelnemers.Spelernr, tblpronodeelnemers.naam, tblpronodeelnemers.voornaam " &_
						"ORDER BY totaal DESC , tblpronodeelnemers.naam, tblpronodeelnemers.voornaam) AS T_Klassement"
			
			sqlString = "SELECT naam, voornaam, totaal FROM " & strKlas
			rs.open sqlString
			if rs.eof then%>
				<tr> 
					<td colspan="3" align="center"Nog geen uitslag bekend</td>
				</tr>
			<%else
				tel=0
				while not rs.eof
					tel=tel+1
					if cint(rs("Totaal")) <> vorig then
						vorig = cint(rs("Totaal"))
						sw=0
					else
						sw = 1
					end if
					if tel = 1 then
						 max = rs("Totaal")
					end if%>
					<tr> 
					  <td width="35" align="center" class="pronouitslag"<% 
					  if sw = 0 then%>
						  style="border-top: 1px solid #000099;"><%=tel%>
					  <%else%>
						>
					  <%end if%>&nbsp;
					  </td>
					  <td nowrap class="pronouitslag"<%
					  if sw=0 then%>
					   style="border-top: 1px solid #000099;"
					  <%end if%>
					  ><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
					  <td class="pronouitslag" width="50" align="center"<%
					  if sw = 0 then%>
						 style="border-top: 1px solid #000099;"><%=rs("Totaal")%>
					  <%else%>
						> 
					  <%end if%>&nbsp;	
					  </td>
					</tr>
					<%rs.movenext
				wend
			end if
	end if
	rs.close
	con.close%>
</table>
</div>
</body>
</html>
