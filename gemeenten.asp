<!--#include file="connect2.asp" -->
<!--#include file="JSON_2.0.4.asp"-->
<!--#include file="JSON_UTIL_0.1.1.asp"-->
<%
sqlstring = "SELECT gemeente FROM tblGemeenten GROUP BY gemeente ORDER BY gemeente"
QueryToJSON(con, sqlstring).Flush
%>
