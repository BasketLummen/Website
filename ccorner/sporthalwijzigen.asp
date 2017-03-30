<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
MM_authorizedUsers2="205"
MM_authFailedURL="index.asp"
MM_grantAccess=false
If Session("BL_username") <> "" Then
  If (false Or CStr(Session("BL_soort"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("BL_soort"))>=1) or (InStr(1,MM_authorizedUsers2,Session("BL_lidid"))>=1)  Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  Response.Redirect("index.asp")
End If

%><!--#include file="connect.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Coach Corner</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
tr, input, select {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #FFFFFF;
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
}
table {
	background-color: #CCCCCC;
}
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}

-->
</style>
</head>

<BODY>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 600px;">


<%
dtm = request.QueryString("dtm")
if dtm = "" or isnull(dtm) then dtm = date()
dtm = cdate(dtm)

sqlstring = "SELECT datum, sh1, sh2, sh3, ohvm, zolder FROM tblsporthaluren " &_ 
			"WHERE day(datum) = " & day(dtm) & " AND month(datum)= " & month(dtm) & " " &_
			"AND year(datum) = " & year(dtm) & " " &_
			"ORDER BY datum"
rs.Open sqlString


opsl=trim(request.form("opsl"))
if opsl="ok" then
	dim mnd(10,3)
	mnd(0,0) = "aug"
	mnd(0,1) = 8
	mnd(1,0) = "sep"
	mnd(1,1) = 9
	mnd(2,0) = "okt"
	mnd(2,1) = 10
	mnd(3,0) = "nov"
	mnd(3,1) = 11
	mnd(4,0) = "dec"
	mnd(4,1) = 12
	mnd(5,0) = "jan"
	mnd(5,1) = 1
	mnd(6,0) = "feb"
	mnd(6,1) = 2
	mnd(7,0) = "maa"
	mnd(7,1) = 3
	mnd(8,0) = "apr"
	mnd(8,1) = 4
	mnd(9,0) = "mei"
	mnd(9,1) = 5
	

	dtm1 = year(dtm)&"-"&month(dtm)&"-"&day(dtm)
	
	for i = 0 to 9
		mnd(i,2) = request.Form(mnd(i,0))
	next
	
	while not rs.eof 
		uur = replace(FormatDateTime(rs("datum"),4),":","_")
		dtm2 = dtm1 & " " & FormatDateTime(rs("datum"),4) & ":00"
		sh1 = ucase(trim(request.Form("sh1_"&uur)))
		sh2 = ucase(trim(request.Form("sh2_"&uur)))
		sh3 = ucase(trim(request.Form("sh3_"&uur)))
		ohvm = ucase(trim(request.Form("ohvm_"&uur)))
		zolder = ucase(trim(request.Form("zolder_"&uur)))
		sqlString = "UPDATE tblsporthaluren SET sh1 = '" & sh1 & "', sh2 = '" & sh2 & "', sh3 = '" & sh3 & "', " &_
					"ohvm = '" & ohvm & "', zolder =  '" & zolder & "' " &_ 
					"WHERE datum = '" & dtm2 & "'"
		con.Execute sqlString
		
		for i = 0 to 9
			if mnd(i,2) = "ok" then
				sqlString = "UPDATE tblsporthaluren SET sh1 = '" & sh1 & "', sh2 = '" & sh2 & "', sh3 = '" & sh3 & "', " &_
							"ohvm = '" & ohvm & "', zolder =  '" & zolder & "' " &_ 
							"WHERE month(datum) = " & mnd(i,1) & " AND weekday(datum) = weekday('" & dtm2 & "') AND time(datum) = '"&right(dtm2,8)&"'"	
				response.Write(sqlString&"<br>")
				con.execute SqlString
			end if
		next
		rs.MoveNext
	wend
	response.Redirect("sporthalbezetting.asp?dtm="&dtm)
else%>
<table width="450">
<tr>
<td width="50%"><%if dtm > #27/07/2015# then
	if weekday(dtm)=2 then
		x=3
	else
		x=1
	end if%>
	<a href="sporthalwijzigen.asp?dtm=<%=dtm-x%>" class="NieuwsLinks"><img src="../img/driehoek_rood2.gif" border="0" /> vorige</a>
	<%end if%>
