<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="ccorner/connect.asp"--><%





sqlString = "SELECT tblTopschPloegen.reeks, tblTopschPloegen.ploeg, tblTopschSpelers.nummer, tblTopschSpelers.naam, tblTopschSpelers.voornaam, tblTopschPunten.speeldag, tblTopschPunten.punten " &_
			"FROM (tblTopschPloegen INNER JOIN tblTopschSpelers ON tblTopschPloegen.ploegid = tblTopschSpelers.ploeg) " &_ 
			"INNER JOIN tblTopschPunten ON tblTopschSpelers.nummer = tblTopschPunten.spelerid " &_
			"WHERE speeldag < 27 " &_
			"ORDER BY tblTopschPloegen.reeks DESC, tblTopschPloegen.ploeg, tblTopschSpelers.naam, tblTopschSpelers.voornaam, tblTopschPunten.speeldag"

rs.open sqlString
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Topschutters</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
-->
</style>
</head>

<body>

<p class="NieuwsTitels"><font size="3">Topschutters</font></p>
<table border="0">
<%on error resume next
while not rs.eof
	if reeks <> rs("reeks") then%>
		<tr bgcolor="#000099">
			<td colspan="2"><font color="#FFFF00"><b>
				<%if rs("reeks") = "H" then%>
					Heren
				<%elseif rs("reeks") = "P" then%>
					1ste provinciale
				<%else%>
					Dames
				<%end if%>
			</b></font></td>
			<%for i = 1 to 26%>
				<td align="center"><font color="#FFFF00"><b><%=i%></b></font></td>
			<%next%>
			<td align="center"><font color="#FFFF00"><b>WED</b></font></td>
			<td align="center"><font color="#FFFF00"><b>TOT</b></font></td>
			<td align="center"><font color="#FFFF00"><b>GEM</b></font></td>
		</tr>
		<%reeks = rs("reeks")
	end if
	if ploeg <> rs("ploeg") then%>
		<tr height="5" bgcolor="#000099"><td colspan="31"></td></tr><tr><td bgcolor="#FFFFFF" colspan="31">
		<b><%=rs("ploeg")%></b></td></tr><tr><td width="10"></td>
		<%ploeg = rs("ploeg")
	else%>
		<tr><td>
	<%end if%>
	</td>
	<td bgcolor="#FFFFFF"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
	<%som = 0
	aant = 0
	for i = 1 to 26
		if not rs.eof then%>
            <td align="center" width="20" bgcolor="#FFFFFF"><%=rs("punten")%></td>
            <%if rs("punten") <> "" and not isnull("rspunten") then
				som = som + rs("punten")
				aant = aant + 1
			end if
            rs.movenext
		end if
	next%>
	<td width="30" align="center" bgcolor="#FFFFFF"><font color="#FF0000"><%=aant%></font></td>
	<td width="30" align="center" bgcolor="#FFFFFF"><font color="#FF0000"><%=som%></font></td>
   <td width="30" align="center" bgcolor="#FFFFFF"><font color="#FF0000"> <%=round((som/aant),1)%></font></td>
	</tr>
<%wend
rs.close%>
</table>
</body>
</html>
