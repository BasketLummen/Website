<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp"-->
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Basket Lummen - Kalender</title>
<link href="../opmaak.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jquery-1.4.2.js"></script> 
<script type="text/javascript" src="jquery.AddIncSearch.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
	$("select").AddIncSearch();
});
</script>
						  
<style type="text/css">
<!--
td {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	
}
th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
select {
	background-color: #FFFFFF;
}
-->
</style>
</head>
<body>
<!--#include file="cmenu.asp"-->
<!--#include file="menuberichten.asp"-->

<div id="Layer3" style="position:absolute; z-index:1; left: 125px; top: 40px; width: 800px;">


<p class="titel"><font size="3">Verslagen toevoegen/wijzigen</font></p>

<%
seizoen = "1415"
set rs1 = server.createobject("adodb.recordset")
rs1.activeconnection = con

matchid = trim(request("matchid"))%>

  <table cellspacing="0" cellpadding="5" class="nieuws" width="100%" bgcolor="#FFFFFF">
  <form method="post" action="verslagwijzigen.asp" name="verslag">
  	<tr>
     	<td>Matchnummer <input type="text" name="matchid" value="<%=matchid%>"> <input name="zoek" type="submit" value="Zoek match"></td>
	</tr>
	</form>
   <form method="post" action="verslagwijzigen.asp" name="verslag1">
	<%
	wedstrijdid = trim(request("wedstrijdid")) 'we vragen het verborgen veld wedstrijdid op, want indien de gebruiker een ander nummer getypt heeft in het veld matchnummer slaat hij de verkeerde wedstrijd op.
	
 	if wedstrijdid <> "" and not isnull(wedstrijdid) then

		'wedstrijdgegevens opslaan
		thuisresult = trim(request("thuisresult"))
		uitresult = trim(request("uitresult"))
		if thuisresult = "" or isnull(thuisresult) then thuisresult = "null"
		if uitresult = "" or isnull(uitresult) then uitresult = "null"		
		sqlstring = "UPDATE tblwedstrijden"&seizoen&" SET thuisresult = " & thuisresult & ", uitresult = " & uitresult &_
					" WHERE wedstrijd_id = " & wedstrijdid
		con.execute sqlstring

		'verslag opslaan
		bestaand = trim(request("bestaand"))
		ploeg = trim(request("ploeg"))
		verslag = trim(request("verslag"))
		verslag = Replace(verslag, chr(13) & chr(10), "<br>")
		verslag = Replace(verslag, "'", "´")
		if bestaand = "ja" then
			sqlstring = "UPDATE tblVerslagen"&seizoen&" SET verslag = '" & verslag & "' WHERE wedstrijdid = " & wedstrijdid
			con.execute sqlstring
		else
			sqlstring = "INSERT INTO tblVerslagen"&seizoen&" VALUES(" & wedstrijdid & ",'" & verslag & "',"&ploeg&")"
			con.execute sqlstring
		end if
		
		'punten Lummen opslaan
		if bestaand = "ja" then
			sqlstring = "DELETE FROM tblverslagpunten"&seizoen&" WHERE wedstrijdid = " & wedstrijdid
			con.execute sqlstring
			sqlstring = "DELETE FROM tblVerslagtegenstander"&seizoen&" WHERE wedstrijdid = " & wedstrijdid
			con.execute sqlstring
		end if		
		for i = 1 to 12
			speler = trim(request("speler("&i&")"))
			punten = trim(request("puntenLummen("&i&")"))
			if not isnull(speler) and speler <> "" and not isnull(punten) and punten <> "" then
				sqlString = "INSERT INTO tblVerslagPunten"&seizoen&" " &_
							"VALUES" &_ 
								"(" & wedstrijdid & "," & speler & "," & punten & ")"
				con.execute sqlString
			end if
			speler = trim(request("tegenstnaam("&i&")"))
			speler = Replace(speler, "'", "´")
			punten = trim(request("tegenstpunten("&i&")"))
			if not isnull(speler) and speler <> "" and not isnull(punten) and punten <> "" then
				sqlString = "INSERT INTO tblVerslagtegenstander"&seizoen&" " &_
							"VALUES" &_ 
								"(" & wedstrijdid & ",'" & speler & "'," & punten & ")"
				con.execute sqlString
			end if
		next

		%>
		<p class="nieuws">Matchverslag is opgeslaan.</p>	
	<%elseif matchid <> "" and not isnull(matchid) then
		'de matchgegevens ophalen
		sqlString = "SELECT wedstrijd_id, datum, thuisresult, uitresult, thuisploeg, uitploeg, " &_
					"tblPloegenkal.ploegnaam AS thuispl, tblPloegenkal1.ploegnaam AS uitpl " &_
					"FROM tblWedstrijden"&seizoen&", tblPloegenkal"&seizoen&" AS tblPloegenkal, tblPloegenkal"&seizoen&" AS tblPloegenkal1 " &_
					"WHERE wedstrijd_id = " & matchid & " AND thuisploeg = tblPloegenkal.ploeg_id AND uitploeg = tblPloegenkal1.ploeg_id"

		rs.open sqlString
		if rs.eof then
			%><tr><td class="nieuws">Wedstrijd niet gevonden, probeer opnieuw</td></tr><%
		else%>
        	<input type="hidden" name="ploeg" value="
			<%if left(rs("thuisploeg"),4) = 1438 then
				response.Write(rs("thuisploeg"))
			else
				response.Write(rs("uitploeg"))
			end if
			%>" />
			<input type="hidden" name="wedstrijdid" value="<%=rs("wedstrijd_id")%>">
			<tr><td class="nieuwstitels"><%=rs("thuispl")%> - <%=rs("uitpl")%></td></tr>
			<tr class="nieuws"><td>uitslag <input type="text" name="thuisresult" value="<%=rs("thuisresult")%>" size="5">
			 - <input type="text" name="uitresult" value="<%=rs("uitresult")%>" size="5"></td></tr>		
			 <%rs.close
			sqlString = "SELECT verslag FROM tblverslagen"&seizoen&" " &_
						"WHERE wedstrijdid = " & matchid
			rs.open sqlString%>
			<tr><td>
			Verslag<br>
			<%if rs.eof then%>
			 	<textarea name="verslag" rows="25" cols="80"></textarea>
				<input type="hidden" name="bestaand" value="nee">
			<%else
				verslag = Replace(rs("verslag"), "<br>", chr(13) & chr(10))%>
			 	<textarea name="verslag" rows="25" cols="80" class="nieuws"><%=verslag%></textarea>
				<input type="hidden" name="bestaand" value="ja">
			<%end if
			rs.close%>
			<tr><td>
			
			<table width="400"><tr><td valign="top" width="175" style="border: 1px solid #006;">
				<table cellspacing=0 cellpadding="3"><tr class="nieuwstitel"><td colspan="2"><strong><font size="2">Lummen</font></strong></td></tr>
				<tr class="nieuws"><td>Speler</td><td>Punten</td></tr>
				<%
				'de punten van Lummen ophalen
				sqlString = "SELECT spelerid, naam, voornaam, punten FROM tblVerslagPunten"&seizoen&", tblLeden " &_
							"WHERE wedstrijdid = " & matchid & " AND spelerid = id ORDER BY punten DESC, naam, voornaam"
				rs.open sqlString
				
				'de spelers van Lummen ophalen
				sqlstring = "SELECT id, voornaam, naam FROM tblleden WHERE status = 'A' ORDER BY naam, voornaam"
				rs1.open sqlstring
				
				for i = 1 to 12%>
				<tr>	
				  <td>
					<%rs1.movefirst%>
					<select name="speler(<%=i%>)" class="nieuws">
					<option selected 
						<%if not rs.eof then%>
							value="<%=rs("spelerid")%>"><%=rs("voornaam")%>&nbsp;<%=rs("naam")%></option>
							<option></option>
						<%else%>
							></option>
						<%end if%>
					<%while not rs1.eof%>
						<option value="<%=rs1("id")%>"><%=rs1("voornaam")%>&nbsp;<%=rs1("naam")%></option>
						<%rs1.movenext
					wend%>
					</select>
				</td><td>
				  <input name="puntenLummen(<%=i%>)" type="text" size="10"  
					<%if not rs.eof then%>
						value="<%=rs("punten")%>"
						<%rs.movenext
					end if%>	
					></td>
				</tr>
				<%next
				rs.close
				rs1.close%>
			</table>
		</td><td width="20">&nbsp;</td><td valign="top" align="center" width="175">
		
		
		
			<table cellspacing=0 cellpadding="3" style="border: 1px solid #FFF;">
				<tr style="font-family:Verdana, Arial, Helvetica, sans-serif;font-size: 14px; font-weight:bold;">
				<td colspan="2"><font size="2">Tegenstander</font> (eventueel)</td></tr>
				<tr class="nieuws"><td>Speler</td><td>Punten</td></tr>
				<%'de punten van de tegenstander ophalen
				sqlString = "SELECT naam, punten FROM tblVerslagtegenstander"&seizoen&" " &_
							"WHERE wedstrijdid = " & matchid & " ORDER BY punten DESC, naam"
				rs.open sqlString
				i = 1
				while not rs.eof
					%>
					<tr><td><input type="text" name="tegenstnaam(<%=i%>)" value="<%=rs("naam")%>"></td>
					<td><input type="text" name="tegenstpunten(<%=i%>)" value="<%=rs("punten")%>" size="10"></td></tr>
					<%i = i + 1
					rs.movenext
				wend
				rs.close
				while i < 13%>
					<tr><td><input type="text" name="tegenstnaam(<%=i%>)"></td>
					<td><input type="text" name="tegenstpunten(<%=i%>)" size="10"></td></tr>
					<%i = i + 1
				wend%>
			</table>
		
		</td></tr>
				<tr><td><input name="zoek" type="submit" value="Match opslaan"></td></tr>

		</table>
			</form>
			
			
		<%
		end if
	end if
 	con.close%>
 
 		</td></tr>
  </table>
</form>
</div>
</body>
</html>
