<%toon=0%>
<!--#include file="connect2.asp"-->

<html>
<head>
<title>Mosselfeest</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

  <p class="NieuwsTitels style1">Werklijst jeugdploegen Mosselfeest</p>
  <p>In onderstaande tabel vind je het werkplan voor het mosselfeest van Basket Lummen. <br>
  Voor de geel gekleurde vakjes zoeken we nog enkele vrijwilligers. Indien je graag wil helpen, stuur dan een mailtje naar <a href="mailto:secretariaat@basketlummen.be">secretariaat@basketlummen.be</a>.</p>
  <p><SPAN XSSCleaned="font-size:10.0pt; font-family:Arial">Iedereen wordt verwacht een   kwartiertje voor de start van de shift.</SPAN></p>
  <p><SPAN XSSCleaned="font-size:10.0pt; font-family:Arial">Degenen die vooraf met de   ploeg nog willen eten, moeten dit wel tijdig doen zodat ze klaar zijn om te   werken op het vermelde uur ( dus niet om 17.00 uur eerst gaan eten tot 17.30 uur   als je verwacht wordt beginnen te werken om 17.00 uur ). (Eventueel samen met je   ploeg eten na je werkshift ).</SPAN></p>
  <p><SPAN XSSCleaned="font-size:10.0pt; font-family:Arial">De coaches van de betrokken   ploegen worden verwacht om op de uren van hun   ploeg een handje toe te steken en een oogje in het zeil te houden dat er niet te   veel gespeeld wordt en er vlot doorgewerkt wordt.</SPAN></p>
  <p>&nbsp;</p>
<table bgcolor="#000000">
<%
set rsTaken = server.createobject("adodb.recordset")
rsTaken.activeconnection = con

sqlstring = "SELECT * FROM  tblmosselfeesttaken ORDER BY id"
rsTaken.open sqlstring

while not rsTaken.eof
	if rsTaken("id") = 3 then%>
            <tr bgcolor="#FF0000">
        <td>&nbsp;</td>
        <td><b>11-14 uur</b></td>
        <td><b>17-20 uur</b></td>
        </tr>
	<%end if%>
	<tr bgcolor="#FFFFFF">
    <td style="font-size:12px;" valign="top"><%=rsTaken("taak")%></td>
    <%for i = 1 to 2%>
        <td style="font-size:12px;" valign="top" nowrap>
        <%sqlstring = "SELECT naam FROM tblmosselfeesttaakverdeling WHERE taaknr = " & rsTaken("id") & " AND shift = " & i
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
    <%if rsTaken("id") < 3 then exit for
	next%>
	</tr>
	<%rsTaken.movenext
wend
rsTaken.close%>
</table></div>

</body>
</html>
