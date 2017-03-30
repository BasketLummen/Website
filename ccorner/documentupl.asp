<!--#include file="Loader.asp"-->
<HEAD>
<TITLE></TITLE>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<BODY> 
<%
artikel = load.getValue("artikel")
if artikel <> "" then
	fileData = load.getFileData("file")
	fileName = LCase(load.getFileName("file"))
	filePath = load.getFilePath("file")
	filePathComplete = load.getFilePathComplete("file")
	fileSize = load.getFileSize("file")
	fileSizeTranslated = load.getFileSizeTranslated("file")
	contentType = load.getContentType("file")
	countElements = load.Count
	Set load = Nothing


	con = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& Server.MapPath("db1.mdb")
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open "Tabel1", con, 2, 2

	if fileSize > 0 then
			rs.AddNew
			rs("typedoc") = contentType
			rs("document").AppendChunk fileData
			rs("filename") = fileName
			rs("filesize") = fileSize
			rs.Update		   
	end if
	rs.Close

	%>
	
	<p><%=artikel%> is toegevoegd.</p>
<%else%>
	<h3>Artikel toevoegen</h3>
	<form name="form1" enctype="multipart/form-data" method="post">
	<table>
		<tr>
			<td>Artikel</td>
			<td><input type="text" name="artikel" size="60"></td>
		</tr>
		<tr>
			<td valign="top">Afbeelding<br>(max. 200 kb)</td>
			<td valign="top"><input type="file" name="file" size="60"></td>
		</tr>
	</table>
	<input type="submit" value="Toevoegen">
	<input type="reset" value="Velden leegmaken">
	</form>
<%end if%>
</BODY>
</HTML>