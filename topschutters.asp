<%toon=2%>
<!--#include file="ccorner/connect.asp"-->
<%
reeks=trim(request("reeks"))
sqlString = "SELECT naam, voornaam, tblTopschPloegen.ploeg, Sum(punten) AS puntentotaal, Count(punten) AS wedstrijden, reeks " &_
			"FROM tblTopschPunten INNER JOIN (tblTopschPloegen INNER JOIN tblTopschSpelers ON tblTopschPloegen.ploegid = tblTopschSpelers.ploeg) ON tblTopschPunten.spelerid = tblTopschSpelers.nummer " &_
			"GROUP BY naam, voornaam, tblTopschPloegen.ploeg, reeks HAVING reeks = '" & reeks & "' and wedstrijden >0 " &_
			"ORDER BY puntentotaal DESC, naam, voornaam"
rs.open sqlString
%>
<html>
<head>
<title>Topschutters</title>
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style>
.lummen {color:#FF0000;}
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
	
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="7" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0">  Topschutters 2016-2017<br>
		<%if reeks = "h" then%>
			Limburgse Heren
		<%elseif reeks = "p" then%>
			1ste provinciale
		<%else%>
			Limburgse dames			
		<%end if%> </td>
	</tr>
    <tr bgcolor="#DDDDDD">
    	<td colspan="4">&nbsp;</td>
        <td align="center">Wed</td>
        <td align="center">Pun</td>
        <td align="center">Gem</td>
    </tr>
	<%if rs.eof then%>
		<tr><td colspan="5">Geen records.</td></tr>
	<%else%>
		<%i=0
		vorige=0
		while not rs.eof
			on error resume next
			'if rs("wedstrijden")>0 then
				i=i+1
				if rs("ploeg") = "Lummen" or rs("ploeg") = "Lummen A" or rs("ploeg") = "Lummen B" then
					blkleur = " class=lummen"
				else
					blkleur = ""
				end if%>
				<tr>
					<td align="center" width="40"
				<%if vorige<> cint("0"&rs("puntentotaal")) then
					vorige = cint("0"&rs("puntentotaal"))
					blkleur = blkleur & " style='border-top: 1px solid #000099;'"
					response.Write(blkleur&">"&i)
				else
					response.Write(">")
				end if%>
					</td>
					<td<%=blkleur%>><%=rs("voornaam")%></td>
					<td<%=blkleur%>><%=rs("naam")%></td>
					<td<%=blkleur%>><%=rs("ploeg")%></td>
					<td align="center" width="50"<%=blkleur%>><%=rs("wedstrijden")%></td>
					<td align="center" width="50"<%=blkleur%>><%=rs("puntentotaal")%></td>
					<td align="center" width="50"<%=blkleur%>><%=round(cint(rs("puntentotaal"))/cint(rs("wedstrijden")),1)%></td>
				</tr>
			<%'end if
			rs.movenext
		wend
	end if%>
</table>
</div>
</body>
</html>
