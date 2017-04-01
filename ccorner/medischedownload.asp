<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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

set con = server.createobject("ADODB.Connection")
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=ba7863; database=basketlummen; option=3; port=3306;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con

rs.CursorLocation = 3
tonen = true
id = request("id")
if session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"AND tblPloegen.ploegid = " & id & " ORDER BY ploegid"
	rs.open sqlString
	if rs.eof then
		tonen = false
		response.write("U hebt geen toestemming om dit document te openen") 
	end if
	rs.close
end if

if tonen = true then




sqlString = "select bestand, bestandtype, ploegnaam from tblmedischefiches, tblploegen WHERE tblmedischefiches.ploegid = tblploegen.ploegid AND tblmedischefiches.ploegid = " & id
rs.Open sqlString, con, 2, 3

If Not rs.eof Then
	response.AddHeader "Content-Type", rs("bestandtype")
	response.AddHeader "Content-Disposition", "attachment; filename="&rs("ploegnaam")&".zip;"
	Response.ContentType = rs("bestandtype")
	Response.BinaryWrite(rs("bestand"))
else
	response.write("Document niet gevonden") 
End If
end if

rs.Close
con.Close

%>
