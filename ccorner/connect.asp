<%
Session.LCID = 2067

Response.Buffer = True
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"

set shell = createobject("WScript.Shell")
connectionString = shell.Environment("PROCESS").Item("MYSQLCONNSTR_localdb")
' connectionString = "DRIVER={ClearDB};" & connectionString
' connectionString = Replace(connectionString, "localdb", "basketlummen")
' connectionString = "Server=localhost; uid=azure; pwd=password; database=localdb; option=3; port=49879;"
' connectionString = "DRIVER={MySQL ODBC 5.3 UNICODE Driver}; Server=127.0.0.1;Database=basketlummen;UID=azure;Password=6#vWHD_$; OPTION=3; PORT=49879"
' connectionString = "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=127.0.0.1; DATABASE=basketlummen; UID=azure;PASSWORD=6#vWHD_$; OPTION=3"
Response.Write(connectionString)

'Const HKEY_LOCAL_MACHINE = &H80000002
'strComputer = "."
'Set objRegistry = GetObject("winmgmts:\\" & strComputer & "\root\default:StdRegProv")
'strKeyPath = "SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers"
'objRegistry.EnumValues HKEY_LOCAL_MACHINE, strKeyPath, arrValueNames, arrValueTypes
'For i = 0 to UBound(arrValueNames)
'    strValueName = arrValueNames(i)
'    objRegistry.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
'    Response.Write arrValueNames(i) & " — " & strValue
'Next

set con = server.createobject("ADODB.Connection")
con.ConnectionString = connectionString
con.Open 

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
