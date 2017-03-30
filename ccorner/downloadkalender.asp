<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="205"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

set shell = createobject("WScript.Shell")
connectionString = shell.ExpandEnvironmentStrings("MYSQLCONNSTR_localdb")

set con = server.createobject("ADODB.Connection")
con.Open connectionString

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con

rs.CursorLocation = 3
sqlString = "select document, doctype, docnaam, docsize from tblkalenderexcel"
rs.Open sqlString, con, 2, 3

If Not rs.eof Then
	response.AddHeader "Content-Type", rs("doctype")
	response.AddHeader "Content-Disposition", "attachment; filename=" & rs("docnaam") & ";"
	Response.ContentType = rs("doctype")
	Response.BinaryWrite(rs("document"))
else
	response.write("U hebt geen toestemming om dit document te openen") 
End If

rs.Close
con.Close

%>
