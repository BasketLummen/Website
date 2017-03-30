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
<script language="javascript">
function reservatie(dtm,uur,pl,opm)
{
	if(pl=="sh1")
		form1.plein.selectedIndex=1;
	else if(pl=="sh2")
		form1.plein.selectedIndex=2;
	else if(pl=="sh3")
		form1.plein.selectedIndex=3;
	else if(pl=="ohvm")
		form1.plein.selectedIndex=4;
	else if(pl=="zolder")
		form1.plein.selectedIndex=5;
	form1.datum.value = dtm;
	form1.van.value = uur;
	if(opm=='')
		form1.soort.selectedIndex=1;
	else
		form1.soort.selectedIndex=4;
	form1.tot.focus();
}
</script>

</head>

<BODY>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->
<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 700px;">
<p class="NieuwsTitels"><font size="3">Sporthalbezetting</font></p>
<%

dtm = request.QueryString("dtm")
if dtm = "" or isnull(dtm) then dtm = date()
dtm = cdate(dtm)

if dtm < cdate("01/08/2016") then
	dtm = cdate("01/08/2016")
elseif weekday(dtm) = 1 then
	dtm = dtm - 6
else	
	dtm = dtm - weekday(dtm) + 2
end if

%>
<form name="jump">
	<p>Week <select name="menu" onChange="location=document.jump.menu.options[document.jump.menu.selectedIndex].value;" value="GO">
		<%dat = cdate("01/08/2016")
		mnd = 8
		while dat < cdate("31/05/2017")%>
		<option value="sporthalbezetting.asp?dtm=<%=dat%>"<%
		if dat = dtm then
			%> selected="selected"<%
		end if
		%>><%=weekdayname(weekday(dat),true)%>&nbsp;<%=day(dat)%>&nbsp;<%=monthname(month(dat),true)%>&nbsp;<%=year(dat)%></option>
		<%dat = dat + 7
	wend
%>

	</select></p>
</form>
<%


sqlstring = "SELECT datum, sh1, sh2, sh3, ohvm, zolder FROM tblsporthaluren " &_ 
			"WHERE datum > '" & year(dtm) & "-" & month(dtm) & "-" & day(dtm) & "' " &_
			"ORDER BY datum"
rs.Open sqlString
%>
<table border="0" cellpadding="0" cellspacing="0"><tr><td valign="top">

<table width="500">
<tr>
<td width="50%"><%if dtm > #01/08/2016# then%>
	<a href="sporthalbezetting.asp?dtm=<%=dtm-7%>" class="NieuwsLinks"><img src="../img/driehoek_rood2.gif" border="0" /> vorige</a>
	<%end if%>
</td>
<td width="50%" align="right"><%if dtm < #31/05/2017# then%>
	<a href="sporthalbezetting.asp?dtm=<%=dtm+7%>" class="NieuwsLinks">volgende <img src="../img/driehoek_rood.gif" border="0" /></a>
	<%end if%></td>
</tr>
<tr>
<td colspan="2" bgcolor="#CCCCCC">
Legende:<br />
<table width="100%">
<tr align="center"><td>Baskettraining</td><td bgcolor="#FFFFCC">Vrij voor basket</td>
<td bgcolor="#DDDDDD">Niet beschikbaar</td></tr>
<tr align="center"><td bgcolor="#0099FF">Match</td><td bgcolor="#FF9900">Clinic</td>
</tr>
</table>
</td>
</tr>

<%
dim hal(5)
hal(0) = "sh1"
hal(1) = "sh2"
hal(2) = "sh3"
hal(3) = "ohvm"
hal(4) = "zolder"

