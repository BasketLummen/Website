<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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
End If%>
<!--#include file="connect.asp"-->
<%
ploegid=trim(request("ploegid"))
if ploegid="" or isnull(ploegid) then ploegid = 0

if session("BL_soort") < 4 then
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
	rs.open sqlString
elseif session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"ORDER BY ploegid"
	rs.open sqlString
end if
if rs.eof then%>
	<p>Enkel beschikbaar voor coaches.</p>
<%else
	verantw1 = request("verantw1")
	verantw2 = request("verantw2")
	verantw3 = request("verantw3")
	
	sqlstring = "UPDATE tblPloegen SET verantw1 = "&verantw1&",verantw2 = "&verantw2&",verantw3 = "&verantw3&" WHERE ploegid = "&ploegid
	response.Write(sqlstring)
	con.execute sqlstring 
	response.Redirect("ploegen.asp?ploegid="&ploegid)
end if%>


