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
set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con


if Session("PR_Username1") <> "" Then
	sqlString = "SELECT naam, spelernr FROM tblpronodeelnemers WHERE naam = '" & Session("PR_Username1") & "' AND voornaam = '" & Session("PR_Username2") & "'"
	rs.open sqlString
	nummer = rs ("spelernr")
	deelnemer = rs("naam")
	rs.close

	dtm=trim(request("dtm"))
	if dtm="" or not isDate(dtm) then dtm=date()
	dtm=cdate(dtm)
	
	
	if dtm < cDate("07/09/2012") then
		dtm = cDate("07/09/2012")
	elseif weekday(dtm) = 1 then
		dtm = dtm - 6
	else	
		dtm = dtm - weekday(dtm) + 2
	end if
	
	sqlString = "SELECT matchnr, reeks, datum, thuisploeg, uitploeg FROM tblpronowedstrijden " &_
				"WHERE datum between ('" & year(dtm) & "-" & month(dtm) & "-" & day(dtm) & "') " &_
				"AND ('" & year(dtm+7) & "-" & month(dtm+7) & "-" & day(dtm+7) & "') " &_
				"ORDER BY matchnr"
	rs.open sqlString
	
	%>
<table border="0" cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="8" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> U hebt deze pronostiek gegeven</td>
   </tr>
		<%
		tel=0
		while not rs.eof
			if (rs("datum") < dateadd("n", 30, now()) or rs("datum") > dateadd("d", 7, now())) and not (now() < cdate("04/09/2012") and rs("datum") < cdate("10/09/2012")) then
				sw = 1
			else
				pr = trim(request("match" & rs("matchnr")))
				if isnull(pr) or pr = "" then
					sqlString = "UPDATE tblpronostiek SET prono = NULL WHERE spelernr = " & nummer & " AND matchnr = " & rs("matchnr")
					sw = 0
				else
					sqlString = "UPDATE tblpronostiek SET prono = " & pr & " WHERE spelernr = " & nummer & " AND matchnr = " & rs("matchnr")			
					sw = 2
				end if
				con.execute sqlString
				
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
			<td width="180" height="20" nowrap style="border-top: 1px solid #000099;<%
				if rs1("prono") = 1 then
					%> background-color:#FFFF00;<%
				end if
			%>">&nbsp;<%=rs("thuisploeg")%></td>
			<td width="10" height="20" align="center" nowrap style="border-top: 1px solid #000099;">-</td>
			<td width="180" height="20" nowrap style="border-top: 1px solid #000099;<%
				if rs1("prono") = 2 then
					%> background-color:#FFFF00;<%
				end if
			%>">&nbsp;<%=rs("uitploeg")%></td>
			</tr>
			<%rs.movenext
			rs1.close
		wend
	rs.close
   if now() < cdate("18/04/2009 17:30:00") then
		schifting = trim(request("schifting"))
		sqlstring = "UPDATE tblpronodeelnemers SET schifting = '"&schifting&"' WHERE spelernr = "&nummer
		con.execute sqlstring
	end if%>	
<!--tr>
	<td colspan="9" align="center" style="border-top: 1px solid #000099;">
   		<%sqlstring = "SELECT schifting FROM tblpronodeelnemers WHERE spelernr = "&nummer
		rs.open sqlstring %>
        <p><b>Schiftingsvraag: Hoeveel punten scoren de Limburgse ploegen in totaal tijdens de wedstrijden die op 18/4 en 19/4 meetellen voor de pronostiek? Antwoord : <%=rs("schifting")%></b></p>
  		<%rs.close%>
    </td>
</tr-->
	<%con.close
	%>
	<tr align="center" bgcolor="#DDDDDD"> 
	  <td colspan="8" align="center" class="NieuwsTitels" style="border-top: 1px solid #000099;"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Bedankt voor uw deelname</td>
	</tr>
        <tr bgcolor="#DDDDDD"> 
          <td colspan="8">
		  <table cellspacing=0 width="100%"><tr>
		  <td width="33%">
		  <% If dtm > cDate("7/09/2012") then%>
		  	<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronoingeven.asp?week=<%=dtm-7%>&k=x" class="NieuwsLinks">vorige</a>
		  <% End If %>
		  </td>
		  <td align="center" width="33%">
		<form name="jump">
		<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<%dtm=cdate("08/09/2012")%>
			<option value="pronoingeven.asp?week=<%=dtm%>">Kies andere datum</option>
			<%while dtm < cdate("15/04/2013")%>
    			<option value="pronoingeven.asp?week=<%=dtm%>"><%=day(dtm)%>&nbsp;<%=MonthName(Month(dtm),true)%>
			 	- <%=day(dtm+1)%>&nbsp;<%=MonthName(Month(dtm+1),true)%></option>
				<%dtm = dtm + 7
				wend%>
		</select>
		</form>
		  </td>
		  <td align="right" width="33%">
		  <% If dtm < cDate("15/04/2013") then%>
		  	<img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronoingeven.asp?week=<%=dtm+7%>" class="NieuwsLinks">volgende</a>
		  <% End If %>
		  </td>
		  </tr></table>
		  </td>
        </tr>
	</table>
	<p align="center"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> <a href="pronouitloggen.asp" class="NieuwsLinks">Uitloggen</a></p>
<%end if%>
</div>
</body>
</html>
