<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
' connectionString = shell.Environment("PROCESS").Item("MYSQLCONNSTR_localdb")
' connectionString = Replace(connectionString, "localdb", "basketlummen")
connectionString = "Server=localhost; uid=azure; pwd=6#vWHD_$; database=basketlummen; option=3; port=49879;"
Response.Write(connectionString)

set con = server.createobject("ADODB.Connection")
con.ConnectionString = connectionString
con.Open 

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
