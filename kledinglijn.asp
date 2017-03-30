<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--#include file="ccorner/connect.asp"-->

<html>
<head>
<title>Kledinglijn</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="opmaak.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {font-size: 24px}
.style4 {font-size: 9px}
.style5 {font-size: 9}
-->
</style>
</head>

<body>
<%
naam = trim(request("naam"))
if naam <> "" and not isnull(naam) then
	ploeg = trim(request("ploeg"))
	adres1 = trim(request("adres1"))
	adres2 = trim(request("adres2"))
	gsm = trim(request("gsm"))
	email = trim(request("email"))
	
	sqlstring = "INSERT INTO tblkledijnamen(naam,ploeg,adres1,adres2,gsm,email,datum) VALUES('"&naam&"','"&ploeg&"','"&adres1&"','" & adres2&"','" & gsm&"','" & email&"','"&year(date())&"-"&month(date())&"-"&day(date())&"')"
	con.execute sqlstring	
	
	sqlstring = "SELECT id FROM tblkledijnamen WHERE id = LAST_INSERT_ID()"
	rs.open sqlstring
	id = rs("id")
	rs.close
	
	poloaantal = trim(request("poloaantal"))
	if poloaantal <> "" then
		if poloaantal > 0 then
			polomaat = trim(request("polomaat"))
			polotekst = trim(request("polotekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",1,"&poloaantal&",'"&polomaat&"','"&polotekst&"')"
			con.execute sqlstring
		end if
	end if
	
	
	tshirtaantal = trim(request("tshirtaantal"))
	if tshirtaantal <> "" then
		if tshirtaantal > 0 then
			tshirtmaat = trim(request("tshirtmaat"))
			tshirttekst = trim(request("tshirttekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",2,"&tshirtaantal&",'"&tshirtmaat&"','"&tshirttekst&"')"
			con.execute sqlstring
		end if
	end if
	
	windhaantal = trim(request("windhaantal"))
	if windhaantal <> "" then
		if windhaantal > 0 then
			windhmaat = trim(request("windhmaat"))
			windhtekst = trim(request("windhtekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",3,"&windhaantal&",'"&windhmaat&"','"&windhtekst&"')"
			con.execute sqlstring
		end if
	end if
	
	winddaantal = trim(request("winddaantal"))
	if winddaantal <> "" then
		if winddaantal > 0 then
			winddmaat = trim(request("winddmaat"))
			winddtekst = trim(request("winddtekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",4,"&winddaantal&",'"&winddmaat&"','"&winddtekst&"')"
			con.execute sqlstring
		end if
	end if
	
	sweateraantal = trim(request("sweateraantal"))
	if sweateraantal <> "" then
		if sweateraantal > 0 then
			sweatermaat = trim(request("sweatermaat"))
			sweatertekst = trim(request("sweatertekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",5,"&sweateraantal&",'"&sweatermaat&"','"&sweatertekst&"')"
			con.execute sqlstring
		end if
	end if
	
	badgrootaantal = trim(request("badgrootaantal"))
	if badgrootaantal <> "" then
		if badgrootaantal > 0 then
			badgroottekst = trim(request("badgroottekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",6,"&badgrootaantal&",'','"&badgroottekst&"')"
			con.execute sqlstring
		end if
	end if
	
	badkleinaantal = trim(request("badkleinaantal"))
	if badkleinaantal <> "" then
		if badkleinaantal > 0 then
		badkleintekst = trim(request("badkleintekst"))
			sqlstring = "INSERT into tblkledijbestellingen(naam,item,aantal,maat,tekst) VALUES("&id&",7,"&badkleinaantal&",'','"&badkleintekst&"')"
			con.execute sqlstring
		end if
	end if
	
	if isempty(conf) then
			const cdosendusingport = 2
			set conf = createobject("cdo.configuration")
	
			with conf.fields
				.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
				.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
				.Update
			end with
	end if	
	
	Set myMail=CreateObject("CDO.Message")
	myMail.configuration = conf
	myMail.Subject="Basket Lummen kledinglijn"
	myMail.From="Basket Lummen (johnny.peeters@basketlummen.be)"
	myMail.To="linda.doggen@telenet.be"
	myMail.HTMLBody = "Er is een nieuwe bestelling van de kledinglijn: <a href=http://www.basketlummen.be/kledinglijnbestellingen.asp>http://www.basketlummen.be/kledinglijnbestellingen.asp</a>" 
	myMail.Send
	set myMail=nothing


	%>

    
  <table border="0" align="center">
    <tr>
	<td width="20">&nbsp;</td>
	  <td valign="top">
            <p align="center"><span class="NieuwsTitels style3">Kledinglijn Basket Lummen</span></p>
      		<p>Bedankt voor uw bestelling</p>
            <p>U kan eventueel deze pagina afdrukken als bewijs van uw bestelling</p>
           	<hr>
            <h3>Naam: <%=naam%></h3>
			<p>Ploeg: <%=ploeg%><br>
			Adres: <%=adres1%>, <%=adres2%><br>
            Gsm: <%=gsm%>
            E-mail: <%=email%></p>

            <table border="1" cellspacing="0">
             	<tr><td valign="top">Polo heren</td><td>Aantal: <%=poloaantal%><br>Maat: <%=polomaat%><br>Opdruk: <%=polotekst%></td></tr>
           		<tr><td valign="top">T-shirt dames</td><td>Aantal: <%=tshirtaantal%><br>Maat: <%=tshirtmaat%><br>Opdruk: <%=tshirttekst%></td></tr>
            	<tr><td valign="top">Windjacket heren</td><td>Aantal: <%=windhaantal%><br>Maat: <%=windhmaat%><br>Opdruk: <%=windhtekst%></td></tr>            
            	<tr><td valign="top">Windjacket dames</td><td>Aantal: <%=winddaantal%><br>Maat: <%=winddmaat%><br>Opdruk: <%=winddtekst%></td></tr>            
            	<tr><td valign="top">Sweater</td><td>Aantal: <%=sweateraantal%><br>Maat: <%=sweatermaat%><br>Opdruk: <%=sweatertekst%></td></tr>            
            	<tr><td valign="top">Badhanddoek groot</td><td>Aantal: <%=badgrootaantal%><br>Opdruk: <%=badgroottekst%></td></tr>            
            	<tr><td valign="top">Badhanddoek klein</td><td>Aantal: <%=badkleinaantal%><br>Opdruk: <%=badkleintekst%></td></tr>            
            </table>
                <p align="center">
					<script language="JavaScript"><!-- Begin
                    if (window.print) {
                    document.write('<form>'
                    + '<input type=button name=print value="Afdrukken" '
                    + 'onClick="javascript:window.print()"></form>');
                    }
                    // End -->
                    </script>
				 </p>
      </td>
      </tr>
     
      </table>
<%else
%>
<!--#include file="inc/header.inc"-->
<!--#include file="inc/menu.inc"-->
<div id="Layer3" style="position:absolute; width:719px; height:436px; z-index:1; left: 120px; top: 70px;">
<p align="center"><span class="NieuwsTitels style3">Kledinglijn Basket Lummen</span></p>
<form name="eetdag" method="post" action="kledinglijn.asp">
  <table border="0" align="center" class="tgstrechts">
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Naam :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="naam" size="50" tabindex="1" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Ploeg :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="ploeg" size="50" tabindex="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">Adres :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="adres1" size="50" tabindex="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="adres2" size="50" tabindex="4" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">GSM :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="gsm" size="50" tabindex="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
    <tr> 
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif">E-mail :</font></td>
      <td nowrap><font face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="email" size="50" tabindex="6" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';">
        </font></td>
    </tr>
  </table>  <table border="0" align="center">
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3"><img src="img/polo.jpg" width="150" height="200"></td>
      <td colspan="5"><b>Polo heren</b></td>
    </tr>
    <tr> 
      <td width="50" rowspan="2" align="center" valign="top" nowrap>&euro; 15 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="poloaantal" type="text" tabindex="7" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="9" name="polotekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top">Maat</td>
      <td nowrap valign="top"><input name="polomaat" type="text" tabindex="8" size="4" maxlength="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3"><img src="img/tshirt.jpg" width="150" height="200"></td>
      <td colspan="5"><b>T-shirt dames</b></td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&euro; 10 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="tshirtaantal" type="text" tabindex="10" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<span class="style5"><br/>
          <span class="style4">(eventueel)</span></span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="12" name="tshirttekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top">Maat</td>
      <td nowrap valign="top"><input name="tshirtmaat" type="text" tabindex="11" size="4" maxlength="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3"><img src="img/windjacket.jpg" width="150" height="200"></td>
      <td colspan="5"><b>Windjacket heren</b></td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&euro; 55 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="windhaantal" type="text" tabindex="13" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="15" name="windhtekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top">Maat</td>
      <td nowrap valign="top"><input name="windhmaat" type="text" tabindex="14" size="4" maxlength="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3">&nbsp;</td>
      <td colspan="5"><b>Windjacket dames</b></td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&euro; 55 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="winddaantal" type="text" tabindex="16" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="18" name="winddtekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top">Maat</td>
      <td nowrap valign="top"><input name="winddmaat" type="text" tabindex="17" size="4" maxlength="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3"><img src="img/sweater.jpg" width="150" height="200"></td>
      <td colspan="5"><b>Sweater</b> (Volwassenenmaat: &euro; 35 - Kindermaat: &euro; 25)</td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&nbsp;</td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="sweateraantal" type="text" tabindex="19" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="21" name="sweatertekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top">Maat</td>
      <td nowrap valign="top"><input name="sweatermaat" type="text" tabindex="20" size="4" maxlength="5" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3"><img src="img/handdoek.jpg" width="150" height="200"></td>
      <td colspan="5"><b>Badhanddoek groot</b></td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&euro; 15 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="badgrootaantal" type="text" tabindex="22" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="23" name="badgroottekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top"></td>
      <td nowrap valign="top"></td>
    </tr>
  	<tr>
      <td colspan="6"><hr></td>
    </tr>
  	<tr>
      <td rowspan="3">&nbsp;</td>
      <td colspan="5"><b>Badhanddoek klein</b></td>
    </tr>
    <tr> 
      <td rowspan="2" align="center" valign="top" nowrap>&euro; 10 </td>
      <td nowrap valign="top">Aantal</td>
      <td valign="top"><input name="badkleinaantal" type="text" tabindex="24" value="0" size="4" maxlength="2" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';" style="text-align:center;"></td>
      <td nowrap valign="top" rowspan="2">Opdruk<br/>
        <span class="style4">(eventueel)</span></td>
      <td nowrap valign="top" rowspan="2"><textarea tabindex="25" name="badkleintekst" cols="45" rows="3" onFocus="this.style.backgroundColor='#FFFF00';" onBlur="this.style.backgroundColor='';"></textarea></td>
    </tr>
    <tr>  
      <td nowrap valign="top"></td>
      <td nowrap valign="top"></td>
    </tr>
    <tr>
      <td colspan="6"><b>Prijs bijkomend borduren: rechterborstzak kledij: 5 euro, handdoek: 2,5 euro</b> </td>
    </tr>
  </table>

  <p align="center"> 
    <input type="submit" name="Verzenden" value="Verzenden" tabindex="26" style="background-color='#FFFF00';cursor:hand;cursor:pointer;">
  </p>

</form>
<%end if%>
</div>
</body>
</html>
