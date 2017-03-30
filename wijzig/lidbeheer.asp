<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
MM_authFailedURL="../login.asp"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (false Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
%>
<%
strNr = Request("frmNr")
wijzigen = Request("wijzigen")
toevoegen = Request("toevoegen")
strVoornaam = trim(request("frmVoornaam"))
if isnull(strVoornaam) or strVoornaam = "" then
	  Response.Redirect("lidtoevoegen.asp")
else
	strNaam = trim(request("frmNaam"))
	strGebDatum = Request("frmGebDatum")
	strPloeg = trim(Request("frmPloeg"))
	strPlnr1 = Request("frmPlnr1")
	strPlnr2 = Request("frmPlnr2")
	strFoto = Request("frmFoto")
	
	
	
	%>
	<html>
	<head>
	<title>Ledenbeheer</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../opmaak.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
	<%
	if wijzigen = 2 then
	  sqlString = "DELETE FROM tblLeden WHERE lidnr = " & strNr
	  con.execute sqlString
	else
	  if wijzigen = 1 then
		sqlString = "UPDATE tblLeden " &_
					  "SET " &_
						"voornaam = '" & strVoornaam & "', " &_
						"naam = '" & strNaam & "', " &_
						"Ploeg = '" & strPloeg & "', " &_
						"Foto = '" & strFoto & "' " &_
					  "WHERE lidnr = " & strNr
		con.execute sqlString
	  
	  elseif toevoegen = 1 then
		sqlString = "SELECT MAX(lidnr) AS maxNr FROM tblLeden"
		set rs = con.Execute(sqlString)
		strNr = rs("maxNr") + 1
		sqlString = "INSERT INTO tblLeden" &_
						"(lidnr, voornaam, naam, Ploeg) " &_ 
					"VALUES" &_
						"( " & strNr & ", '" & strVoornaam & "', '" & strNaam & "', '" & strPloeg & "')"
		con.execute sqlString
	  end if
	  If isNull("strGebDatum") or strGebDatum = "" then
		con.execute "UPDATE tblLeden SET gebdatum = NULL WHERE lidnr = " & strNr
	  else
		strGebDatum = cDate(strGebDatum)
		con.execute "UPDATE tblLeden SET gebdatum = '" & strGebDatum & "' WHERE lidnr = " & strNr
	  end if
	  if isnull(strPlnr1) or strPlnr1 = "" then
		con.execute "UPDATE tblLeden SET plnr1 = NULL WHERE lidnr = " & strNr
	  else
		con.execute "UPDATE tblLeden SET plnr1 = " & strPlnr1 & " WHERE lidnr = " & strNr
	  end if
	  if isnull("strPlnr2") or strPlnr2 = "" then
		con.execute "UPDATE tblLeden SET plnr2 = NULL WHERE lidnr = " & strNr
	  else
		con.execute "UPDATE tblLeden SET plnr2 = '" & strPlnr2 & "' WHERE lidnr = " & strNr
	  end if
	end if
	%>
	De gegevens van <%=strVoornaam%>&nbsp;<%=strNaam%> zijn opgeslaan.
	<p align="center"><a href="menu.asp" class="nieslinks">Terug naar het menu</a></p>
	</body>
	</html>
<%end if%>