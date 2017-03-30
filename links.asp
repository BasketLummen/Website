<!--#include file="connect2.asp"-->
<%toon=8%>
<html>
<head>
<title>Basket Lummen - Links</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
reeks = trim(request("reeks"))
if reeks = "" or isnull(reeks) then reeks = 13
sqlString = "SELECT club, link, reeks FROM tblLinks WHERE soort = " & reeks & " or provincie = " & reeks & " ORDER BY soort, reeks, club"
rs.open sqlString
%>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%if not rs.eof then%>
<table width="250" border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap align="center" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("reeks")%></td>
	</tr>
 <%rks = rs("reeks")
 tel = 1
 while not rs.eof%>
	<tr>
	  <td style="border-top: 1px solid #000099;"><a href="<%=rs("link")%>" target="_blank" class="NieuwsLinks"><%=rs("club")%> 
	  <%if clb = rs("club") then
	  	tel = tel + 1%>
	  	(<%=tel%>)
	  <%else
	  	clb = rs("club")
		tel =1
	  end if%>
	  </a></td>
	</tr>
	<%
	rs.movenext
	if not rs.eof then
		if rs("reeks") <> rks then
			rks = rs("reeks")%>
				</table><p></p>
				<table width="250" border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
					<tr bgcolor="#DDDDDD"> 
					  <td nowrap align="center" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("reeks")%></td>
					</tr>
	  <%end if
  	end if
  wend%>
 </table>
 <%end if%>
</div>
</body>
</html>