i=0
while not einde
	if rs.eof then
		einde = true
	elseif day(rs("datum")) <> dag then
		i = i + 1
		if i = 8 then einde = true
		dag = day(rs("datum"))
		if not einde then%>
			</table>
			<p></p>
			<table width="500">
			<tr>
			<td colspan="7" class="ccornerTitels"><%=weekdayname(weekday(rs("datum")))%>&nbsp;<%=day(rs("datum"))%>&nbsp;<%=monthname(month(rs("datum")))%>&nbsp;<%=year(rs("datum"))%></td>
			</tr>
			<tr>
				<th width="50">
				  <%if session("BL_soort") < 3 or  Session("BL_lidid")=205 then%>
					<a href="sporthalwijzigen.asp?dtm=<%=FormatDateTime(rs("datum"),2)%>"><img src="../img/edit.gif" border="0" alt="wijzigen" /></a>
				  <%else%>
				  	&nbsp;
				<%end if%></th>
				<%for j = 0 to 4%>
				<th width="75"><%=hal(j)%></th>
				<%next%>
		</tr>
		<%end if
	end if
	if not einde then%>
	<tr>
	<th><%=FormatDateTime(rs("datum"),4)%></th> 
	<%for j = 0 to 4%>
	<td align="center"
		<%if rs(hal(j)) = "NB" then%>
			 bgcolor="#DDDDDD">&nbsp;
		<%elseif rs(hal(j)) = "C" then%>
			 bgcolor="#FF9900" style="cursor:pointer;cursor:hand;" 
			 onclick="reservatie('<%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%>','<%=FormatDateTime(rs("datum"),4)%>','<%=hal(j)%>','C')">&nbsp;
		<%elseif rs(hal(j)) = "M" or rs(hal(j)) = "MATCH" then%>
			 bgcolor="#0099FF" style="cursor:pointer;cursor:hand;" 
			 onclick="reservatie('<%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%>','<%=FormatDateTime(rs("datum"),4)%>','<%=hal(j)%>','M')">&nbsp;
		<%elseif rs(hal(j)) = "" or isnull(rs(hal(j))) then%>
			 bgcolor="#ffffcc" style="cursor:pointer;cursor:hand;" 
			 onclick="reservatie('<%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%>','<%=FormatDateTime(rs("datum"),4)%>','<%=hal(j)%>','')">&nbsp;
		<%else%>
			 style="cursor:pointer;cursor:hand;" 
			 onclick="reservatie('<%=day(rs("datum"))%>/<%=month(rs("datum"))%>/<%=year(rs("datum"))%>','<%=FormatDateTime(rs("datum"),4)%>','<%=hal(j)%>','<%=rs(hal(j))%>')"><%=rs(hal(j))%>
		<%end if%>
		</td>
	<%next%>	</tr>
	<%rs.MoveNext
	end if
wend

rs.Close
%>
</table>
</td>
<td width="75">&nbsp;</td>
<td valign="top">

<form method="post" action="sporthalbezetting.asp" id="form1">
<table>
<tr>
<td colspan="4"><b>Reservatie of annulatie van sporthaluren:</b></td>

</tr>
<tr>
	<td>Plein</td>
	<td colspan="3">
	<select name="plein" id="plein">
		<option value=""></option>
		<option value="sh1">Sporthal P1</option>
		<option value="sh2">Sporthal P2</option>
		<option value="sh3">Sporthal P3</option>
		<option value="ohvm">OHVM</option>
		<option value="zolder">Zolder</option>
	</select>
	</td>
</tr>
<tr>
	<td>Datum</td>
	<td colspan="3"><input type="text" name="datum" id="datum" size="10" maxlength="10" /></td>
</tr>
<tr>
	<td>van</td>
	<td><input type="text" name="van" id="van" size="5" maxlength="5" /></td>
	<td>tot</td>
	<td><input type="text" name="tot" id="tot" size="5" maxlength="5" /></td>
</tr>
<tr>
	<td>Soort</td>
	<td colspan="3"><select name="soort" id="soort">
		<option value=""></option>
		<option value="training">Training</option>
		<option value="match">Match</option>
		<option value="clinic">Clinic</option>
		<option value="annulatie">Annulatie</option>
	</select>
	</td>
</tr>
<tr>
	<td colspan="4">Opmerkingen<br />
	<textarea name="opmerkingen" id="opmerkingen" rows="5"></textarea></td>	
</tr>
<tr>
	<td colspan="4" align="center"><input type="submit" value="verzenden" /></td>
</tr>
</table>
</form>
Dit formulier wordt per e-mail verzonden. Als uw reservatie/annulatie in orde is krijgt u een e-mail terug en wordt het schema aangepast.
<%


plein = trim(request("plein"))
if not isnull(plein) and plein <> "" then
	datum = trim(request("datum"))
	van = trim(request("van"))
	tot = trim(request("tot"))
	soort = trim(request("soort"))
	opmerkingen = trim(request("opmerkingen"))
	
	tekst = "Plein: " & plein & "<br>" & "Datum: " & datum & "<br> van " & van & " tot " & tot & "<br> soort: " & soort & "<br> opmerkingen: " & opmerkingen
	
	
	
	sqlString = "SELECT naam, voornaam, email FROM tblLeden WHERE id = " & Session("BL_lidid")
	rs.open sqlString

	naam = rs("naam")
	voornaam = rs("voornaam")
	email = rs("email")
	
	rs.close
	%>
	<iframe src="sendmailsporthal.php?plein=<%=plein%>&datum=<%=datum%>&van=<%=van%>&tot=<%=tot%>&soort=<%=soort%>&opmerkingen=<%=opmerkingen%>&naam=<%=naam%>&voornaam=<%=voornaam%>&email=<%=email%>" style="display:none;"></iframe>	
	<b>Volgende aanvraag verzonden:</b>
	<br />
	<%=tekst%>
<%end if%>



<%con.close%>
</td></tr></table>

</div>

</BODY>
</HTML>
