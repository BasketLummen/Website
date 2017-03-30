<!--#include file="connect2.asp"-->
<%toon=2%>
<html>
<head>
<title>Basket Lummen - Hot News</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:660px; height:436px; z-index:1; left: 120px; top: 70px;">
<p align="center">
	<form>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Vorige maanden</option>
		<%Session.LCID = 2067
		datum=date()
		while datum > cdate("31/12/2010")%>
			<option value="hotnewsarchief.asp?jaar=<%=year(datum)%>&maand=<%=Month(datum)%>"><%=MonthName(Month(datum))%>&nbsp;<%=year(datum)%></option>
			<%datum = DateAdd("m", -1, datum)
		wend%>
	</select>
	<select onchange=location=this.options[this.selectedIndex].value;>
		<option>Vorige jaren</option>
		<%while datum > cdate("31/12/2000")%>
			<option value="hotnewsarchief.asp?jaar=<%=year(datum)%>"><%=year(datum)%></option>
			<%datum = DateAdd("YYYY", -1, datum)
		wend%>
	</select>
	</form>
</p>
<%
jaar = trim(request("jaar"))
if isnull(jaar) or jaar = "" then jaar = year(date())
maand = trim(request("maand"))
if isnull(maand) or maand = "" then maand = month(date()) - 1
if maand = 0 then maand = 1
sqlString =  "SELECT id, datum, onderwerp, nieuws, linktekst, linkurl, venster " &_ 
			 "FROM tblNieuwsLinks RIGHT JOIN tblNieuws ON tblNieuwsLinks.idl = tblNieuws.id "
	if jaar <> 2011 then
		sqlString = sqlString & "WHERE Year(tblNieuws.datum) = " & jaar & " "
	else
		'wanneer een maaand is meegegeven in de url, selecteerd hij enkel die maand van een bepaald jaar
		sqlString = sqlString & "WHERE Month(tblNieuws.datum) = " & maand & " AND Year(tblNieuws.datum) = " & jaar & " "
	end if
	sqlString = sqlString & "ORDER BY datum DESC, id DESC, idl"

	rs.open sqlString
	
	while not rs.eof
		nrx = rs("id") 
		nrx1 = rs("id")%>
		<table width="600" cellspacing="0" cellpadding="3" bgcolor="#DDDDDD" class="NieuwsTitels">
			<tr>
				<td class="NieuwsTitels" width="475"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <%=rs("onderwerp")%></td>
				<td align="right" class="NieuwsTitels"><%=weekdayname(weekday(rs("datum")))%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month((rs("datum"))))%></td>
			</tr>
		</table>
		<table width="600" cellspacing="0" cellpadding="3">
			<tr>
				<td width="20"></td>
				<td class="NieuwsTekst"><%=rs("nieuws")%></td>
			</tr>
			<%if rs("linktekst") <> "" then%>
			<tr>
				<td></td>
				<td align="right">
				<%while nrx = nrx1 %>
					<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> 
					<a href="<%=rs("linkurl")%>" class="NieuwsLinks"
					<%if rs("venster")=2 then
							'als de link in een nieuw venster moet openen
							%><a href="<%=rs("linkurl")%>" class="NieuwsLinks" target="_blank"><%
					elseif rs("venster")=1 then
						%><a href="#" onClick="window.open('<%=rs("linkurl")%>','','width=750,height=600,scrollbars=yes,resizable=yes');return(false)" class="NieuwsLinks"><%
					else
							%><a href="<%=rs("linkurl")%>" class="NieuwsLinks"><%
					end if%>
						<%=rs("linktekst")%></a>
					<%rs.movenext
					if rs.eof then
						nrx1 = ""
					else
						nrx1 = rs("id")
					end if
				wend%>
				</td>
			</tr>
			<%else
				rs.movenext
			end if%>
		</table>
		<p></p>
	<%wend	
	rs.close%>
</div>
</body>
</html>
