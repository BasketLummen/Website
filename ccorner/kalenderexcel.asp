<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
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



%>
<!--#include file="connect.asp" -->
<!--#include file="loader.asp"-->
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Kalender excel</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input, select {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #FFFFFF;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 175px; top: 40px; width: 600px;">
<p class="NieuwsTitels"><font size="3">Kalender excel.</font></p>
<%
sqlString = "SELECT docid, docnaam, doctype, docsize, datum, naam, voornaam " &_
		"FROM tblkalenderexcel, tblleden WHERE id = auteur"
rs.open sqlstring

%>

<p>
<a href="#" onClick="window.open('downloadkalender.asp','','width=800,height=600px,scrollbars=yes,resizable=yes,toolbar=yes,status=yes');return(false)">Download laatste versie</a> van <%=rs("datum")%>, geüpload door <%=rs("voornaam")%>&nbsp;<%=rs("naam")%>.


<%rs.close
if Session("BL_soort") < 3 then%>


<p class="NieuwsTitels"><font size="2">Uploaden nieuwe versie (in RAR-bestand).</font></p>

<%

response.Buffer = true
Set load = new Loader
load.initialize   'calling initialize method

fileData = load.getFileData("file")
fileName = LCase(load.getFileName("file"))
filePath = load.getFilePath("file")
filePathComplete = load.getFilePathComplete("file")
fileSize = load.getFileSize("file")
fileSizeTranslated = load.getFileSizeTranslated("file")
contentType = load.getContentType("file")
countElements = load.Count

if fileSize > 0 then
	sqlstring = "DELETE FROM tblkalenderexcel"
	con.execute sqlstring
	rs.CursorLocation = 3
	rs.Open "tblkalenderexcel", con, 2, 2
	rs.addnew
	rs("docnaam") = fileName
	rs("doctype") = contentType
	rs("docsize") = fileSizeTranslated
	rs("document").AppendChunk fileData
	rs("datum") = year(date())&"-"&month(date())&"-"&day(date())&" "&time()
	rs("auteur") = session("BL_lidid")
	rs.Update
	rs.Close
	Set load = Nothing

	%>
	
	<p>Kalender is geupload.</p>
<%else%>
	<form name="form1" enctype="multipart/form-data" method="post">
	<table>
		<tr>
			<td valign="top">Document</td>
			<td valign="top" colspan="2"><input type="file" name="file" size="60"></td>
		</tr>
	</table>
	<input type="submit" value="Uploaden">
	</form>
<%end if
end if
con.close%>
</div>
</BODY>
</HTML>