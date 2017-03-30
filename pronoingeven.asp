<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="ccorner/connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="pronostiek.asp"
MM_grantAccess=false
If Session("PR_Username1") <> "" and Session("PR_Username2") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<%
sqlString = "SELECT spelernr FROM tblpronodeelnemers WHERE naam = '" & Session("PR_Username1") & "' AND voornaam = '" & Session("PR_Username2") & "'"
rs.open sqlString
nummer = rs ("spelernr")
rs.close

dtm=trim(request("dtm"))
if dtm="" or not isDate(dtm) then dtm=date()
dtm=cdate(dtm)


if dtm < cDate("7/09/2012") then
	dtm = cDate("7/09/2012")
elseif weekday(dtm) = 1 then
	dtm = dtm - 6
else	
	dtm = dtm - weekday(dtm) + 2
end if
response.Write(dtm)
sqlString = "SELECT matchnr, reeks, datum, thuisploeg, uitploeg FROM tblpronowedstrijden " &_
			"WHERE datum between ('" & year(dtm) & "-" & month(dtm) & "-" & day(dtm) & "') " &_
			"AND ('" & year(dtm+7) & "-" & month(dtm+7) & "-" & day(dtm+7) & "') " &_
			"ORDER BY matchnr"
rs.open sqlString

set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con

