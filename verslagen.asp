<!--#include file="connect2.asp"-->
<%toon=2
seizoen="1415"
matchid=trim(request("matchid"))

sqlString = "SELECT tblWedstrijden"&seizoen&".wedstrijd_id, datum, thuisresult, uitresult, thuisploeg, uitploeg, opm, voordeel, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, " &_
			"tblPloegenkal.plnaam2 AS thuispl2, tblPloegenkal1.plnaam2 AS uitpl2 " &_ 
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1, tblverslagen"&seizoen&" " &_
			"WHERE tblWedstrijden"&seizoen&".wedstrijd_id = tblverslagen"&seizoen&".wedstrijdid AND " &_
			"wedstrijd_id = " & matchid & " AND thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id  ORDER BY datum DESC"

rs.open sqlString
if rs.eof then%>
	<p class="nieuws">Geen verslag.</p>
<%else
thuisploeg = rs("thuispl")
uitploeg = rs("uitpl")
%>
<html>
<head>
<title>
<%if thuisploeg = "Basket Lummen" or thuisploeg = "Basket Lummen - A"  or thuisploeg = "Basket Lummen - B"  or thuisploeg = "Basket Lummen - C" or thuisploeg = "Basket Lummen - D" then%>
	<%=rs("thuispl2")%>
<%else%>
	<%=rs("uitpl2")%>
<%end if%>: <%=rs("thuispl")%>&nbsp;<%=rs("thuisresult")%>&nbsp;-&nbsp;<%=rs("uitpl")%>&nbsp;<%=rs("uitresult")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con



ploeg=trim(request("ploeg"))
if ploeg="" or isnull(ploeg) then 
	ploeg = 0
else
	'de matchgegevens ophalen
	sqlString = "SELECT tblWedstrijden"&seizoen&".wedstrijd_id, datum, thuisresult, uitresult, thuisploeg, uitploeg, opm, voordeel, " &_
				"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl " &_
				"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1, tblverslagen"&seizoen&" " &_
				"WHERE tblWedstrijden"&seizoen&".wedstrijd_id = tblverslagen"&seizoen&".wedstrijdid AND " &_
				"thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id AND " &_
				"ploeg = " & ploeg & " ORDER BY datum DESC"
	rs1.open sqlString
	if rs1.eof then%>
		<p class="nieuws">Geen verslagen voor deze ploeg.</p>
	<%else%>
		<p align="center">
			<form>
			<select onchange=location=this.options[this.selectedIndex].value; class="nieuws">
				<%while not rs1.eof%>
					<option value="verslagen.asp?ploeg=<%=ploeg%>&matchid=<%=rs1("wedstrijd_id")%>"<%
					if int(matchid) = rs1("wedstrijd_id") then%>
						 selected="selected"
						<%end if
					%>><%=day(rs1("datum"))%>/<%=month(rs1("datum"))%> - <%=rs1("thuispl")%> - <%=rs1("uitpl")%></option>
					<%rs1.movenext
				wend
				rs1.close%>
			</select>
			</form>
		</p>
	<%end if
