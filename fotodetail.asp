<!--#include file="connect.asp" -->
<%reeks=trim(request("reeks"))
nr=int(trim(request("nr")))
toon=5%>
<html>
<head>
<title>Basket Lummen - Fotoalbum</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<%

sqlString = "SELECT reeksnaam, datum, naam, aantal FROM tblFotos WHERE reeks = " & reeks
rs.open sqlString

if not rs.eof then%>
	<table width="710" border="0" align="center" cellspacing="0" cellpadding="0" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="left">
			<%if nr > 1 then%>
				<a href="fotodetail.asp?reeks=<%=reeks%>&nr=<%=(nr-1)%>"><img src="img/vorige.gif" border="0" alt="vorige"></a>
			<%end if%>
		</td>
		<td align="center" class="hotnews" nowrap><%=rs("reeksnaam")%> (foto <%=nr%> van <%=rs("aantal")%>)</td>
		<td align="right">
			<%if nr < rs("aantal") then%>
				<a href="fotodetail.asp?reeks=<%=reeks%>&nr=<%=(nr+1)%>"><img src="img/volgende.gif" border="0" alt="volgende"></a>
			<%end if%>
		</td>	
	</tr>
	<tr bgcolor="#DDDDDD">
		<td align="center" colspan="3">
		<%
		if nr < 10 then
			j = "0" & nr
		else
			j = nr
		end if
		if reeks = 84 and j > 128 then%>
			<img src="http://www.basketlummen.be/fotos/<%=rs("naam")%><%=j%>.jpg">
		<%else%>		
			<img src="http://users.pandora.be/hasseltsewijnbeurs/basket/20052006/<%=rs("naam")%><%=j%>.jpg">
		<%end if%>	
		</td>
	</tr>
	<tr><td colspan="3" class="hotnews" align="center"><table border="0" width="100%" cellspacing="0" cellpadding="5">
	<%rs.close
	sqlString = "SELECT naam, tekst, dtm, uur FROM tblFototekst WHERE reeks = " & reeks & " AND nr = " & nr & " ORDER BY tekstid"
	rs.open sqlString
	while not rs.eof%>
		<tr>
			<td class="fototekst" bgcolor="#DDDDDD" valign="top" nowrap><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <font color="#000099"><b><%=rs("naam")%></b></font></td>
			<td width="500" class="fototekst"><i><%=weekdayname(weekday(rs("dtm")),true)%>&nbsp;<%=day(rs("dtm"))%>/<%=month(rs("dtm"))%> - <%=formatdatetime(rs("uur"),4)%></i>
			<br><%=rs("tekst")%></td>
		</tr>
		<%rs.movenext
	wend%>
		<form method="post" action="fotosreactie.asp">
			<%
			session("fotoreeks") = reeks			
			session("fotonr") = nr
			%>
			<tr><td colspan="2" class="fototekst">
			<table border="0" width="100%" cellspacing="0" cellpadding="5">
				<tr><td colspan="2">Uw bericht toevoegen: </td></tr>
				<tr><td>Naam</td><td><input type="text" name="naam" size="30" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"> </td></tr>
				<tr><td valign="top">Bericht</td><td><textarea name="reactie" rows="6" cols="60" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"></textarea> </td></tr>
				<tr><td colspan="2" align="center"><input type="submit" value="toevoegen" style="background-color='#FFFF00';"></td></tr>
			</table></td></tr>
		</form>
	</table></td></tr></table>
<%end if
rs.close

sqlString = "SELECT reeks, reeksnaam FROM tblFotos ORDER BY reeks DESC"
rs.open sqlString
if isnull(reeks) or reeks = "" then reeks = rs("reeks")%>
<p align="center">
	<form>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Andere reeksen</option>
		<%while not rs.eof%>
			<option value="fotoalbum.asp?reeks=<%=rs("reeks")%>"><%=rs("reeksnaam")%></option>
			<%rs.movenext
		wend%>
	</select>
	</form>
</p>
<%rs.close

con.close%>
</div>
</body>
</html>
