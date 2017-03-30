<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<script language="javascript">
function createCode(){
var temp="";
for(var i=0;i<5;i++)
{
temp+= Math.round(Math.random() * 8 );
}
document.all.theImg.src="JpegImage.aspx?code=" +temp;
document.all.Hidden1.value=temp;
}


</script>
</head>

<body>
<%
if Request.Form("Submit")<> "" then
theCode=Request.Form("Hidden1")
for i= 1 to Len(theCode)
y = CInt( mid(theCode, i,1) +1)
newText=newText & Cstr(y )
next
if Request.Form("CodeNumberTextBox") = newText then
MessageLabel = "Correct!" 
else
MessageLabel="UH OH!"
end if
end if
%>

<body onload="createCode();">
<h2>CaptchaImage Form Test</h2>
<p>&nbsp; <img id="theImg" src=""><br>
</p>
<form id="Default" method="post" action="Default.asp">
<p>
<strong>Enter the code shown above:</strong><br>
<input id="CodeNumberTextBox" name="CodeNumberTextBox" > 
<input type=submit id="Submit " name="Submit" Text="Submit"> 
<INPUT id="Hidden1" type="hidden" name="Hidden1" > 
</p>

<p> <input type=text id=MessageLabel name=MessageLabel value="<%=MessageLabel%>">
</form> 

</body>
</html>
