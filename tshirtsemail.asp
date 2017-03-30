<!--#include file="ccorner/connect.asp" -->
<%
email=request("email")
if email<>"" and not isnull(email) then
	sqlstring="SELECT maat, aantal FROM tbltshirts WHERE email = '"&email&"'"
	rs.open sqlstring
	if rs.eof then
		response.Write("Dit is uw eerste bestelling")
	else
		response.Write("U bestelde reeds: ")
		while not rs.eof
			response.Write(rs("aantal")&"x "&rs("maat")&"; ")
			rs.movenext
		wend
	end if
	rs.close
end if
con.close
%>