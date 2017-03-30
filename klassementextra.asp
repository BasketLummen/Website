<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect2.asp" -->
<html>
<head>
<title>Klassement</title>
<link href="inc/1438.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
seizoen = trim(request("s"))
if isnull(seizoen) then seizoen = ""


dim klas(20,7)
intReeks=trim(request("reeks"))
limburg = trim(request("l"))
if limburg <> "" and not isnull(limburg) then
	wedstrijdtabel = "(SELECT tblWedstrijden.wedstrijd_id, tblWedstrijden.reeksnr, tblWedstrijden.speeldag, tblWedstrijden.datum, tblWedstrijden.thuisploeg, tblWedstrijden.uitploeg, tblWedstrijden.thuisresult, tblWedstrijden.uitresult, tblWedstrijden.locatie FROM tblWedstrijden"&seizoen&" AS tblWedstrijden WHERE Mid(thuisploeg,5,1)=3 AND Mid(uitploeg,5,1)=3) AS tblWedstr"
else
	wedstrijdtabel = "tblWedstrijden"&seizoen
end if

'**********************************************************************************************
'selecteren van de ploegen

sqlString = "SELECT thuisploeg, ploegnaam, Count(wedstrijd_id) AS aant " &_
			"FROM "&wedstrijdtabel&", tblPloegenkal"&seizoen&" " &_
			"WHERE ploeg_id = thuisploeg " &_
			"AND reeksnr = " & intReeks & " " &_
			"GROUP BY thuisploeg, ploegnaam, reeksnr"
'response.Write(sqlstring)			
rs.open sqlString
if not rs.eof then
aantal=cint(rs("aant"))
if intReeks = 101 or intReeks = 1501 then
	aantal = aantal / 2
end if

'ploegen in de array zetten
for i=0 to aantal
	klas(i,0) = rs("thuisploeg")
	klas(i,1) = rs("ploegnaam")
	for j= 2 to 7
		klas(i,j) = 0
	next
	'if intReeks= 31111 then
	'	select case rs("thuisploeg")
	'	 case 9363112:
	'		klas(i,7) = 4
	'	 case 23503111:
	'		klas(i,7) = 3
	'	 case 10953111:
	'		klas(i,7) = 2
	'	 case 14383113:
	'		klas(i,7) = 1
	'	end select
	'end if
	rs.movenext
next
'**********************************************************************************************
'berekenen van het klassement
for i = 0 to aantal
	rs.close
	'thuismatchen
	sqlString= "SELECT thuisresult, uitresult " &_ 
			   "FROM "&wedstrijdtabel&" " &_ 
			   "WHERE reeksnr = " & intReeks & " " &_
			   "AND thuisploeg = " & klas(i,0) & " " &_
			   "AND thuisresult is not null " &_
			   "AND datum > '2013-11-12 00:00:00'"


	rs.open sqlString
	while not rs.eof
	  thuisres = rs("thuisresult")
	  uitres = rs("uitresult")
	  if thuisres > uitres then
		klas(i,2) = klas(i,2) + 1
		klas(i,7) = klas(i,7) + 3
	  elseif thuisres < uitres then
		klas(i,4) = klas(i,4) + 1
		if not(thuisres = 0 and uitres = 20) then
			klas(i,7) = klas(i,7) + 1
		end if
	  elseif thuisres = uitres then
		if uitres = 20 and thuisres = 20 then
			klas(i,4) = klas(i,4) + 1				
		else
			klas(i,3) = klas(i,3) + 1
			klas(i,7) = klas(i,7) + 2
		end if
	  end if
	  klas(i,5) = klas(i,5) + thuisres
	  klas(i,6) = klas(i,6) + uitres
	  rs.movenext
	wend
	
	'uitmatchen
	rs.close
	sqlString= "SELECT thuisresult, uitresult " &_ 
			   "FROM "&wedstrijdtabel&" " &_ 
			   "WHERE reeksnr = " & intReeks & " " &_
			   "AND uitploeg = " & klas(i,0) & " " &_
			   "AND thuisresult is not null " &_
			   "AND datum > '2013-11-12 00:00:00'"

	rs.open sqlString
	while not rs.eof
	  thuisres = rs("thuisresult")
	  uitres = rs("uitresult")
	  if uitres > thuisres then
		klas(i,2) = klas(i,2) + 1
		klas(i,7) = klas(i,7) + 3
	  elseif uitres < thuisres then
		klas(i,4) = klas(i,4) + 1
		if not(uitres = 0 and thuisres = 20) then
			klas(i,7) = klas(i,7) + 1
		end if
	  elseif thuisres = uitres then
		if uitres = 20 and thuisres = 20 then
			klas(i,4) = klas(i,4) + 1				
		else
			klas(i,3) = klas(i,3) + 1
			klas(i,7) = klas(i,7) + 2
		end if
	  end if
	  klas(i,5) = klas(i,5) + uitres
	  klas(i,6) = klas(i,6) + thuisres
	  rs.movenext
	wend
