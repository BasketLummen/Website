<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect2.asp" -->
<%
temp = 1
intClub = 1438
dim pl(30,3)
seizoen = trim(request("s"))
if isnull(seizoen) then seizoen = ""

begin=trim(request("week"))
if begin="" or not isDate(begin) then begin=date()
dag = WeekDay(begin)
if dag < 4 then
	begin = DateAdd("d", -(dag + 3), begin)
else
	begin = DateAdd("d", -(dag - 4), begin)
end if
eind = DateAdd("d", 7, begin)

sqlString = "SELECT * FROM tblPloegenkal"&seizoen&" " &_
			"WHERE ploeg_id Between (" & intClub & " *10000) And ((" & intClub & " + 1)*10000) " &_ 
			"ORDER BY ploeg_id"
rs.open sqlString
i=0

if rs.eof then
	sqlString = "SELECT * FROM tblPloegenkal"&seizoen&" " &_
			"WHERE ploeg_id Between (1438 * 10000) And ((1439)*10000) ORDER BY ploeg_id"
	rs.open sqlString	
end if

while not rs.eof
	pl(i,0)=rs("ploeg_id")
	pl(i,1)=rs("plnaam2")
	if rs("enkelbeker") = 1 then
		pl(i,2)=1
	else
		pl(i,2)=0
	end if
	i = i+1
	rs.movenext
wend
%>
<html>
<head>
<title>
	<%=day(cdate(begin))%>
	<%if month(cdate(begin)) =  month(cdate(eind)) then
		%> tot <%=day(cdate(eind))%>&nbsp;<%=monthname(month(cdate(begin)))%><%
	else
		%>&nbsp;<%=monthname(month(cdate(begin)))%> tot <%=day(cdate(eind))
		%>&nbsp;<%=monthname(month(cdate(eind)))%><%
	end if%></title>
<link href="inc/1438.css" rel="stylesheet" type="text/css">
</head>

<body>

<%


%>
<div align="center"> 
		<form name="jump">
		<select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
			<%dtm=cdate("02/08/2014")%>
			<option value="kalweekclub.asp?s=<%=seizoen%>">Kies andere datum</option>
			<%while dtm < cdate("1/05/2015")%>
    			<option value="kalweekclub.asp?s=<%=seizoen%>&week=<%=dtm%>"><%=day(dtm)%>&nbsp;<%=MonthName(Month(dtm),true)%>
			 	- <%=day(dtm+1)%>&nbsp;<%=MonthName(Month(dtm+1),true)%></option>
				<%dtm = dtm + 7
				wend%>
		</select>&nbsp;&nbsp;&nbsp;
		<select name="menu1" onchange=location=document.jump.menu1.options[document.jump.menu1.selectedIndex].value; value="GO">
				<option>Sorteren op...</option>
				<option value="kalweekclub.asp?s=<%=seizoen%>&week=<%=begin%>">Ploeg</option>
				<option value="kalweekclubuur.asp?s=<%=seizoen%>&week=<%=begin%>">Uur</option>
		</select>
		</form>
		</div>
<table width="630" border="0" align="center" cellspacing="0" cellpadding="3">
	<tr><th colspan="7"><a href="kalweekclub.asp?s=<%=seizoen%>&week=<%=begin-7%>"><img src="img/driehoek_rood2.gif" width="5" height="9" border="0" alt="vorige"></a>
		 
		  Wedstrijden in weekend van <%=day(cdate(begin + 3))%>
		<%if month(cdate(begin + 3)) =  month(cdate(begin + 4)) then
			%> en <%=day(cdate(begin + 4))%>&nbsp;<%=monthname(month(cdate(begin + 3)))%><%
		else
			%>&nbsp;<%=monthname(month(cdate(begin + 3)))%> en <%=day(cdate(begin + 4))
			%>&nbsp;<%=monthname(month(cdate(begin + dag + 3)))%><%
		end if%>
		<a href="kalweekclub.asp?s=<%=seizoen%>&week=<%=begin+7%>"><img src="img/driehoek_rood.gif" width="5" height="9" border="0" alt="volgende"></a>	</th>
		</tr>
<%
swkleur=" class=even"
for j = 0 to i-1
	sw=0
	rs.close
	sqlString = "Select wedstrijd_id, reeksnr, datum, thuisresult, uitresult, thuisploeg, uitploeg, opm, locatie, " &_
				"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, " &_ 
				"tblPloegenkal.plnaam2 AS thuispl2, tblPloegenkal1.plnaam2 AS uitpl2 " &_ 
				"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
				"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
				"AND datum between ('" & year(begin) & "-" & month(begin) & "-" & day(begin) & "') " &_
				"AND ('" & year(eind) & "-" & month(eind) & "-" & day(eind) & "') " &_
				"AND (thuisploeg = " & pl(j,0) & " OR uitploeg = " & pl(j,0) & ") " &_
				"ORDER BY datum, wedstrijd_id"
	rs.open sqlString
	if rs.eof and pl(j,2) = 1 then
	else
		if swkleur = "" then
			swkleur = " class=even"
		else
			swkleur = ""
		end if%>
		<tr<%=swkleur%>><td width="130">
		&nbsp;<a href="kalploeg.asp?s=<%=seizoen%>&v=<%=v%>&ploeg=<%=pl(j,0)%>"><%=pl(j,1)%></a>
		</td><%
	if temp = 0 or rs.eof then   'TEMP = 0 INDIEN KALENDER NOG NIET GETOOND MAG WORDEN
		%><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><%		
	else
		while not rs.eof
			if sw=1 then
				%><tr<%=swkleur%> height="15"><td></td><%
			end if
			sw=1%>
	    <td align="right">
			<%if rs("opm") = "" or isnull(rs("opm")) or rs("opm") = "BvV" or rs("opm") = "BvB" or rs("opm") = "BvL" or rs("reeksnr") = 99 then%>
				<%=rs("wedstrijd_id")%>
			<%end if%>&nbsp;
		</td>
			<td width="170" nowrap><%=rs("thuispl")%></td><td width="210" nowrap><%=rs("uitpl")%>
				<%if not isnull(rs("opm")) then%>
					<span class="beker">&nbsp;(<%=rs("opm")%>)</span>
				<%elseif not isnull(rs("locatie")) and rs("locatie") <> "" and rs("locatie") <> " " then%>
                    <span class="beker">(<%=rs("locatie")%>)</span>
                <%end if%>
                
			</td>
			<td width="70" align="center" nowrap="nowrap"><%=rs("thuisresult")%>-<%=rs("uitresult")%></td>
			<td width="20" align="right"><%=WeekDayName(WeekDay(rs("datum")),true)%></td>
			<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%else%>
				&nbsp;
			<%end if%>
			</td>
			</tr>
			<%rs.movenext
		wend
	end if
	end if
next
rs.close
con.close
%>
</table>
</p>
<p>&nbsp;</p>
<div align="center">
<script language="JavaScript"><!-- Begin
if (window.print) {
document.write('<form>'
+ '<input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></form>');
}
// End -->
</script>

</p>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-5769703-4']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script></body>
</html>

