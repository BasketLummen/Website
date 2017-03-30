<!--#include file="ccorner/connect.asp" --><%
sqlstring = "SELECT maat, sum(aantal) as totaal FROM tbltshirts group by maat"
rs.open sqlstring
som = 0
while not rs.eof
	response.Write(rs("maat")&": "&rs("totaal")&" - "
	rs.movenext
wend
rs.close%>