next

'**********************************************************************************************
		

'sorteren op punten
for i = 1 to aantal
	for j = 0 to aantal - i
		if klas(j,7) < klas(j+1,7) then
				for k = 0 to 7
					x = klas (j,k)
					klas(j,k) = klas(j+1,k)
					klas(j+1,k) = x
				next
		elseif klas(j,7) = klas(j+1,7) then
			if klas(j,2) < klas(j+1,2) then
					for k = 0 to 7
						x = klas (j,k)
						klas(j,k) = klas(j+1,k)
						klas(j+1,k) = x
					next
			elseif  klas(j,2) = klas(j+1,2) then
				rs.close
				sqlString = "SELECT thuisploeg, thuisresult, uitresult FROM "&wedstrijdtabel&" " &_ 
							"WHERE thuisploeg = " & klas (j,0) & " AND uitploeg = " & klas (j+1,0) & " " &_
							"AND thuisresult is not null AND reeksnr = " & intReeks
				rs.open sqlString
				versch = 0
				if not rs.eof then
					versch = rs("thuisresult") - rs("uitresult")
				end if
				rs.close
				sqlString = "SELECT thuisploeg, thuisresult, uitresult FROM "&wedstrijdtabel&" " &_ 
							"WHERE thuisploeg = " & klas (j+1,0) & " AND uitploeg = " & klas (j,0) & " " &_
							"AND thuisresult is not null AND reeksnr = " & intReeks
				rs.open sqlString			
				if not rs.eof then
					versch = versch - rs("thuisresult") + rs("uitresult")
				end if
				if versch < 0 then
					for k = 0 to 7
						x = klas (j,k)
						klas(j,k) = klas(j+1,k)
						klas(j+1,k) = x
					next
				elseif versch = 0 then
					if (klas(j,5) - klas(j,6)) < (klas(j+1,5) - klas(j+1,6)) then	
						for k = 0 to 7
							x = klas (j,k)
							klas(j,k) = klas(j+1,k)
							klas(j+1,k) = x
						next
					elseif (klas(j,5) - klas(j,6)) = (klas(j+1,5) - klas(j+1,6)) then
						if klas(j,5) < klas(j+1,5) then
							for k = 0 to 7
								x = klas (j,k)
								klas(j,k) = klas(j+1,k)
								klas(j+1,k) = x
							next
						end if
					end if
				end if
			end if
		end if
	next
next

rs.close

'berekenen van de datum
begin = date()
dag = WeekDay(begin)
if dag < 4 then
	begin = DateAdd("d", (-dag-1), begin)
else
	begin = begin - dag + 6
end if
eind = begin + 3


