<!--#include file="ccorner/connect.asp" -->
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
<%
sqlString= "SELECT tblPronoarchief.seizoennr, seizoen " &_
		   "FROM tblSeizoenen INNER JOIN tblPronoarchief ON tblSeizoenen.seizoenid = tblPronoarchief.seizoennr " &_
		   "GROUP BY tblPronoarchief.seizoennr, seizoen " &_
		   "ORDER BY tblPronoarchief.seizoennr DESC"
rs.open sqlString

seizoen=trim(request("seizoen"))
if seizoen="" then seizoen = rs("seizoennr")%>

<p align="center">
	<form>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Andere seizoenen</option>
		<%while not rs.eof%>
			<option value="pronoarchief.asp?seizoen=<%=rs("seizoennr")%>"><%=rs("seizoen")%></option>
			<%rs.movenext
		wend%>
	</select>
	</form>
</p>

<%rs.close
sqlString= "SELECT seizoen, plaats, naam, punten " &_
		   "FROM tblSeizoenen INNER JOIN tblPronoarchief ON tblSeizoenen.seizoenid = tblPronoarchief.seizoennr " &_ 
		   "WHERE tblPronoarchief.seizoennr = " & seizoen & " " &_ 
		   "ORDER BY plaats"
rs.open sqlString
%>
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels" colspan="3"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Pronostiek <%=rs("seizoen")%></td>
	</tr>
<%while not rs.eof%>
	<tr>
		<td align="center" width="30" style="border-top: 1px solid #000099;"><%=rs("plaats")%></td>	
		<td style="border-top: 1px solid #000099;"><%=rs("naam")%></td>	
		<td align="center" width="35" style="border-top: 1px solid #000099;"><%=rs("punten")%></td>	
	</tr>
	<%rs.movenext
wend%>
</table>
</div>
</body>
</html>
