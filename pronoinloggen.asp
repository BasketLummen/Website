<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="ccorner/connect.asp" -->
<%
dn = trim(request("dn"))

' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Request.QueryString
MM_valUsername=CStr(Request.Form("paswoord"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="pronoingeven.asp"
  MM_redirectLoginFailed="pronoinloggen.asp?dn=" & dn
  rs.Source = "SELECT naam, paswoord"
  If MM_fldUserAuthorization <> "" Then rs.Source = rs.Source & "," & MM_fldUserAuthorization
  rs.Source = rs.Source & " FROM tblpronodeelnemers WHERE naam='" & Session("pronolognaam") &"' AND voornaam = '" & Session("pronologvoornaam") & "' AND paswoord='" & Replace(Request.Form("paswoord"),"'","''") & "'"
  rs.CursorType = 0
  rs.CursorLocation = 2
  rs.LockType = 3
  rs.Open
  If Not rs.EOF Or Not rs.BOF Then 
    ' username and password match - this is a valid user
    Session("PR_Username1") = Session("pronolognaam")
	Session("PR_Username2") = Session("pronologvoornaam")
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(rs.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    rs.Close
	Session("foutbericht") = ""
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  rs.Close
  Session("PR_Username1") = ""
  Session("PR_Username2") = ""
  Session("foutbericht") = "U hebt een verkeerd wachtwoord ingegeven, probeer opnieuw"
  Response.Redirect(MM_redirectLoginFailed)
End If

Session("pronolognaam") = ""
Session("pronologvoornaam") = ""


%>
<%toon=4%>
<html>
<head>
<title>Basket Lummen - Pronostiek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
sqlString = "SELECT voornaam, naam FROM tblpronodeelnemers WHERE spelernr = " & dn
rs.open sqlString
if not rs.eof then
	Session("pronolognaam") = rs("naam")
	Session("pronologvoornaam") = rs("voornaam")
%>
<p align="center"><%=Session("foutbericht")%></p>
<form name="inloggen" method="POST" action="<%=MM_LoginAction%>">
<table cellspacing="0" cellpadding="5" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="2" class="NieuwsTitels"><img src="img/driehoek_rood.gif" width="5" height="9" border="0"> Geef uw wachtwoord om in te loggen</td>
	</tr>
	<tr> 
		<td>Naam:</td>
		<td><%=Session("pronologvoornaam")%>&nbsp;<%=Session("pronolognaam")%></td>
	</tr>
	<tr> 
		<td>Wachtwoord:</td>
		<td><input name="paswoord" type="password" id="paswoord" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
	</tr>
	<tr> 
		<td align="center" colspan="2"><input type="submit" name="Submit" value="Inloggen" tabindex="2" style="background-color='#FFFF00';"> 
		</td>
	</tr>
</table>
</form>

<script language="javascript">
  document.inloggen.paswoord.focus();
</script>

<%
end if
Session("foutbericht") = ""

rs.close

%>
</div>
</body>
</html>
