<!--#include file="ccorner/connect.asp" --><%
sqlstring = "SELECT sum(aantal) as totaal FROM tbltshirts"
rs.open sqlstring
response.Write(rs("totaal"))
rs.close
con.close
%>