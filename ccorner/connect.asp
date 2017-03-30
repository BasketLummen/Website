<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
connectionString = shell.Environment("PROCESS").Item("MYSQLCONNSTR_localdb")
connectionString = Replace(connectionString, "localdb", "basketlummen")
Response.Write(connectionString)

set con = server.createobject("ADODB.Connection")
'con.ConnectionString = connectionString
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=6#vWHD_$; database=basketlummen; option=3; port=49879;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
