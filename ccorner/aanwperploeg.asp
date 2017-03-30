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
<!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Aanwezigheden</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
td,p  {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
select {
	background-color: #FFFFFF;
}
input {
	text-align: center;
}
textarea {
	border: 1px solid #000099;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
	color: #000099;
}
-->
</style>
<script language="javascript">
function telop(nummer)
{
	
	//alert(nummer)

}
</script>
</head>

<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuleden.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px;">
<%

set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

ploegid=trim(request("ploegid"))
if ploegid="" or isnull(ploegid) then ploegid = 0

if session("BL_soort") < 3 then
	sqlString = "SELECT ploegid, ploegnaam FROM tblPloegen WHERE actief = true ORDER BY ploegid"
	rs.open sqlString
elseif session("BL_soort") > 2 then
	sqlString = "SELECT tblPloegen.ploegid, ploegnaam FROM tblPloegen, tblploegedit " &_
				"WHERE tblPloegen.ploegid = tblPloegedit.ploegid AND lidid = " & session("BL_lidid") & " "&_
				"ORDER BY ploegid"
	rs.open sqlString
end if
if rs.eof then%>
	<p>Enkel beschikbaar voor coaches.</p>
<%else
if ploegid = 0 then
	response.Redirect("aanwperploeg.asp?ploegid="&rs("ploegid"))
end if

maand = request.QueryString("maand")
if maand = "" or isnull(maand) then
	if date() < cdate("01/09/2006") then
		maand = cdate("01/08/2006")
	else
		if day(date()) < 4 then
			maand=dateAdd("m",-1,date())
		end if
		maand = cdate("01"&"/"&month(date())&"/"&year(date()))
	end if
end if

%>

<p class="NieuwsTitels"><font size="3">Aanwezigheden op training</font></p>
<form name="jump">
	<p>Ploeg <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
	<%while not rs.eof%>
		<option value="aanwperploeg.asp?ploegid=<%=rs("ploegid")%>&amp;maand=<%=maand%>"<%
		if int(ploegid) = rs("ploegid") then
			%> selected="selected"<%
		end if
		%>><%=rs("ploegnaam")%></option>
		<%rs.movenext
	wend
	rs.close%>
	</select></p>
</form>

	
<%
toon = true

if session("BL_soort") = 3 or session("BL_soort") = 4 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE ploegid = " & ploegid & " AND lidid = " & session("BL_lidid")
	rs1.open sqlString
	if rs1.eof then
		toon = false
	end if
	rs1.close
end if
if toon = true then

Set rs1 = Server.CreateObject("ADODB.Recordset")
rs1.activeconnection = con

sqlString = "SELECT id, naam, voornaam FROM tblleden WHERE (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ") AND status = 'A' ORDER BY naam, voornaam"
rs.open sqlString

opsl = trim(request("opsl"))
if opsl = "ok" then
	sqlString = "DELETE FROM tblaanwezigheden WHERE maand = '" & year(maand)&"-"&month(maand)&"-"&day(maand) & "' AND ploegid = " &ploegid
	con.execute sqlString
	while not rs.eof
		tr = trim(request("tr_"&rs("id")))
		if isnull(tr) or tr = "" then tr = 0
		if tr > 0 then
			aw = trim(request("aw_"&rs("id")))
			if isnull(aw) or aw = "" then aw = 0
			vo = trim(request("vo_"&rs("id")))
			if isnull(vo) or vo = "" then vo = 0
			zv = trim(request("zv_"&rs("id")))
			if isnull(zv) or zv = "" then zv = 0
			gk = trim(request("gk_"&rs("id")))
			if isnull(gk) or gk = "" then gk = 0
			opm = trim(request("opm_"&rs("id")))
			sqlString = "INSERT INTO tblAanwezigheden VALUES("&rs("id")&", '" & year(maand)&"-"&month(maand)&"-"&day(maand) & "', "&ploegid&", "&tr&", "&aw&", "&vo&", "&zv&", "&gk&", '"&opm&"', "&Session("BL_lidid")&")"
			con.execute sqlString
		end if
		rs.movenext
	wend
	sqlString = "UPDATE tblploegen SET aanwupd = '"&year(date())&"-"&month(date())&"-"&day(date())&"' WHERE ploegid = "&ploegid
	con.execute sqlstring
	rs.movefirst%>
	<p>De gegevens zijn opgeslaan.</p>