%>
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
<table border="0" cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="9" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Welkom, <%=Session("PR_Username2")%>&nbsp;<%=Session("PR_Username1")%></td>
   </tr>
   <tr bgcolor="#DDDDDD"> 
        <td colspan="9">
			<table cellspacing="0" width="100%" border="0">
			<tr valing="top">
				  <td width="33%">
				  <% If dtm > cDate("7/09/2012") then%>
					<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronoingeven.asp?dtm=<%=dtm-7%>&k=x" class="NieuwsLinks">vorige</a>
				  <% End If %>
				  </td>
				  <td align="center" width="33%">
				<form name="jump">
				<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
					<%dtm1=cdate("08/09/2012")%>
					<option>Kies andere datum</option>
					<%while dtm1 < cdate("15/04/2013")%>
						<option value="pronoingeven.asp?dtm=<%=dtm1%>"><%=day(dtm1)%>&nbsp;<%=MonthName(Month(dtm1),true)%>
						- <%=day(dtm1+1)%>&nbsp;<%=MonthName(Month(dtm1+1),true)%></option>
						<%dtm1 = dtm1 + 7
						wend%>
				</select>
				</form>
				  </td>
				  <td align="right" width="33%">
				  <% If dtm < cDate("15/04/2013") then%>
					<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronoingeven.asp?dtm=<%=dtm+7%>" class="NieuwsLinks">volgende</a>
				  <% End If %>
				  </td>
			</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="10" class="NieuwsTitels">
			<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Geef uw pronostiek
		</td>
    </tr>
	<%
	if rs.eof then
		k = trim(request("k"))
		if isnull(k) or k = "" then
			x = dtm + 7
		else
			x = (dtm - 7) & "&k=x"
		end if
		response.redirect("pronoingeven.asp?dtm="&x)
	else
		tel=0
		datumversch = cint(cdate("3/09/2012") - date())
		if datumversch > 0 then
			xx = datumversch + 7
		else
			xx = 7
		end if%>
		<form method="post" action="pronoopslaan.asp" name="form1">
		<input type="hidden" name="dtm" value="<%=dtm%>">

		<%while not rs.eof
			if (rs("datum") < dateadd("n", 30, now()) or rs("datum") > dateadd("d", 7, now())) and not (now() < cdate("03/09/2012") and rs("datum") < cdate("10/09/2012")) then
				sw = 1
			else
				sw = 0
			end if
			sqlString = "SELECT prono FROM tblpronostiek WHERE spelernr = " & nummer & " AND matchnr = " & rs("matchnr")
			rs1.open sqlString
		  	tel=tel+1%>
			<tr> 
			<td width="30" align="center" style="border-top: 1px solid #000099;"><%=rs("reeks")%></td>
			<td width="30" height="20" align="center" nowrap style="border-top: 1px solid #000099;"> 
				<%=weekdayname(weekday(rs("datum")),true)%></td>
			<td width="50" align="center" nowrap style="border-top: 1px solid #000099;"><%=day(rs("datum"))%>/<%=month(rs("datum"))%></td>
			<td width="50" height="20" align="center" nowrap style="border-top: 1px solid #000099;"> 
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%end if%>
			</td>
			<td width="5" align="center" nowrap style="border-top: 1px solid #000099;">&nbsp;</td>
			<td width="250" height="20" style="border-top: 1px solid #000099;">
				<table width="100%" cellpadding="0" cellspacing="0" onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;" onClick="form1.match<%=rs("matchnr")%>[0].checked=true">
				<tr>
				<td><%=rs("thuisploeg")%></td>
				<td width="10" height="20" align="center" nowrap> 
				<%if sw = 1 then
					if rs1("prono") = 1 then%>
						<font color="#FF0000">X</font>					
					<%end if
				else%>
					<input type="radio" value="1" name="match<%=rs("matchnr")%>" tabindex="<%=(2*tel)+1%>" id=<%=(2*tel)-1%> style="border: none"
					<%if rs1("prono") = 1 then
						%> checked <%
					end if%>> 
				<%end if%>
				</td></tr></table>
			</td>
			<td width="10" height="20" align="center" nowrap style="border-top: 1px solid #000099;">-</td>
			<td width="250" height="20" style="border-top: 1px solid #000099;">
				<table width="100%" cellpadding="0" cellspacing="0" onMouseover="this.style.backgroundColor='#FFFF00';" onMouseout="this.style.backgroundColor='';" style="cursor: pointer; cursor: hand;" onClick="form1.match<%=rs("matchnr")%>[1].checked=true">
				<tr>
				<td><%=rs("uitploeg")%></td>
				<td width="10" height="20" align="center" nowrap> 
					<%if sw = 1 then
						if rs1("prono") = 2 then%>
							<font color="#FF0000">X</font>					
						<%end if
					else%>
						<input type="radio" value="2" name="match<%=rs("matchnr")%>" tabindex="<%=(2*tel)+2%>" id=<%=(2*tel)%> style="border: none"
						<%if rs1("prono") = 2 then
							%> checked <%
						end if%>> 
					<%end if%>
				</td></tr></table>
			</td>
			</tr>
			<%rs.movenext
			rs1.close
		wend
	End If
rs.close
%>
<tr>
	<!--td colspan="9" align="center" style="border-top: 1px solid #000099;">
   <%if now() < cdate("18/04/2009 17:30:00") then
   		sqlstring = "SELECT schifting FROM tblpronodeelnemers WHERE spelernr = "&nummer
		rs.open sqlstring %>
        <p><b>Schiftingsvraag: Hoeveel punten scoren de Limburgse ploegen in totaal tijdens de wedstrijden die op 18/4 en 19/4 meetellen voor de pronostiek?&nbsp;</b><input type="text" name="schifting" value="<%=rs("schifting")%>"/><br/>Invullen voor 18/4/2009 om 17u30.</p>
  		<%rs.close
    end if%>
    </td-->
</tr>
<tr>
	<td colspan="9" align="center" bgcolor="#DDDDDD" style="border-top: 1px solid #000099;"><input type="submit" value="Verzenden"></td>
</tr>


</form>
</table>

<p align="center">Je kan je pronostiek ingeven vanaf 7 dagen voor de wedstrijd tot een half uur voor de wedstrijd. De eerste speeldag kan je nu wel al invullen.</p>
<p align="center"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronouitloggen.asp" class="NieuwsLinks">Uitloggen</a></p>
</div>
</body>
</html>
