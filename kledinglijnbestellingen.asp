<!--#include file="ccorner/connect.asp" --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Kledinglijn</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
-->
</style>
</head>

<body>
<%

set rs1 = server.CreateObject("ADODB.Recordset")
rs1.ActiveConnection= Con

sqlstring = "SELECT * FROM tblkledijnamen ORDER BY id"
rs.open sqlstring
%>
 
    <%while not rs.eof%>
        <table border="1" cellspacing="0">
            <tr>
                <td>Naam</td>
                <td><%=rs("naam")%></td>
            </tr>
            <tr>
                <td>Ploeg</td>
                <td><%=rs("ploeg")%></td>
            </tr>
            <tr>
                <td>Adres</td>
                <td><%=rs("adres1")%>, <%=rs("adres2")%></td>
            </tr>
            <tr>
                <td>GSM</td>
                <td><%=rs("gsm")%></td>
            </tr>
            <tr>
                <td>E-mail</td>
                <td><%=rs("email")%></td>
            </tr>
            <tr>
            	<td valign="top">Bestelling</td>
            	<td>
				<%sqlstring = "SELECT * FROM tblkledijbestellingen WHERE naam ="&rs("id")
                rs1.open sqlstring
				while not rs1.eof%>
                	<b>
					<%Select case rs1("item")
						case 1:
							response.Write("Polo heren, ")
						case 2:
							response.Write("T-shirt dames, ")
						case 3:
							response.Write("Windjacket heren, ")
						case 4:
							response.Write("Windjacket dames, ")
						case 5:
							response.Write("Sweater, ")
						case 6:
							response.Write("Badhanddoek groot, ")
						case 7:
							response.Write("Badhanddoek klein, ")
					end select							
					%></b>aantal: <b><%=rs1("aantal")%></b>, maat: <b><%=rs1("maat")%></b>, opdruk: <b><%=rs1("tekst")%></b><br>
					<%rs1.movenext
				wend
				rs1.close%>
                </td>
            </tr>
        </table>
        <br>
    	<%
		rs.movenext
	wend
rs.close%>

</body>
</html>