'selecteren van het programma van dit weekend
sqlString = "SELECT datum, thuisresult, uitresult, " &_
			"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl, locatie " &_ 
			"FROM "&wedstrijdtabel&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
			"WHERE thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id " &_
			"AND reeksnr = " & intReeks & " " &_
			"AND datum between ('" & year(begin) & "-" & month(begin) & "-" & day(begin) & "') " &_
			"AND ('" & year(eind) & "-" & month(eind) & "-" & day(eind) & "') " &_
			"ORDER BY datum"
rs.open sqlString

'tonen van het programma
if not rs.eof then%>
<table cellspacing="0" cellpadding="3" align="center">
    <tr> 
    	<th>Programma</th>
        <th colspan="2">Uitslag</th>
    </tr>
	<%
	swkleur=" class=even"
	while not rs.eof
		if swkleur = "" then
			swkleur = " class=even"
		else
			swkleur = ""
		end if
		%>
		<tr<%=swkleur%>>
			<td width="320" nowrap>&nbsp;<%=rs("thuispl")%>&nbsp;-&nbsp;<%=rs("uitpl")%></td>
			<%if isnull(rs("thuisresult")) then
				if rs("locatie") = "uitgesteld" then%>
                    <td colspan="2"><font size="1">(uitgesteld)</font></td>
                <%else%>
                    <td width="35" align="right"><%=weekdayname(weekday(rs("datum")),true)%>,</td>
                    <td width="45">
                    <%if not isnull(rs("datum")) then%>
                        <%=FormatDateTime(rs("datum"),4)%>
                    <%end if%>
                    </td>
				<%end if
			else%>
				<td width="35" align="right">&nbsp;<%=rs("thuisresult")%></td>
				<td width="45">-&nbsp;<%=rs("uitresult")%></td>
			<%end if%>
		</tr><%
		rs.movenext
	wend
end if
%>
</table><br>
<%
'selecteren van het klassement
rs.close
sqlString = "SELECT reeksnaam FROM tblReeksen"&seizoen&" WHERE reeks_id = " & intReeks

rs.open sqlString

if rs.eof then%>
	Klassement bestaat niet.
<%else
	'tonen van het klassement%>
<table cellspacing="0" cellpadding="3" align="center">
        <tr> 
          <th colspan="2" nowrap><%=rs("reeksnaam")%></th>
           
          <th width="35"p>M</th>
           
          <th width="35">W</th>
           
          <th width="35">D</th>
           
          <th width="35">V</th>
		   
          <th colspan="2">Score</th>
           
          <th width="35">P</th>
        </tr>
	<%
		swkleur=" class=even"
		for i = 0 to aantal
			if swkleur = "" then
				swkleur = " class=even"
			else
				swkleur = ""
			end if
			%>
		<tr<%=swkleur%>>
			<td width="30" align="center"><%=i+1%></td>
			<td width="150">
				<a href="kalploeg.asp?ploeg=<%=klas(i,0)%>&s=<%=seizoen%>">
			<%
			rs.close
			sqlString = "SELECT ploegnaam FROM tblPloegenkal"&seizoen&" WHERE ploeg_id = " & klas(i,0)
			rs.open sqlString
			%><%=rs("ploegnaam")%></a></td>
			<td width="35" align="center"><%=klas(i,2)+klas(i,3)+klas(i,4)%></td>
			<td width="35" align="center"><%=klas(i,2)%></td>
			<td width="35" align="center"><%=klas(i,3)%></td>
			<td width="35" align="center"><%=klas(i,4)%></td>
			<td width="45" align="right"><%=klas(i,5)%></td>
			<td width="55">- <%=klas(i,6)%></td>
			<td width="35" align="center"><%=klas(i,7)%></td>	
		</tr><%
		next
end if

end if

rs.close

con.close

%>
</table>
<p>&nbsp;</p>
<div align="center">
<script language="JavaScript"><!-- Begin
if (window.print) {
document.write('<form>'
+ '<input type=button name=print value="Afdrukken" '
+ 'onClick="javascript:window.print()"></form>');
}
// End -->
</script></p>
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
