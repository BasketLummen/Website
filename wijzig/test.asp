<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="md5.asp" -->
<!--#include file="connect2.asp" -->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<br>

<%
txt = trim(request("md5"))
response.Write(md5(txt)&"<br>")

%>
</body>
</html>