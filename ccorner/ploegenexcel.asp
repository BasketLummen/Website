<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
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

%>
<!--#include file="connect.asp"-->
<%
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=basketlummen.xls" 


ord=trim(request("ord"))
if ord="" or isnull(ord) then ord = 0
ploegid=trim(request("ploegid"))
if ploegid="" or isnull(ploegid) then ploegid = 0

dim order(11)
order(0) = ""
order(1) = "id, "
order(2) = "vblnr, "
order(3) = "geboortedatum, "
order(4) = "geslacht, "
order(5) = "aansluitingsdatum, "
order(6) = "status, "
order(7) = "ploegvorig, "
order(8) = "ploeg1, "
order(9) = "tblleden.niveau, "
order(10) = "functie1, "


toon = true
if session("BL_soort") = 4 then 
	sqlString = "SELECT ploegid FROM tblploegedit WHERE ploegid = " & ploegid & " AND lidid = " & session("BL_lidid")
	rs.open sqlString
	if rs.eof then
		toon = false
	end if
	rs.close
end if
if toon = true then
	
	sqlString = "SELECT id, vblnr, naam, voornaam, adres, tblleden.postnr, gemeente, " &_
				"geboortedatum, geslacht, aansluitingsdatum, status, telnr, gsm, email, " &_
				"oudersgsm, oudersemail, magsm, maemail, tblniveaus.niveau, tblfct1.functie AS fct1, " &_
				"tblfct2.functie AS fct2, tblpl0.ploegnaam AS pl0, tblpl1.ploegnaam AS pl1, " &_
				"tblpl2.ploegnaam AS pl2 " &_ 
				"FROM (tblleden, tblgemeenten, tblniveaus) " &_ 
				"LEFT JOIN tblfuncties AS tblfct1 ON functie1 = tblfct1.functieid " &_
				"LEFT JOIN tblfuncties AS tblfct2 ON functie2 = tblfct2.functieid " &_
				"LEFT JOIN tblploegen AS tblpl0 ON ploegvorig = tblpl0.ploegid " &_
				"LEFT JOIN tblploegen AS tblpl1 ON ploeg1 = tblpl1.ploegid " &_
				"LEFT JOIN tblploegen AS tblpl2 ON ploeg2 = tblpl2.ploegid " &_
				"WHERE tblleden.postnr = tblgemeenten.postnr AND tblleden.niveau = "&_
				"tblniveaus.niveauid AND (ploeg1 = " & ploegid & " OR ploeg2 = " & ploegid & ") AND status = 'A' " &_
				"ORDER BY " & order(ord) & "naam, voornaam"
	rs.open sqlString
	if rs.eof <> true then
		response.write("<table border=1>")
		response.write("<tr><td>id</td><td>vblnr</td><td>naam</td><td>voornaam</td>")
		response.Write("<td>adres</td><td>postnr</td><td>gemeente</td>")
		response.Write("<td>geboortedatum</td><td>geslacht</td>")	
		response.Write("<td>aansldatum</td><td>status</td><td>telnr</td><td>gsm</td><td>e-mail</td>")
		response.Write("<td>vader gsm</td><td>vader e-mail</td><td>moeder gsm</td><td>moeder e-mail</td><td>vorige ploeg</td>")
		response.Write("<td>ploeg 1</td><td>ploeg 2</td><td>niveau</td><td>functie 1</td><td>functie 2</td>")
		while not rs.eof
			response.write "<tr><td>" & rs.fields("id") & "</td><td>" & rs.fields("vblnr") & "</td><td>" & rs.fields("naam") & "</td><td>" & rs.fields("voornaam") & "</td>"
			response.Write("<td>" & rs.fields("adres") & "</td><td>" & rs.fields("postnr") & "</td><td>" & rs.fields("gemeente") & "</td>")
			response.Write("<td>" & rs.fields("geboortedatum") & "</td><td>" & rs.fields("geslacht") & "</td>")	
			response.Write("<td>" & rs.fields("aansluitingsdatum") & "</td><td>" & rs.fields("status") & "</td><td>" & rs.fields("telnr") &"</td>")
			response.Write("<td>" & rs.fields("gsm") & "</td><td>" & rs.fields("email") & "</td><td>" & rs.fields("oudersgsm") & "</td>")
			response.Write("<td>" & rs.fields("oudersemail") & "</td><td>" & rs.fields("magsm") & "</td><td>" & rs.fields("maemail") & "</td><td>" & rs.fields("pl0") & "</td>")
			response.Write("<td>" & rs.fields("pl1") & "</td><td>" & rs.fields("pl2") & "</td><td>" & rs.fields("niveau") & "</td>")
			response.Write("<td>" & rs.fields("fct1") & "</td><td>" & rs.fields("fct2") & "</td>")	
			rs.movenext
		wend
	response.write "</table>"
end if
rs.close
end if%>

