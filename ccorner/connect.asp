<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
connectionString = shell.Environment("PROCESS").Item("MYSQLCONNSTR_localdb")
connectionString = "Driver={MySQL ODBC 3.51 Driver};" & Replace(connectionString, "localdb", "basketlummen")
Response.Write(connectionString)

set con = server.createobject("ADODB.Connection")
con.Open connectionString

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
