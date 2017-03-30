<!--#include file="ccorner/connect.asp"-->
<%toon=3%>
<html>
<head>
<title>Basket Lummen - Sporthallen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<link href="inc\jsonSuggest.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jquery\jquery-1.4.2.min.js"></script>
<script type="text/JavaScript" src="jquery\jquery.jsonSuggest.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.getJSON("json/searchGemeenten.asp", function(data){
		$("#gemeente").jsonSuggest(data);
	});
	$.getJSON("json/searchClubs.php", function(data){
		$("#club").jsonSuggest(data);
	});
})
</script></head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
gemeente = trim(request("gemeente"))
club = trim(request("club"))
if gemeente <> "" then
	sqlString = "SELECT sporthalnr, sporthalnaam, sporthaladres, sporthalpostnr, gemeente " &_ 
				"FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr " &_
				"WHERE gemeente LIKE '%" & gemeente & "%' " &_
				"ORDER BY sporthalnaam"
	rs.open sqlString%>
	<table border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	   <tr bgcolor="#DDDDDD"> 
		  <td nowrap class="NieuwsTitels" colspan="3"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> 
		  	<%if rs.eof then%>
				De database bevat geen sporthal uit <%=gemeente%>
			<%else%>
				Gevonden sporthallen
			<%end if%>
 	   </td></tr>
	<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalnaam")%></td>
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthaladres")%></td>
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalpostnr")%>&nbsp;<%=rs("gemeente")%></td>
			</tr>
		<%
		rs.movenext
	wend%>
	</table>
<%elseif club <> "" then
	sqlString = "SELECT tblClubsporthal.club,  Query1.sporthalnr, Query1.sporthalnaam, Query1.sporthaladres, Query1.sporthalpostnr, Query1.Gemeente, Query1_1.sporthalnr AS sporthalnr2,  Query1_1.sporthalnaam AS sporthalnaam2, Query1_1.sporthaladres AS sporthaladres2, Query1_1.sporthalpostnr AS sporthalpostnr2, Query1_1.Gemeente AS gemeente2 FROM (tblClubsporthal LEFT JOIN (SELECT tblSporthallen.sporthalnr, tblSporthallen.sporthalnaam, tblSporthallen.sporthaladres, tblSporthallen.sporthalpostnr, tblGemeenten.Gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr) AS Query1 ON tblClubsporthal.sh1 = Query1.sporthalnr) LEFT JOIN (SELECT tblSporthallen.sporthalnr, tblSporthallen.sporthalnaam, tblSporthallen.sporthaladres, tblSporthallen.sporthalpostnr, tblGemeenten.Gemeente FROM tblSporthallen INNER JOIN tblGemeenten ON tblSporthallen.sporthalpostnr = tblGemeenten.Postnr) AS Query1_1 ON tblClubsporthal.sh2 = Query1_1.sporthalnr WHERE club LIKE '%" & club & "%' ORDER BY club"
	rs.open sqlString%>
	<table border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	   <tr bgcolor="#DDDDDD"> 
		  <td nowrap class="NieuwsTitels" colspan="5"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> 
		  	<%if rs.eof then%>
				Van <%=club%> bevindt er zich geen sporthal in de database
			<%else%>
				Gevonden sporthallen
			<%end if%>
 	   </td></tr>
	<%while not rs.eof%>
			<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("club")%></td>
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalnaam")%></td>
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthaladres")%></td>
				<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalpostnr")%>&nbsp;<%=rs("gemeente")%></td>
			</tr>
<%
		if rs("sporthalnr2") <> "" then
			%>
				<tr onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;">
					<td style="border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr2")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)">&nbsp;</td>
					<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr2")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalnaam2")%></td>
					<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr2")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthaladres2")%></td>
					<td style="border-top: 1px solid #000099; border-right: 1px solid #000099;" onClick="window.open('sporthal.asp?sh=<%=rs("sporthalnr2")%>&sponsor=ja','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=780,height=580,left=0,top=100,screenX=0,screenY=100');return(false)"><%=rs("sporthalpostnr2")%>&nbsp;<%=rs("gemeente2")%></td>
				</tr>
<%		end if
		rs.movenext
	wend%>
	</table>
<%end if%>




<form method="post" action="sporthallen.asp">
<table width="450" border="0" align="center" cellspacing="0" cellpadding="3" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
	  <td nowrap class="NieuwsTitels" colspan="6"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Geef de gemeente of de club de je zoekt</td>
	</tr>
    <tr>
      <td width="86">Gemeente</td>
      <td width="192"><input type="text" name="gemeente" id="gemeente" tabindex="1"></td>
      <td width="50">of</td>
      <td width="86">Club</td>
      <td width="192"><input type="text" name="club" id="club" tabindex="2"></td>
	  <td align="center"><input type="submit" value="zoek" tabindex="3"></td>
	</tr>
  </table>
</form>
</div>
</body>
</html>
