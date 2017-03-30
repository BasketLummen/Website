<!--#include file="connect.asp" -->
<%
if session("fotoreeks") <> "" and session("fotonr") <> 0 then

	naam = request("naam")
	if naam = "" then 
		naam = "anoniem"
	end if
	naam = Replace(naam, "'", "´")
	reactie = request("reactie")
	reactie = Replace(reactie, chr(10), "<br>")
	reactie = Replace(reactie, "'", "´")
	if instr(naam, "http") = 0 and instr(reactie, "http") = 0 then
		if reactie <> "" then
			sqlString = "SELECT max(tekstid) AS nr FROM tblFototekst WHERE reeks = " & session("fotoreeks") & " AND nr = " & session("fotonr")
			rs.open sqlString
			if isnull(rs("nr")) then
				tekstnr = 1
			else
				tekstnr = rs("nr") + 1
			end if
			sqlString = "INSERT INTO tblFototekst VALUES (" & session("fotoreeks") & ", " & session("fotonr") & "," &_
						" " & tekstnr & ", '" & naam & "', '" & reactie &"', #" & month(date()) & "/" & day(date()) & "/" & year(date()) & "#, #" & time() & "#)"
			con.execute sqlString
		end if
	end if
	response.Redirect("fotodetail.asp?reeks="&session("fotoreeks")&"&nr="&session("fotonr"))
end if
%>