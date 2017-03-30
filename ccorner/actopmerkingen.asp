<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2,3,4,5"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="connect.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Activiteiten</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.crij {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">
<%act = trim(request("act"))
if act = "" or isnull("act") then act = 1

opm = trim(request("opmerking"))
if opm <> "" and not isnull("opm") then
	opm = Replace(opm, chr(13) & chr(10), "<br>")
	opm = Replace(opm, "'", "´")
	sqlstring = "INSERT INTO tblactopmerkingen(activiteit,opmerking,datum,auteur) values("&act&",'"&opm&"','"&year(date())&"-"&month(date())&"-"&day(date())&" "&time()&"',"&session("BL_lidid")&")"
	con.execute sqlstring
end if

sqlstring = "SELECT * FROM tblactoverzicht ORDER BY naam"
rs.open sqlstring%>

<form name="jump">
    <p>Evenement <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
    <%while not rs.eof%>
        <option value="actopmerkingen.asp?act=<%=rs("id")%>"<%
        if int(act) = rs("id") then
            %> selected="selected"<%
        end if
        %>><%=rs("naam")%></option>
        <%rs.movenext
    wend
    rs.close%>
    </select></p>
</form>

<form method="post" action="actopmerkingen.asp?act=<%=act%>"> 
<textarea id="opmerking" name="opmerking" cols="80" rows="5"></textarea><br />
<input type="submit" value="opmerking toevoegen" />
</form>



<%
if act > 0 then
	sqlstring = "SELECT naam, voornaam, activiteit, opmerking, datum FROM tblactopmerkingen, tblleden WHERE auteur = tblleden.id AND activiteit = "&act&" ORDER BY datum DESC"
	rs.open sqlstring
	while not rs.eof%>
		<p><i>Van <%=rs("voornaam")%>&nbsp;<%=rs("naam")%> op <%=rs("datum")%>,</i><br />
        <%=rs("opmerking")%></p>
        <hr />
		<%rs.movenext
	wend
end if
%>



</div>

<!--#include file="kalender.asp"-->
<%con.Close%>
</BODY>
</HTML>  