<%end if%>
<form name="jump1">
	<p>Maand 
	<select name="menu" onChange="location=document.jump1.menu.options[document.jump1.menu.selectedIndex].value;" value="GO">
	<%dtm = cdate("01/08/2006")
	while dtm < cdate("01/06/2007")%>
		<option value="aanwperploeg.asp?ploegid=<%=ploegid%>&amp;maand=<%=dtm%>"
		<%if cdate(maand) = cdate(dtm) then
			%> selected="selected"<%
		end if%>
		><%=monthname(month(dtm))%></option>
		<%dtm=dateAdd("m",1,dtm)
	wend%>
	</select></p>
</form>
<%sqlString = "SELECT aanwupd FROM tblploegen WHERE ploegid = " & ploegid
rs1.open sqlString
%><P><b>Laatste update: <%=rs1("aanwupd")%></P></b><%
rs1.close
%>
<p><font size="1">TR = aantal trainingen | AW = aanwezig | VO = verontschuldigd | ZV = afwezig zonder verwittiging | GK = gekwetst</font>
<form method="post" action="aanwperploeg.asp?ploegid=<%=ploegid%>&amp;maand=<%=maand%>">
<input type="hidden" name="opsl" value="ok" />
<table>
<tr><th>speler</th>
<th>TR</th>
<th>AW</th>
<th>VO</th>
<th>ZV</th>
<th>GK</th>
<th>Opmerkingen</th>
</tr>
<%while not rs.eof
	sqlString = "SELECT trainingen, aanwezig, verontschuldigd, afwezig, gekwetst, opmerkingen " &_
				"FROM tblAanwezigheden WHERE lidid = " & rs("id") & " AND maand = '" & year(maand)&"-"&month(maand)&"-"&day(maand) & "' " &_
				"AND ploegid = " & ploegid
	rs1.open sqlString
	if rs1.eof then
		tr =0
		aw =0
		vo =0
		zv =0
		gk =0
		opm =""
	else
		tr = rs1("trainingen")
		aw = rs1("aanwezig")
		vo = rs1("verontschuldigd")
		zv = rs1("afwezig")
		gk = rs1("gekwetst")
		opm = rs1("opmerkingen")
	end if%>
	<tr bgcolor="#FFFFFF">
	<td valign="top"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></td>
	<td align="center" width="30" valign="top"><input type="text" name="tr_<%=rs("id")%>" size="5" value="<%=tr%>" id="tr_<%=rs("id")%>" readonly="true" style="border: none;"/></td>
	<td align="center" width="30" valign="top"><input type="text" name="aw_<%=rs("id")%>" size="5" value="<%=aw%>" id="aw_<%=rs("id")%>" 
	onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" 
	onchange="tr_<%=rs("id")%>.value=eval(aw_<%=rs("id")%>.value)+eval(vo_<%=rs("id")%>.value)+eval(zv_<%=rs("id")%>.value)+eval(gk_<%=rs("id")%>.value);" /></td>
	<td align="center" width="30" valign="top"><input type="text" name="vo_<%=rs("id")%>" size="5" value="<%=vo%>" id="vo_<%=rs("id")%>" 
	onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"
	 onchange="tr_<%=rs("id")%>.value=eval(aw_<%=rs("id")%>.value)+eval(vo_<%=rs("id")%>.value)+eval(zv_<%=rs("id")%>.value)+eval(gk_<%=rs("id")%>.value);" /></td>
	<td align="center" width="30" valign="top"><input type="text" name="zv_<%=rs("id")%>" size="5" value="<%=zv%>" id="zv_<%=rs("id")%>" 
	onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"
	 onchange="tr_<%=rs("id")%>.value=eval(aw_<%=rs("id")%>.value)+eval(vo_<%=rs("id")%>.value)+eval(zv_<%=rs("id")%>.value)+eval(gk_<%=rs("id")%>.value);" /></td>
	<td align="center" width="30" valign="top"><input type="text" name="gk_<%=rs("id")%>" size="5" value="<%=gk%>" id="gk_<%=rs("id")%>" 
	onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"
	 onchange="tr_<%=rs("id")%>.value=eval(aw_<%=rs("id")%>.value)+eval(vo_<%=rs("id")%>.value)+eval(zv_<%=rs("id")%>.value)+eval(gk_<%=rs("id")%>.value);" /></td>
	<td><textarea name="opm_<%=rs("id")%>" cols="25" rows="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"><%=opm%></textarea></td>
	</tr>
	<%rs1.close
	rs.movenext
wend%>
</table>
<input type="submit" value="opslaan"  style="cursor:hand;cursor:pointer;" onmouseover="style.backgroundColor='#FFFF00';" onmouseout="style.backgroundColor=''" />
</form>
<%end if
end if%>
</div>
</body>
</html>
