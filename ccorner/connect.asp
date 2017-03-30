<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
connectionString = shell.ExpandEnvironmentStrings("MYSQLCONNSTR_localdb")

Response.Write(connectionString)

set con = server.createobject("ADODB.Connection")
con.Open connectionString

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
