<%
Session.LCID = 2067

set shell = createobject("WScript.Shell")
connectionString = shell.ExpandEnvironmentStrings("MYSQLCONNSTR_localdb")

set con = server.createobject("ADODB.Connection")
con.Open connectionString
set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
