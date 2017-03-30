<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%intPloeg=trim(request("ploeg"))%>
<!--#include file="connect2.asp" -->
<%

seizoen = trim(request("s"))
if isnull(seizoen) then seizoen = ""





sqlString = "SELECT reeksnaam, reeks_id FROM tblWedstrijden"&seizoen&", tblReeksen"&seizoen&" " &_
			"WHERE (thuisploeg = " & intPloeg & " OR uitploeg = " & intPloeg & ") " &_ 
			"AND reeksnr = reeks_id ORDER BY wedstrijd_id"
rs.open sqlString			

if rs.eof then
	%>Foutieve ploegnummer.<%
else

rksnm = rs("reeksnaam")
rksnr = rs("reeks_id")

rs.close

sqlString = "SELECT plnaam2 from tblPloegenkal"&seizoen&" WHERE ploeg_id = " & intPloeg
rs.open sqlString
naam=rs("plnaam2")
rs.close

sqlString = "Select wedstrijd_id, reeksnr, speeldag, datum, thuisresult, uitresult, opm, verslag, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl , reeksnaam, reeksnr, " &_ 
			"tblPloegenkal.sporthal, thuisploeg, uitploeg " &_
			"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1, tblReeksen"&seizoen&" " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
			"AND reeksnr = reeks_id " &_
			"AND (thuisploeg = " & intPloeg & " OR uitploeg = " & intPloeg & ") ORDER BY datum"

rs.open sqlString

set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con
%>
<html>
<head>
<title>Kalender <%=naam%></title>
<link href="inc/1438.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


if rs.eof then
	%><p>Nog geen wedstrijden.</p><%
else
	%>
	<table cellspacing=0 cellpadding="3" align="center">
		<tr> 
            <th>matchnr</th>
            <th colspan="2">datum</th>
            <th width="50">uur</th>
            <th colspan="2"><%=naam%></th>
            <th colspan="2"> uitslag</th>
          </tr>
	<%
	sw=0
	sw1=0
	swkleur="class=even"
	while sw1=0 and not rs.eof
	  if (sw=1 or not isnull(rs("datum"))) then
		if swkleur = "" then
			swkleur = " class=even"
		else
			swkleur = ""
		end if
		%>
	   <tr<%=swkleur%>>
	    <td align="right">
			<%if rs("opm") = "" or isnull(rs("opm")) or rs("opm") = "BvV" or rs("opm") = "BvB" or rs("opm") = "BvL" or rs("reeksnr") = 99 then%>
				<%=rs("wedstrijd_id")%>
			<%end if%>&nbsp;
		</td>
		<td width="20" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=WeekDayName(WeekDay(rs("datum")),true)%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="40" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=day(rs("datum"))%>/<%=month(rs("datum"))%>
			<%else%>
				&nbsp;
			<%end if%>
		 </td>
		<td width="50" align="center">
			<%if not isnull(rs("datum")) then%>
				<%=FormatDateTime(rs("datum"),4)%>
			<%else%>
				&nbsp;
			<%end if%>
		</td>
		<td nowrap>
			<%if rs("verslag") = 1 then%>				
				<a href="verslag.asp?matchnr=<%=rs("wedstrijd_id")%>" class="verslag"><%=rs("thuispl")%></a></td><td nowrap><a href="verslag.asp?matchnr=<%=rs("wedstrijd_id")%>" class="verslag"><%=rs("uitpl")%></a>
			<%else%>
				<%=rs("thuispl")%></td><td nowrap><%=rs("uitpl")%>
			<%end if%>
			<%if not isnull(rs("opm")) then%>
				<span class="beker">(<%=rs("opm")%>)</span>
			<%end if%>
		</td>
		<%
		if (rs("thuisresult") = "" or isnull(rs("thuisresult"))) and (left(intPloeg,4) = 1438 or rs("opm") = "LVH") then%>
			<td align="center" colspan="2">&nbsp;
				<%if (rs("uitploeg") > 14380000 and rs("uitploeg") < 14390000 and rs("sporthal") > 0)  or rs("opm") = "lvh" then
					if rs("opm") = "lvh" then%>
                    <a href="#" onClick="window.open('http://www.basketlummen.be/sporthal.asp?sponsor=ja&sh=36','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=620,height=500');return(false)" class="info">i</a>
					<%else%>
                    <a href="#" onClick="window.open('http://www.basketlummen.be/sporthal.asp?sponsor=ja&sh=<%=rs("sporthal")%>','Plan','toolbar=no,location=0,directories=0,status=0,scrollbars=yes,resizable=yes,copyhistory=0,menuBar=0,width=620,height=500');return(false)" class="info">i</a>					
					<%end if
			end if%>
			</td>
		<%else%>
		<td width="30" align="right">&nbsp;<%=rs("thuisresult")%></td>
		<td width="40">- <%=rs("uitresult")%></td>
		<%end if%>
      </tr>
	    <%
	  end if 
	  rs.movenext
	  if rs.eof and sw=0 then
		rs.movefirst
		if isnull(rs("datum")) then
			sw=1
		else
			sw1=1
		end if
	  elseif sw = 1 then
		if not isnull(rs("datum")) then
			sw1=1
		end if
	  end if
	wend
end if
end if
rs.close



con.close

%>
</table>
<div align="center">
<script language="JavaScript"><!-- Begin
if (window.print) {
document.write('<form>'
+ '<input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></form>');
}
// End -->
</script></div>
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