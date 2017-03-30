<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<%
adres = request("adres")
if isempty(conf) then
		const cdosendusingport = 2
		set conf = createobject("cdo.configuration")

		with conf.fields
			.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
			.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
			.Update
		end with
end if

Set myMail=CreateObject("CDO.Message")
myMail.configuration = conf
myMail.Subject="Dit is een test"
myMail.From="Basket Lummen (johnny.peeters@basketlummen.be)"

myMail.To=adres
myMail.HTMLBody = "Dit is een test"
myMail.Send
set myMail=nothing

%>
Mail is verzonden
</body>
</html>
