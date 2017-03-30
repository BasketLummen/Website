<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
' connectionString = shell.Environment("PROCESS").Item("MYSQLCONNSTR_localdb")
' connectionString = "DRIVER={ClearDB};" & connectionString
' connectionString = Replace(connectionString, "localdb", "basketlummen")
connectionString = "Server=localhost; uid=azure; pwd=password; database=localdb; option=3; port=49879;"
' connectionString = "DRIVER={MySQL ODBC 5.3 UNICODE Driver}; Server=127.0.0.1;Database=basketlummen;UID=azure;Password=6#vWHD_$; OPTION=3; PORT=49879"
Response.Write(connectionString)

set con = server.createobject("ADODB.Connection")
con.ConnectionString = connectionString
con.Open 

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
