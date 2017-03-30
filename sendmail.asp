<%toon=0%>
<html>
<head>
<title>Verzonden</title>
<link href="opmaak.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<%
tekst = request.Form()
tekst = Replace(tekst, "&", "<br>")

if isempty(conf) then
        const cdosendusingport = 2
        set conf = createobject("cdo.configuration")

        with conf.fields
			.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
            .Update
        end with
end if


Set myMail=CreateObject("CDO.Message")
'myMail.SmtpServer="localhost"
myMail.configuration = conf
myMail.Subject=request.QueryString("subject")
myMail.From=request.Form("naam")&" ("&request.Form("email")&")"
myMail.To="johnny.peeters@basketlummen.be"
myMail.HTMLBody = tekst 
myMail.Send
set myMail=nothing

'Dim Mail
'Set Mail = CreateObject("Persits.MailSender")

'Mail.Host = "localhost" 
'Mail.From = request.Form("email") 
'Mail.FromName = request.Form("naam") 
'Mail.IsHTML = True 
'Mail.Subject = subject
'Mail.AddAddress "johnny.peeters@basketlummen.be"

'Mail.Body = tekst & "<br>" & request.Form("telnr")

'On Error Resume Next
'	Mail.Send
'If Err <> 0 Then
'   Response.Write "Error encountered: " & Err.Description
'else%>
	<p>Uw formulier is verzonden<p>
	<p>Bedankt voor uw deelname</p><hr>
<%'End If%>
</div>

</body>
</html>
