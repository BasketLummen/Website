<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%Session.LCID = 2067%>
<%toon=8%>
<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Function CheckCAPTCHA(valCAPTCHA)
	SessionCAPTCHA = Trim(Session("CAPTCHA"))
	Session("CAPTCHA") = vbNullString
	if Len(SessionCAPTCHA) < 1 then
        CheckCAPTCHA = False
        exit function
    end if
	if CStr(SessionCAPTCHA) = CStr(valCAPTCHA) then
	    CheckCAPTCHA = True
	else
	    CheckCAPTCHA = False
	end if
End Function
%>
<!--#include file="ccorner/connect.asp"-->
<html>
<head>
<title>Basket Lummen - Gastenboek</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:640px; height:436px; z-index:1; left: 120px; top: 70px;">
<p class="NieuwsTitels"><font size="2">Voeg een bericht toe aan het gastenboek</font></p>
<%
if Request.ServerVariables("REQUEST_METHOD") = "POST" then
	strCAPTCHA = Trim(Request.Form("strCAPTCHA"))
	naam = trim(request.Form("naam"))
	bericht = trim(request.Form("bericht"))
	if instr(bericht, "stront") = 0 and instr(naam, "http") = 0 and instr(reactie, "http") = 0 and instr(reactie, "javascript") = 0 and instr(bericht, "SCRIPT") = 0 then
		bericht = Replace(bericht, "<a", "")
		bericht = Replace(bericht, "href=", "")
		bericht = Replace(bericht, "<script", "")
		bericht = Replace(bericht, "<meta", "")
		bericht = Replace(bericht, chr(13) & chr(10), "<br>")
		bericht = Replace(bericht, "'", "´")
		email = trim(request.Form("email"))
		if CheckCAPTCHA(strCAPTCHA) = true then
			if naam <> "" and bericht <> "" and not isnull(naam) and not isnull(bericht) then
				ip = Request.ServerVariables ("REMOTE_ADDR")
				dtm = year(date())&"-"&month(date())&"-"&day(date())&" "&time()		
				sqlString = "INSERT INTO tblgastenboek(naam,email,ip,datum,bericht) "&_
							"VALUES('"&naam&"','"&email&"','"&ip&"','"&dtm&"','"&bericht&"')"
				con.execute sqlString
				response.Redirect("gastenboek.asp")
			end if
		else
			verkeerde = true	
		end if
	end if
end if
%>


<form method="post" action="gastenboektoevoegen.asp">
  <table border="0" align="center">
    <tr> 
        <td>Naam:</td>
        <td><input type="text" name="naam" size="50" value="<%=naam%>"></td>
      </tr>
      <tr> 
        <td>E-Mail:</td>
        <td><input type="text" name="email" size="50" value="<%=email%>"></td>
      </tr>
      <tr>
	    <td colspan="2">Bericht :</td>
      </tr>
      <tr>
	    <td colspan="2"><textarea name="bericht" cols="70" rows="10"><%=bericht%></textarea></td>
      </tr>
	  <tr><td colspan="2">
	  <%if verkeerde = true then%>
			<b>U hebt een verkeerd getal ingegeven, probeer opnieuw</b><br>
	  		Vul ter controle onderstaand getal in het volgende veld in:
	  <%else%>
	  		Vul ter controle onderstaand getal in het volgende veld in:
	  <%end if%>
	  </td>
	  </tr>
	  <tr>
	  	<td><img src="aspcaptcha.asp" alt="This Is CAPTCHA Image" width="86" height="21" /></td>
		<td><input name="strCAPTCHA" type="text" id="strCAPTCHA" maxlength="8" /></td>
	  </tr>
      <tr>
	    <td colspan="2"align="center"><input type="submit" value="Toevoegen"></td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>
