<!--#include file="ccorner/connect.asp"-->
<%
rs.Open "select foto, fototype from tblfotos where fotoid =" & Request("id")

If Not rs.eof Then
	Response.ContentType = rs("fototype")
	Response.BinaryWrite rs("foto")
End If

rs.Close
con.Close

%>