</td>
<td width="50%" align="right"><%if dtm < #31/05/2016# then	
	if weekday(dtm)=6 then
		x=3
	else
		x=1
	end if%>
	<a href="sporthalwijzigen.asp?dtm=<%=dtm+x%>" class="NieuwsLinks">volgende <img src="../img/driehoek_rood.gif" border="0" /></a>
	<%end if%></td>
</tr>
</table>

<%
dim hal(5)
hal(0) = "sh1"
hal(1) = "sh2"
hal(2) = "sh3"
hal(3) = "ohvm"
hal(4) = "zolder"

if not rs.eof then%>
<form method="post" action="sporthalwijzigen.asp?dtm=<%=dtm%>">
<input type="hidden" name="opsl" value="ok">
<table width="500">
	<tr>
	<td colspan="7" class="ccornerTitels"><%=weekdayname(weekday(rs("datum")))%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%></td>
	</tr>
	<tr>
		<th width="50">&nbsp;</th>
		<%for j = 0 to 5%>
		<th width="75"><%=hal(j)%></th>
		<%next%>
	</tr>

<%
i=0
while not rs.eof%>
	<tr>
	<th><%=FormatDateTime(rs("datum"),4)%></th>
	<%for j = 0 to 4%>
	<td align="center"
		<%if rs(hal(j)) = "NB" then%>
			 bgcolor="#CCCCCC"><input type="text" name="<%=hal(j)%>_<%=replace(FormatDateTime(rs("datum"),4),":","_")%>" style="background-color:'#CCCCCC'" size="10" value="NB">
		<%elseif rs(hal(j)) = "C" then%>
			 bgcolor="#FF9900"><input type="text" name="<%=hal(j)%>_<%=replace(FormatDateTime(rs("datum"),4),":","_")%>" style="background-color:'#CCCCCC'" size="10" value="C">
		<%elseif rs(hal(j)) = "M" then%>
			 bgcolor="#0099FF"><input type="text" name="<%=hal(j)%>_<%=replace(FormatDateTime(rs("datum"),4),":","_")%>" style="background-color:'#CCCCCC'" size="10" value="M">
		<%elseif rs(hal(j)) = "" or isnull(rs(hal(j))) then%>
			 bgcolor="#ffffcc"><input type="text" name="<%=hal(j)%>_<%=replace(FormatDateTime(rs("datum"),4),":","_")%>" style="background-color:'#ffffcc'" size="10">
		<%else%>
			><input type="text" name="<%=hal(j)%>_<%=replace(FormatDateTime(rs("datum"),4),":","_")%>" value="<%=rs(hal(j))%>" size="10">
		<%end if%>
		</td>
	<%next%>		
	</tr>
	<%rs.MoveNext
wend%>
</table>
<p>
Dit progamma opslaan voor elke <%=weekdayname(weekday(dtm))%> in:
<table>
<tr>
<td><label for="aug"><input type="checkbox" name="aug" id="aug" value="ok"/> Augustus</label></td>
<td><label for="sep"><input type="checkbox" name="sep" id="sep" value="ok"/> September</label></td>
<td><label for="okt"><input type="checkbox" name="okt" id="okt" value="ok"/> Oktober</label></td>
<td><label for="nov"><input type="checkbox" name="nov" id="nov" value="ok"/> November</label></td>
<td><label for="dec"><input type="checkbox" name="dec" id="dec" value="ok"/> December</label></td></tr>
<tr><td><label for="jan"><input type="checkbox" name="jan" id="jan" value="ok"/> Januari</label></td>
<td><label for="feb"><input type="checkbox" name="feb" id="feb" value="ok"/> Februari</label></td>
<td><label for="maa"><input type="checkbox" name="maa" id="maa" value="ok"/> Maart</label></td>
<td><label for="apr"><input type="checkbox" name="apr" id="apr" value="ok"/> April</label></td>
<td><label for="mei"><input type="checkbox" name="mei" id="mei" value="ok"/> Mei</label></td></tr></table>
<p>NB = Niet beschikbaar voor Basket<br />
M = Match<br />
C = Clinic</p>
<p><input type="submit" value="opslaan" style="cursor:hand;cursor:pointer;"></p>
</form>

<%
end if
end if
rs.Close
con.Close
%>

</div>

</BODY>
</HTML>
