<?xml version="1.0" encoding="utf-8"?>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
set con = server.createobject("ADODB.Connection")
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=ba7863; database=basketlummen; option=3; port=3306;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con

reeks = request("reeks")

Sqlstring = "SELECT ll FROM tblsporthallen WHERE "

Select case reeks
	case 30101:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 34 OR sporthalnr = 20 OR sporthalnr = 29 OR sporthalnr = 40 OR sporthalnr = 5 " &_
		"OR sporthalnr = 32 OR sporthalnr = 25 OR sporthalnr = 26 OR sporthalnr = 19 OR sporthalnr = 21 OR sporthalnr = 22 OR sporthalnr = 30"
	case 1113:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 15 OR sporthalnr = 179 OR sporthalnr = 61 OR sporthalnr = 189 OR sporthalnr = 186 " &_
		"OR sporthalnr = 124 OR sporthalnr = 92 OR sporthalnr = 56 OR sporthalnr = 24 OR sporthalnr = 22 OR sporthalnr = 36 OR sporthalnr = 83 OR sporthalnr = 74"
	case 104:
		sqlstring = sqlstring & "sporthalnr = 17 OR sporthalnr = 272 OR sporthalnr = 6 OR sporthalnr = 137 OR sporthalnr = 42 OR sporthalnr = 28 " &_
		"OR sporthalnr = 132 OR sporthalnr = 99 OR sporthalnr = 149 OR sporthalnr = 61 OR sporthalnr = 36 OR sporthalnr = 175 OR sporthalnr = 98 OR sporthalnr = 54"
	case 203:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 34 OR sporthalnr = 72 OR sporthalnr = 276 OR sporthalnr = 54 OR sporthalnr = 66 " &_
		"OR sporthalnr = 149 OR sporthalnr = 274"
	case 303:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 2 OR sporthalnr = 72 OR sporthalnr = 179 OR sporthalnr = 84 OR sporthalnr = 77 " &_
		"OR sporthalnr = 102 OR sporthalnr = 178"
	case 402:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 2 OR sporthalnr = 18 OR sporthalnr = 72 OR sporthalnr = 84 OR sporthalnr = 8 " &_
		"OR sporthalnr = 93  OR sporthalnr = 149"
	case 1302:
		sqlstring = sqlstring & "sporthalnr = 31 OR sporthalnr = 36 OR sporthalnr = 24 OR sporthalnr = 74 OR sporthalnr = 179 OR sporthalnr = 92 " &_
		"OR sporthalnr = 71 OR sporthalnr = 155"
end select
rs.open sqlstring 
%>
<markers>
	<%while not rs.eof%>
    <marker lat='<%=replace(rs("ll"),",","' lng='")%>' />
    	<%rs.movenext
	wend
	rs.close
	con.close%>
</markers>
