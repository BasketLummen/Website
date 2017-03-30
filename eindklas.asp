<!--#include file="ccorner/connect.asp" -->
<html>
<head>
<title>Basket Lummen - Eindklassement</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style>
body {
	background-image: url(img/logogrijsgroot.gif);
	background-position: 490px 10px;
	background-repeat: no-repeat;
}
</style>
</head>

<body>
<%
ploeg=trim(request("ploeg"))
sqlString= "SELECT tblEindrangschikking.ploeg, tblEindrangschikking.seizoennr, tblSeizoenen.seizoen " &_ 
		   "FROM tblSeizoenen INNER JOIN tblEindrangschikking ON tblSeizoenen.seizoenid = tblEindrangschikking.seizoennr " &_ 
		   "GROUP BY tblEindrangschikking.ploeg, tblEindrangschikking.seizoennr, tblSeizoenen.seizoen " &_ 
		   "HAVING tblEindrangschikking.ploeg='" & ploeg & "' " &_ 
		   "ORDER BY tblEindrangschikking.seizoennr DESC"
rs.open sqlString

seizoen=trim(request("seizoen"))
if seizoen="" then seizoen = rs("seizoennr")%>

<p align="center">
	<form>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Andere seizoenen</option>
		<%while not rs.eof%>
			<option value="eindklas.asp?ploeg=<%=ploeg%>&seizoen=<%=rs("seizoennr")%>"><%=rs("seizoen")%></option>
			<%rs.movenext
		wend%>
	</select>
	</form>
</p>

<%rs.close
sqlString= "SELECT seizoen, " & ploeg & " AS reeks, plaats, naam, wedstr, winst, verlies, scorevoor, scoretegen, punten " &_ 
		   "FROM tblSeizoenen INNER JOIN tblEindrangschikking ON tblSeizoenen.seizoenid = tblEindrangschikking.seizoennr " &_ 
		   "WHERE ploeg='" & ploeg & "' AND tblEindrangschikking.seizoennr=" & seizoen
rs.open sqlString
%>
<table cellspacing="0" cellpadding="3" width="450" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels" colspan="8"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Seizoen <%=rs("seizoen")%></td>
	</tr>
<tr bgcolor="#DDDDDD">
	<td align="center" colspan="2" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("reeks")%></td>
	<td align="center" width="35" class="NieuwsTitels">M</td>
	<td align="center" width="35" class="NieuwsTitels">W</td>
	<td align="center" width="35" class="NieuwsTitels">V</td>
	<td align="center" colspan="2" class="NieuwsTitels">Score</td>
	<td align="center" width="35" class="NieuwsTitels">P</td>
</tr>
<%
verschil = 0
while not rs.eof
	if rs("plaats")=101 then%>
    <tr bgcolor="#DDDDDD">
        <td align="center" colspan="2" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> 2e ronde</td>
        <td align="center" width="35" class="NieuwsTitels">M</td>
        <td align="center" width="35" class="NieuwsTitels">W</td>
        <td align="center" width="35" class="NieuwsTitels">V</td>
        <td align="center" colspan="2" class="NieuwsTitels">Score</td>
        <td align="center" width="35" class="NieuwsTitels">P</td>
    </tr>
	<%verschil=100
	end if
	
%>
	<tr <%
		if left(rs("naam"),13) = "Basket Lummen" then
			%>bgcolor="#FFFF00"<%
		end if
		%>>
		<td align="center" width="30" style="border-top: 1px solid #000099;"><%=(rs("plaats")-verschil)%></td>	
		<td nowrap style="border-top: 1px solid #000099;"><%=rs("naam")%></td>	
		<td align="center" width="35" style="border-top: 1px solid #000099;"><%=rs("wedstr")%></td>	
		<td align="center" width="35" style="border-top: 1px solid #000099;"><%=rs("winst")%></td>	
		<td align="center" width="35" style="border-top: 1px solid #000099;"><%=rs("verlies")%></td>	
		<td align="right" width="45" style="border-top: 1px solid #000099;"><%=rs("scorevoor")%></td>	
		<td width="55" style="border-top: 1px solid #000099;">- <%=rs("scoretegen")%></td>	
		<td align="center" width="35" style="border-top: 1px solid #000099;"><%=rs("punten")%></td>	
	</tr>
	<%rs.movenext
wend%>
</table>
</body>
</html>
