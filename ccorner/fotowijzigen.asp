<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<!--#include file="loader.asp"-->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,3"
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

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - lid wijzigen</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%
id = trim(request("id"))

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

response.Buffer = true
Set load = new Loader
load.initialize   'calling initialize method
	countElements = load.Count


	fileData = load.getFileData("file")
	fileName = LCase(load.getFileName("file"))
	filePath = load.getFilePath("file")
	filePathComplete = load.getFilePathComplete("file")
	fileSize = load.getFileSize("file")
	fileSizeTranslated = load.getFileSizeTranslated("file")
	contentType = load.getContentType("file")
	countElements = load.Count
	Set load = Nothing
	
	rs.CursorLocation = 3
	sqlstring = "SELECT foto FROM tblleden WHERE id = " & id 
	rs.open sqlstring, con, 2, 3
	if not isnull(rs("foto")) and rs("foto") <> "" then
		sqlString = "DELETE FROM tblfotos WHERE fotoid = " & rs("foto")
		con.execute sqlstring
	end if
	rs.close
	
	if fileSize > 0 then
		rs.Open "tblfotos", con, 2, 2
		rs.addnew
		rs("fototype") = contentType
		rs("foto").AppendChunk fileData
		rs.Update
		rs.close
		sqlString = "SELECT fotoid FROM tblfotos WHERE fotoid = LAST_INSERT_ID()" 
		rs.open sqlString
		sqlstring = "UPDATE tblleden SET foto = " & rs("fotoid") & " WHERE id = " & id
		con.execute sqlstring
		rs.close
	end if
	
con.close
response.Redirect("lidwijzigen.asp?id="&id)%>
</div>
</body>
</html>
