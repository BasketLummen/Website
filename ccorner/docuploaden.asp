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
End If

%>
<!--#include file="connect.asp" -->
<!--#include file="loader.asp"-->
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - docuement uploaden</title>
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
<!--#include file="menudocumenten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 175px; top: 40px; width: 600px;">

<p class="NieuwsTitels"><font size="3">Document uploaden</font></p>

<%
soort = int(trim(request.QueryString("soort")))
oefsoort = trim(request.QueryString("oefsoort"))
if Session("BL_soort")<3 and soort > 1000 then 
	oefsoort = trim(request.QueryString("jcdoc"))
end if

response.Buffer = true
Set load = new Loader
load.initialize   'calling initialize method


docsoort = load.getValue("docsoort")
if docsoort <> "" then
	if docsoort = 100 or docsoort = 200 or docsoort = 300 or docsoort = 400 or docsoort = 500 or docsoort = 600 then	docsoort = docsoort + 1

	fileData = load.getFileData("file")
	fileName = LCase(load.getFileName("file"))
	filePath = load.getFilePath("file")
	filePathComplete = load.getFilePathComplete("file")
	fileSize = load.getFileSize("file")
	fileSizeTranslated = load.getFileSizeTranslated("file")
	contentType = load.getContentType("file")
	countElements = load.Count

	rs.CursorLocation = 3
	rs.open "SELECT * FROM tbldocumenten", con, 2, 3
	
	
	if fileSize > 0 then
		rs.addnew
		rs("docsoort") = docsoort
		rs("docnaam") = fileName
		rs("doctype") = contentType
		rs("docsize") = fileSizeTranslated
		rs("document").AppendChunk fileData
		rs("datum") = year(date())&"-"&month(date())&"-"&day(date())&" "&time()
		rs("auteur") = session("BL_lidid")
		rs.Update
	end if
	rs.Close
	Set load = Nothing

	%>
	
	<p>Document is geupload.</p>
<%else%>
	<form name="form1" enctype="multipart/form-data" method="post">
	<table>
		<tr>
			<td>Soort</td>
	<%if soort > 1000 or soort = 208 then%>
				<td colspan="2">
			<p class="NieuwsTitels"><font size="3">
			<%if soort = 1001 then
				sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1100 AND id < 1200 ORDER BY id"%>
				EFI
			<%elseif soort = 1002 then
				sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1200 AND id < 1300 ORDER BY id"%>
				Scouting
			<%elseif soort = 1003 then
				sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1300 AND id < 1400 ORDER BY id"%>
				FGT
			<%elseif soort = 1004 then
				sqlString = "SELECT * FROM tbldocsoorten WHERE id > 1400 AND id < 1500 ORDER BY id"%>
				CEFI
			<%elseif soort = 208 then
				sqlString = "SELECT * FROM tbldocsoorten WHERE id > 2000 AND id < 2100 ORDER BY id"%>
				Oefeningen
			<%end if
			rs.open sqlString%>
				<select name="docsoort">
				<%if soort = 208 then
					%><option value="208">Register</option><%
				end if
				while not rs.eof%>
				  <option value="<%=rs("id")%>"<%
				  if int(oefsoort) = rs("id") then
				  	%> selected<%
				  end if%>><%=rs("docsoort")%>
					</option>
					<%rs.movenext
				wend
				rs.close%>
			</select></font></p>
			</td>
	<%else%>
				<td colspan="2"><select name="docsoort">
				<%sqlString = "SELECT * FROM tbldocsoorten WHERE id < 1000 ORDER BY id"
				rs.open sqlString
				while not rs.eof%>
				  <option value="<%=rs("id")%>"<%
				  if soort = rs("id") then
				  	%> selected<%
				  end if%>>
					<%if rs("id") = 100 or rs("id") = 200 or rs("id") = 300 or rs("id") = 400 or rs("id") = 500 or rs("id") = 600 then%>
					<%=rs("docsoort")%>
					<%else%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("docsoort")%>
					<%end if%>
					</option>
					<%rs.movenext
				wend
				rs.close%>
			</select>
			</td>
	<%end if%>
		<tr>
			<td valign="top">Document</td>
			<td valign="top" colspan="2"><input type="file" name="file" size="60"></td>
		</tr>
	</table>
	<input type="submit" value="Uploaden">
	</form>
<%end if
con.close%>
</div>
</BODY>
</HTML>