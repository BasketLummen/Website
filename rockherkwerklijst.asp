<%toon=0%>
<!--#include file="connect2.asp"-->

<html>
<head>
<title>Rock Herk</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<link href="opmaak.css" rel="stylesheet" type="text/css">

<style>
.csstotaal {
	background-color: #000000;
	color: #FFFFFF;
	border: none;
	text-align: center;
	font-weight: bold;
}
.style1 {font-size: 16px}
</style>
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">

  <p class="NieuwsTitels style1">Rock Herk (12-13-14 juli)</p>
  <p>Zoals jullie weten zijn we reeds twee jaar actief op de camping van Rock Herk om onze clubkas te spijzen. Ondanks eerdere berichten en de problemen binnen Rock Herk  gaan we toch de camping mogen uitbaten. Dus we moeten opnieuw een beroep op jullie doen. Vandaar onze warme oproep om opnieuw te komen helpen tijdens één of meerder shifts.</p>

  <p>Je kan hieronder zien wanneer we nog volk nodig hebben.</p>
  <p><strong>Indien je graag wil helpen, stuur dan een mailtje naar <a href="mailto:secretariaat@basketlummen.be">secretariaat@basketlummen.be</a>.</strong></p>
<table bgcolor="#000000">
<%
set rsTaken = server.createobject("adodb.recordset")
rsTaken.activeconnection = con

sqlstring = "SELECT * FROM  tblrockherktaken ORDER BY id"
rsTaken.open sqlstring

while not rsTaken.eof%>
	<tr bgcolor="#FFFFFF">
    <td style="font-size:12px;" valign="top"><%=rsTaken("taak")%><br><%=rsTaken("aantal")%> personen</td>
        <td style="font-size:12px;" valign="top" nowrap>
        <%sqlstring = "SELECT naam FROM tblrockherktaakverdeling WHERE taaknr = " & rsTaken("id")
		rs.open sqlstring
		tel = 0
		while not rs.eof
			tel = tel + 1
			response.Write(rs("naam"))
			response.Write("<br>")
        	rs.movenext
		wend
		rs.close
		if tel < rsTaken("aantal") then
			for x = (tel+1) to rsTaken("aantal")%>
				<div style='background-color: #FF0; width:100%'><img src="ccorner\plus.gif" /></div>
        	<%next%>
        <%end if%>
        
        </td>
	</tr>
	<%rsTaken.movenext
wend
rsTaken.close%>
</table></div>

</body>
</html>
