<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%><!--#include file="connect.asp"-->

<%

rs.CursorLocation = 3
sqlString = "select document, doctype, docnaam from tbldocumenten WHERE docid = " & request("id")
if Session("BL_soort") > 3 then
	sqlString = sqlString & " AND (docsoort < 1000 or docsoort > 2000)"
end if
rs.Open sqlString, con, 2, 3

If Not rs.eof Then
	response.AddHeader "Content-Type", rs("doctype")
	response.AddHeader "Content-Disposition", "inline;filename=" & rs("docnaam")
	Response.ContentType = rs("doctype")
	Response.BinaryWrite rs("document")
else
	response.write("U hebt geen toestemming om dit document te openen") 
End If

rs.Close
con.Close

%>
