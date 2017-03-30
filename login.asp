<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="wijzig/md5.asp" -->
<!--#include file="connect.asp" -->
<%
'MM_wedstrijden_STRING = "dsn=basketlummen;"
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Request.QueryString
MM_valUsername=CStr(Request.Form("username"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization="permissie"
  MM_redirectLoginSuccess="wijzig/menu.asp"
  MM_redirectLoginFailed="login.asp"
  'MM_flag="ADODB.Recordset"
  'set rs = Server.CreateObject(MM_flag)
  'rs.ActiveConnection = MM_wedstrijden_STRING
  rs.Source = "SELECT username, password, user_id "
  If MM_fldUserAuthorization <> "" Then rs.Source = rs.Source & "," & MM_fldUserAuthorization
  rs.Source = rs.Source & " FROM tblUsers WHERE username='" & md5(Replace(MM_valUsername,"'","''")) &"' AND password='" & md5(Replace(Request.Form("password"),"'","''")) & "'"
  rs.CursorType = 0
  rs.CursorLocation = 2
  rs.LockType = 3
  rs.Open
  If Not rs.EOF Or Not rs.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
	Session("MM_User_ID") = rs("user_id")
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(rs.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And true Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    rs.Close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  rs.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>
<html>
<head>
<title>Inloggen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<form name="inloggen" method="POST" action="<%=MM_LoginAction%>">
<table cellspacing="0" cellpadding="3" align="center" style="border-top: 2px solid #DDDDDD; border-right: 2px solid #DDDDDD; border-bottom: 2px solid #DDDDDD; border-left: 2px solid #DDDDDD;">
	<tr bgcolor="#DDDDDD"> 
		<td align="center" colspan="3" class="NieuwsTitels"><img src="../img/driehoek_rood.gif" width="5" height="9" border="0">  Log in met je gebruikersnaam en wachtwoord</td>
	</tr>
  <tr>
	<td>Gebruikersnaam</td> 
    <td><input name="username" type="text" id="username" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
  	<td>Wachtwoord</td> 
    <td><input name="password" type="password" id="password" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></td>
  </tr>
  <tr>
      <td align="center" colspan="2"><input type="submit" name="Submit" value="Inloggen"></td>
  </tr>
</table></td></tr></table>
</form>
<script language="javascript">
  document.inloggen.username.focus();
</script>
</body>
</html>
