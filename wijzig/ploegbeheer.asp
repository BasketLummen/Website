<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" --><%
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
strPlnr = Request("frmPlnr")
wijzigen = Request("wijzigen")
toevoegen = Request("toevoegen")
strPlnaam = trim(request("frmPlnaam"))
if isnull(strPlnaam) or strPlnaam = "" then
	  Response.Redirect("ploegtoevoegen.asp")
else
	strPlcoach = trim(Request("frmPlCoach"))
	strPlcmail = trim(Request("frmPlcmail"))
	strPlassc = trim(Request("frmPlassc"))
	strPlasscmail = trim(Request("frmPlasscmail"))
	strFoto = trim(request("foto"))
	strPeter = trim(Request("peter"))
	strMeter = trim(Request("meter"))
	strFotocoach = trim(Request("fotocoach"))
	strFotoass = trim(Request("fotoass"))
	

	%>
	<html>
	<head>
	<title>Ploegen</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../opmaak.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
	<%
	if wijzigen = 2 then
	  sqlString = "DELETE FROM tblPloegen WHERE plnr = " & strPlnr
	  con.execute sqlString
	else
	  if wijzigen = 1 then
		sqlString = "UPDATE tblPloegen " &_
					  "SET " &_
						"plnr = " & strPlnr & ", " &_
						"plnaam = '" & strPlnaam & "', " &_
						"Plcoach = '" & strPlcoach & "', " &_
						"Foto = '" & strFoto & "', " &_
						"Peter = '" & strPeter & "', " &_
						"Meter = '" & strMeter & "', " &_
						"fotocoach = '" & strFotocoach & "', " &_
						"fotoass = '" & strFotoass & "' " &_
					  "WHERE plnr = " & strPlnr
		con.execute sqlString
	  
	  elseif toevoegen = 1 then
		sqlString = "SELECT MAX(plnr) AS maxNr FROM tblPloegen"
		set rs = con.Execute(sqlString)
		strPlnr = rs("maxNr") + 1
		sqlString = "INSERT INTO tblPloegen" &_
						"(plnr, plnaam, plcoach) " &_ 
					"VALUES" &_
						"( " & strPlnr & ", '" & strPlnaam & "', '" & strPlcoach & "')"
		con.execute sqlString
	  end if
	  if isnull(strPlcmail) or strPlcmail = "" then
		con.execute "UPDATE tblPloegen SET plcmail = NULL WHERE Plnr = " & strPlnr
	  else
		con.execute "UPDATE tblPloegen SET plcmail = '" & strPlcmail & "' WHERE Plnr = " & strPlnr
	  end if
	  if isnull(strPlassc) or strPlassc = "" then
		con.execute "UPDATE tblPloegen SET plassc = NULL WHERE Plnr = " & strPlnr
	  else
		con.execute "UPDATE tblPloegen SET plassc = '" & strPlassc & "' WHERE Plnr = " & strPlnr
	  end if
	  if isnull(strPlasscmail) or strPlasscmail = "" then
		con.execute "UPDATE tblPloegen SET plasscmail = NULL WHERE Plnr = " & strPlnr
	  else
		con.execute "UPDATE tblPloegen SET plasscmail = '" & strPlasscmail & "' WHERE Plnr = " & strPlnr
	  end if
	end if
	%>
	De gegevens van de <%=strPlnaam%> zijn opgeslaan.
	<p align="center"><a href="menu.asp" class="nieuwslinks">Terug naar het menu</a></p>
	</body>
	</html>
<%end if%>
