<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1"
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
	<html>
	<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../inc/opmaak.css" rel="stylesheet" type="text/css" />
	<style>
	td, select {
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
	border-bottom: #AAAAAA solid 1px;
	border-right: #AAAAAA solid 1px;
	}
	th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #CCCCCC;
	border-bottom: #000000 solid 1px;
	border-right: #000000 solid 1px;
	border-top: #000000 solid 1px;
	}
	input {
		text-align: center;
	}
	</style>
	<%
	function contr_nul0(waarde)
		'waarde = cint(0&waarde)
		if waarde <> "" and not isnull(waarde) then
			contr_nul0 = waarde
		else
			contr_nul0 = 0
		end if
	end function
	%>

	</head>
	<body>
<table cellspacing="10" height="100%"><tr><td valign="top" style="border-right: 1px solid #339900;">
</td><td valign="top">
<h1>Scouting opslaan</h1>
	<%
	'SCOUTING PER WEDSTRIJD
	ploegid = trim(request("ploeg"))
	if ploegid = "" or isnull(ploegid) then ploegid =  1
	matchid = trim(request("matchid"))
	sqlstring = "SELECT wedstrijdid, datum, thuisploeg, uitploeg " &_
				"FROM tblscoutingwedstr WHERE datum <= '"&year(date())&"-"&month(date())&"-"&day(date())&"' " &_
				"ORDER BY datum DESC"
	rs.open sqlstring
	
	%>
	<form name="jump2">
	<select name="menu" onChange="location=document.jump2.menu.options[document.jump2.menu.selectedIndex].value;" value="GO">
		<option>Kies wedstrijd</option>
		<%while not rs.eof%>
			<option value="scoutingingeven.asp?matchid=<%=rs("wedstrijdid")%>">
			<%=rs("thuisploeg")%> - <%=rs("uitploeg")%> (<%=day(rs("datum"))%>/<%=month(rs("datum"))%>)</option>
			<%rs.movenext
		wend
		rs.close%>
	</select>
	</form>
	<%
	thuisresult = trim(request("thuisresult"))
	uitresult = trim(request("uitresult"))
	sqlstring = "UPDATE tblscoutingwedstr SET thuisresult = "	
	if thuisresult = "" or isnull(thuisresult) then
		sqlstring = sqlstring & "null"
	else
		sqlstring = sqlstring & thuisresult
	end if
	sqlstring = sqlstring & ", uitresult = "
	if uitresult = "" or isnull(uitresult) then
		sqlstring = sqlstring & "null"
	else
		sqlstring = sqlstring & uitresult
	end if
	sqlstring = sqlstring & " WHERE wedstrijdid = " & matchid
	con.execute sqlstring
	
	sqlstring = "SELECT id FROM tblleden WHERE scoutingnr Is Not Null " &_
				"ORDER BY scoutingnr, naam, voornaam"
	rs.open sqlstring
	while not rs.eof
		sqlstring = "DELETE FROM tblscouting WHERE wedstrijd = " & matchid & " AND speler = " & rs("id")
		con.execute sqlstring
		tijd = contr_nul0(trim(request("txttijd_"&rs("id"))))
		if tijd > 0 then
			eenpscore = contr_nul0(trim(request("txteenpscore_"&rs("id"))))
			eenppoging = contr_nul0(trim(request("txteenppoging_"&rs("id"))))
			tweepscore = contr_nul0(trim(request("txttweepscore_"&rs("id"))))
			tweeppoging = contr_nul0(trim(request("txttweeppoging_"&rs("id"))))
			driepscore = contr_nul0(trim(request("txtdriepscore_"&rs("id"))))
			drieppoging = contr_nul0(trim(request("txtdrieppoging_"&rs("id"))))
			steals = contr_nul0(trim(request("txtsteals_"&rs("id"))))
			assists = contr_nul0(trim(request("txtassists_"&rs("id"))))
			offreb = contr_nul0(trim(request("txtoffreb_"&rs("id"))))
			defreb = contr_nul0(trim(request("txtdefreb_"&rs("id"))))
			blocks = contr_nul0(trim(request("txtblocks_"&rs("id"))))
			turnovers = contr_nul0(trim(request("txtturnovers_"&rs("id"))))
			fouten = contr_nul0(trim(request("txtfouten_"&rs("id"))))
			provoked = contr_nul0(trim(request("txtprovoked_"&rs("id"))))
			rating = contr_nul0(trim(request("txtrating_"&rs("id"))))
			
			sqlstring = "INSERT INTO tblscouting VALUES("&matchid&","&rs("id")&","&eenpscore&","&eenppoging&","&tweepscore&","&_
						tweeppoging&","&driepscore&","&drieppoging&","&steals&","&assists&","&offreb&","&defreb&","&blocks&","&_
						turnovers&","&fouten&","&provoked&","&tijd&","&rating&")"
			con.execute sqlstring
		end if
		rs.movenext
	wend
	rs.close%>
	<%for i = 0 to 2
		speler = trim(request("speler_x"&i))
		if speler <> "" and not isnull(speler) then
			tijd = contr_nul0(trim(request("txttijd_x"&i)))
			if tijd > 0 then
				eenpscore = contr_nul0(trim(request("txteenpscore_x"&i)))
				eenppoging = contr_nul0(trim(request("txteenppoging_x"&i)))
				tweepscore = contr_nul0(trim(request("txttweepscore_x"&i)))
				tweeppoging = contr_nul0(trim(request("txttweeppoging_x"&i)))
				driepscore = contr_nul0(trim(request("txtdriepscore_x"&i)))
				drieppoging = contr_nul0(trim(request("txtdrieppoging_x"&i)))
				steals = contr_nul0(trim(request("txtsteals_x"&i)))
				assists = contr_nul0(trim(request("txtassists_x"&i)))
				offreb = contr_nul0(trim(request("txtoffreb_x"&i)))
				defreb = contr_nul0(trim(request("txtdefreb_x"&i)))
				blocks = contr_nul0(trim(request("txtblocks_x"&i)))
				turnovers = contr_nul0(trim(request("txtturnovers_x"&i)))
				fouten = contr_nul0(trim(request("txtfouten_x"&i)))
				provoked = contr_nul0(trim(request("txtprovoked_x"&i)))
				rating = contr_nul0(trim(request("txtrating_x"&i)))
				
				sqlstring = "INSERT INTO tblscouting VALUES("&matchid&","&speler&","&eenpscore&","&eenppoging&","&tweepscore&","&_
							tweeppoging&","&driepscore&","&drieppoging&","&steals&","&assists&","&offreb&","&defreb&","&blocks&","&_
							turnovers&","&fouten&","&provoked&","&tijd&","&rating&")"
							con.execute sqlstring
				sqlstring = "SELECT max(scoutingnr) as nr FROM tblleden WHERE scoutingnr < "&((ploegid+1)*100)
				rs.open sqlstring
				sqlstring = "UPDATE tblleden SET scoutingnr = "&rs("nr")+1&" WHERE id = " & speler
				con.execute sqlstring
				rs.close
			end if
		end if
	next
	response.Redirect("scoutingmatch.asp?matchid="&matchid&"&ploeg="&ploegid)%>
</td></tr></table>
</body>
</html>
<%
con.close%>
