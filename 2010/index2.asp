<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%titel="Home"%>
<!--#include file="inc/top.asp" -->
</table>
<ul id="sortable">
	<li>

<h1>Heren</h1>
<%sqlstring = "SELECT * FROM tblnieuws WHERE categorie = 1 ORDER BY datum DESC, id DESC LIMIT 0, 3"
rs.open sqlstring%>
<div id="accordion1">
	<h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
	<div><%=rs("nieuws")%></div>
	<%rs.movenext
    while not rs.eof%>
        <h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
        <div><%=rs("nieuws")%></div>
        <%rs.movenext
    wend
	rs.close%>
</div></li>
<li>
<h1>Ander nieuws</h1>
<%sqlstring = "SELECT * FROM tblnieuws WHERE categorie = 3 ORDER BY datum DESC, id DESC LIMIT 0, 3"
rs.open sqlstring%>
<div id="accordion3">
	<h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
	<div><%=rs("nieuws")%></div>
	<%rs.movenext
    while not rs.eof%>
        <h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
        <div><%=rs("nieuws")%></div>
        <%rs.movenext
    wend
	rs.close%>
</div>
</li>
<li>
<h1>Dames</h1>
<%sqlstring = "SELECT * FROM tblnieuws WHERE categorie = 2 ORDER BY datum DESC, id DESC LIMIT 0, 3"
rs.open sqlstring%>
<div id="accordion2">
	<h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
	<div><%=rs("nieuws")%></div>
	<%rs.movenext
    while not rs.eof%>
        <h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
        <div><%=rs("nieuws")%></div>
        <%rs.movenext
    wend
	rs.close%>
</div></li>
<li>
<h1>In de marge</h1>
<%sqlstring = "SELECT * FROM tblnieuws WHERE categorie = 4 ORDER BY datum DESC, id DESC LIMIT 0, 3"
rs.open sqlstring%>
<div id="accordion4">
	<h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
	<div><%=rs("nieuws")%></div>
	<%rs.movenext
    while not rs.eof%>
        <h3><a href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=day(rs("datum"))%>.<%=month(rs("datum"))%> - <%=rs("onderwerp")%></a></h3>
        <div><%=rs("nieuws")%></div>
        <%rs.movenext
    wend
	rs.close%>
</div>
</li>
<!--#include file="inc/bottom.asp" -->