end if
%>
  <table border="0" cellspacing="0" cellpadding="0" height="800">
    <tr>
	  <td valign="top" width="600">
	
	<table cellspacing=0 align="center" width="100%" style="border: 1px solid #006;"><tr class="NieuwsTitels" bgcolor="#DDDDDD">
	<td align="center"><%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")),true)%>&nbsp;:&nbsp;<%=rs("thuispl")%>&nbsp;-&nbsp;<%=rs("uitpl")%>&nbsp;<%=rs("thuisresult") & " - " & rs("uitresult")%>
	<%if rs("opm") <> "" and not isnull(rs("opm")) then%>
		(<%=rs("opm")%>)
	<%end if
	voordeel = rs("voordeel")
	rs.close%>
	</td></tr>
	<tr><td>
	<%
	'het verslag ophalen
	sqlString = "SELECT verslag FROM tblverslagen"&seizoen&" " &_
				"WHERE wedstrijdid = " & matchid
	rs.open sqlString
	if not rs.eof then%>
		<p class="nieuws"><%=rs("verslag")%></p>
	<%end if
	rs.close%>
	</td></tr></table><p>&nbsp;</p>
	
	<table align="center" width="400"><tr><td valign="top" align="center" width="175">
	<%'de punten van Lummen ophalen
	sqlString = "SELECT naam, voornaam, punten FROM tblVerslagPunten"&seizoen&", tblLeden " &_
				"WHERE wedstrijdid = " & matchid & " AND spelerid = id ORDER BY punten DESC, naam, voornaam"
	rs.open sqlString
	
	if not rs.eof then%>
		<table cellspacing=0 cellpadding="3"><tr class="NieuwsTitels" bgcolor="#DDDDDD" ><td colspan="2">Lummen</td></tr>
		<%while not rs.eof%>
			<tr>
				<td width="160" style="border-top: 1px solid #006;" class="nieuws" align="left" nowrap="nowrap"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
				<td align="center" width="30" style="border-top: 1px solid #006;" class="nieuws">
				<%if rs("punten") = 0 then%>
					&nbsp;
				<%else%>
					<%=rs("punten")%>
                <%end if%></td>
			</tr>
			<%rs.movenext
		wend
		if voordeel > 0 then%>
			<tr>
				<td width="160" style="border-top: 1px solid #006;" class="nieuws" align="left" nowrap="nowrap"><i>voorgift</i></td>
				<td align="center" width="30" style="border-top: 1px solid #006;" class="nieuws"><i><%=voordeel%></i></td>
			</tr>
		<%end if%>
		</table>
	<%end if
	rs.close%>
	</td><td width="10">&nbsp;</td><td valign="top" align="center" width="175">
	<%'de punten van de tegenstander ophalen
	sqlString = "SELECT naam, punten FROM tblVerslagtegenstander"&seizoen&" " &_
				"WHERE wedstrijdid = " & matchid & " ORDER BY punten DESC, naam"
	rs.open sqlString
	
	if not rs.eof then%>
		<table cellspacing=0 cellpadding="3"><tr bgcolor="#CCCCCC" style="font-family:Verdana, Arial, Helvetica, sans-serif;
font-size: 14px; font-weight:bold;"><td colspan="2" nowrap="nowrap">
		<%if thuisploeg = "Basket Lummen" or thuisploeg = "Basket Lummen - A"  or thuisploeg = "Basket Lummen - B"  or thuisploeg = "Basket Lummen - C" or thuisploeg = "Basket Lummen - D" then%>
			<%=uitploeg%>
		<%else%>
			<%=thuisploeg%>
		<%end if%>	
		</td></tr>
		<%while not rs.eof%>
			<tr>
				<td width="160" style="border-top: 1px solid #BBBBBB;" class="nieuws" align="left" nowrap="nowrap"><%=rs("naam")%></td>
				<td align="center" width="30" style="border-top: 1px solid #BBBBBB;" class="nieuws">
				<%if rs("punten") = 0 then%>
					&nbsp;
				<%else%>
					<%=rs("punten")%>
                <%end if%></td>
			</tr>
			<%rs.movenext
		wend
		if voordeel < 0 then%>
			<tr>
				<td width="160" style="border-top: 1px solid #BBBBBB;" class="nieuws" align="left" nowrap="nowrap"><i>voorgift</i></td>
				<td align="center" width="30" style="border-top: 1px solid #BBBBBB;" class="nieuws"><i><%=(voordeel*-1)%></i></td>
			</tr>
		<%end if%>
		</table>
	<%end if
	rs.close%>
	
	</td></tr>
	</table>
	
	
	
<%end if
con.close

%>
	  
	  
	  </td>
    </tr>
  </table>
  </div>
</body>
</html>
