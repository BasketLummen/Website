<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="connect.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers="1,2"
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


function contr_nul(waarde)
	if waarde > 0 then
		contr_nul = round(waarde,1)
	else
		contr_nul = "&nbsp;"
	end if
end function
function contr_nul0(waarde)
	if waarde > 0 then
		contr_nul0 = round(waarde,1)
	else
		contr_nul0 = 0
	end if
end function

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=basketlummen_scouting.xls" 


'SCOUTING PER WEDSTRIJD
ploegid =  1
sorteer = trim(request("ord"))
if sorteer = "" or isnull(sorteer) then sorteer = 0

dim ord(12)
ord(0) = "scoutingnr"
ord(1) = "punten DESC"
ord(2) = "ressteals DESC"
ord(3) = "resassists DESC"
ord(4) = "resoffreb DESC"
ord(5) = "resdefreb DESC"
ord(6) = "resblocks DESC"
ord(7) = "resturnovers DESC"
ord(8) = "resfouten DESC"
ord(9) = "resprovoked DESC"
ord(10) = "restijd DESC"
ord(11) = "resrating DESC"

dim lijst(4)
lijst(0) = "Totaal"
lijst(1) = "Gemiddelde"
lijst(2) = "Thuis"
lijst(3) = "Uit"



	dim sqlstr(4)
	'totaal alle wedstrijden
	sqlstr(0) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, Sum(eenpscore) AS reseenpscore, " &_
				"Sum(eenppoging) AS reseenppoging, Sum(tweepscore) AS restweepscore, Sum(tweeppoging) AS restweeppoging, "&_
				"Sum(driepscore) AS resdriepscore, Sum(drieppoging) AS resdrieppoging, Sum(steals) AS ressteals, "&_
				"sum(assists) AS resassists, Sum(offreb) AS resoffreb, Sum(defreb) AS resdefreb, Sum(blocks) AS resblocks, "&_
				"Sum(turnovers) AS resturnovers, Sum(fouten) AS resfouten, Sum(provoked) AS resprovoked, "&_
				"Sum(tijd) AS restijd, Sum(rating) AS resrating, (Sum(eenpscore) + Sum(tweepscore)*2 + Sum(driepscore)*3) AS punten  "&_
				"FROM tblscouting, tblleden where (speler = id) " &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'gemiddelde per wedstrijd
	sqlstr(1) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, "&_
				"avg(tijd) AS restijd, avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten  "&_
				"FROM tblscouting, tblleden where (speler = id) " &_
				"GROUP BY id, voornaam, naam, speler, scoutingnr " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'thuiswedstrijden
	sqlstr(2) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, thuisploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd " &_
				"AND thuisploeg = 'Basket Lummen' GROUP BY id, voornaam, naam, speler, scoutingnr, thuisploeg " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	'uitwedstrijden
	sqlstr(3) = "SELECT id, voornaam, naam, scoutingnr, Count(wedstrijd) AS aantal, speler, avg(eenpscore) AS reseenpscore, " &_
				"avg(eenppoging) AS reseenppoging, avg(tweepscore) AS restweepscore, avg(tweeppoging) AS restweeppoging, "&_
				"avg(driepscore) AS resdriepscore, avg(drieppoging) AS resdrieppoging, avg(steals) AS ressteals, "&_
				"avg(assists) AS resassists, avg(offreb) AS resoffreb, avg(defreb) AS resdefreb, avg(blocks) AS resblocks, "&_
				"avg(turnovers) AS resturnovers, avg(fouten) AS resfouten, avg(provoked) AS resprovoked, avg(tijd) AS restijd, "&_
				"avg(rating) AS resrating, (avg(eenpscore) + avg(tweepscore)*2 + avg(driepscore)*3) AS punten, uitploeg  "&_
				"FROM tblscouting, tblleden, tblscoutingwedstr where (speler = id) AND wedstrijdid = wedstrijd " &_
				"AND uitploeg = 'Basket Lummen' GROUP BY id, voornaam, naam, speler, scoutingnr, uitploeg " &_
				"ORDER BY " & ord(sorteer) & ", scoutingnr"
	
	for i = 0 to 3 
		'response.write("<p><font size=3>"&lijst(i)&"</font></p>")
		rs.open sqlstr(i)
		response.write("<table><tr><th width=130 align=center>Naam</th><th width=30 align=center>#</th><th width=30 align=center>TOT</a></th><th width=60 align=center colspan=2>1p</th><th width=30 align=center>%</th><th width=60 align=center colspan=2>2p</th><th width=30 align=center>%</th><th width=60 align=center colspan=2>3p</th><th width=30 align=center>%</th><th width=30 align=center>ST</th><th width=30 align=center>AS</th><th width=30 align=center>OR</th><th width=30 align=center>DR</th><th width=30 align=center>BL</th><th width=30 align=center>TO</th><th width=30 align=center>FO</th><th width=30 align=center>PR</th><th width=30 align=center>TI</th><th width=30 align=center>RA<</th></tr>")
		
		while not rs.eof
			response.write("<tr><td><b>"&rs("voornaam")&"&nbsp;"&rs("naam")&"</b></td><td width=30 align=center>"&rs("aantal")&"</td>")
			response.write("<td width=30 align=center>")
			if rs("restijd") > 0 then
				response.write(contr_nul0(rs("punten")))
			else
				response.write(contr_nul(rs("punten")))
			end if
			som = 0	
			response.write("</td><td width=30 align=center>")
			if rs("reseenppoging") > 0 then
				response.write(contr_nul0(rs("reseenpscore")))
			else
				response.write(contr_nul(rs("reseenpscore")))
			end if
			response.write("</td><td width=30 align=center>"&contr_nul(rs("reseenppoging"))&"</td>")
			response.write("<td width=30 align=center>")
			if rs("reseenppoging") > 0 then
				response.write(round((rs("reseenpscore")/rs("reseenppoging"))*100,0))
			else
				response.write("nbsp;")
			end if
			response.write("</td><td width=30 align=center>")
			if rs("restweeppoging") > 0 then
				response.write(contr_nul0(rs("restweepscore")))
			else
				response.write(contr_nul(rs("restweepscore")))
			end if
			response.write("</td><td width=30 align=center>"&contr_nul(rs("restweeppoging"))&"</td>")
			response.write("<td width=30 align=center>")
			if rs("restweeppoging") > 0 then
				response.write(round((rs("restweepscore")/rs("restweeppoging"))*100,0))
			else
				response.write("&nbsp;")
			end if
			response.write("</td><td width=30 align=center>")
			if rs("resdrieppoging") > 0 then
				response.write(contr_nul0(rs("resdriepscore")))
			else
				response.write(contr_nul(rs("resdriepscore")))
			end if
			response.write("</td><td width=30 align=center>"&contr_nul(rs("resdrieppoging"))&"</td>")
			response.write("<td width=30 align=center>")
			if rs("resdrieppoging") > 0 then
				response.write(round((rs("resdriepscore")/rs("resdrieppoging"))*100,0))
			else
				response.write("&nbsp;")
			end if
			response.write("</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("ressteals"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resassists"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resoffreb"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resdefreb"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resblocks"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resturnovers"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resfouten"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("resprovoked"))&"</td>")
			response.write("<td width=30 align=center>"&contr_nul(rs("restijd"))&"</td>")
			response.write("<td width=30 align=center>")
			if rs("restijd") > 0 and rs("resrating") <> "" then
				response.write(round(rs("resrating"),1))
			else
				response.write("&nbsp;")
			end if
			response.write("</td></tr>")
		rs.movenext
	wend
	rs.close
	response.write("</table>")
	next

con.close%>
