<%
Session.LCID = 2067

set con = server.createobject("ADODB.Connection")
'con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=root; pwd=root; 'database=basketlummen; option=3; port=3306;"
con.Open "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; uid=basketlummen; pwd=ba7863; database=basketlummen; option=3; port=3306;"

set rs = server.createobject("adodb.recordset")
rs.activeconnection = con
%>
