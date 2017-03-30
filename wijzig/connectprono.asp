<%
Session.LCID = 2067
set con= server.CreateObject("ADODB.Connection")
'strCon = "Provider=Microsoft.Jet.OLEDB.4.0; " & _
'		  "Data Source=" & Server.Mappath("/basketlummen2/pronostiek.mdb") & ";" & "Jet OLEDB:Database"
'con.open strCon
con.open="pronostiek"        

set rs = server.CreateObject("ADODB.Recordset")
rs.ActiveConnection= Con
%>
