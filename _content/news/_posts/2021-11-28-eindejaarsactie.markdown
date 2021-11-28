---
layout: post
title:  "Eindejaarsactie- 22 December 2021"
date:   2021-11-28 00:00:00
description: Ook dit jaar organizeren we een corona-proof eindejaarsactie, afhaal moment op 22 December 2021
cover: /news/img/2020-eindejaarsactie.png
permalink: /news/2021-11-28-eindejaarsactie/
modules:
  - dish.shell.monitoring.applicationinsights.app
  - clubmanagement.payments.public.app
  - clubmanagement.fundraising.sales.app
---

De eindejaarsdagen komen weer in zicht.

Wij kijken er alvast naar uit om het jaar af te sluiten en daar horen uiteraard heerlijke bubbels en wijnen bij. 

Vanuit Basket Lummen bieden we ook dit jaar graag enkele kwaliteitswijnen aan.

Hiervoor werken we samen met ad Bibendum Fine World Wines uit Sint-Truiden en De Kaarskesprocessie Leonidas uit Lummen.

Samen hebben wij een mooi assortiment samengesteld waamee de smaakpapillen van elke wijn- 
en chocolade liefhebber geprikkeld worden.

De opbrengst van de verkoop geeft ons als club de mogelijkheid om verder te investeren in de toekomst en jullie hebben alvast wat lekkers op de feesttafel!

Nu al bedankt voor jullie inzet en verkoop!

### Hoe bestellen

Bestel je voor privé gebruik? Vul dan gewoon onderstaande bestel formulier in om je bestelling door te geven. 

Na het ingeven van je bestelling kan je betalen via Bancontact of via je krediet kaart. Tevens kan je het bedrag overschrijven op rekening van de club: BE16 3630 4262 5274 met vermelding voor en achternaam zoals op de bestelling. Cash is niet mogelijk. 

Enkel betaalde bestellingen zullen aanvaard worden.

Bestel je voor zakelijk gebruik, bvb als relatiegeschenk, en heb je een factuur nodig? Stuur dan je bestelling per email naar [secretariaat@basketlummen.be](mailto://secretariaat@basketlummen.be).

Je kan bestellen tot 20 December, nadien zijn bestellingen echt niet meer mogelijk.

### Afhaal moment

We voorzien opnieuw een corona proof afhaal moment op woensdag 22 December tussen 17 en 20u. Dit is net voor Kerstmis zodat de pralines nog lekker vers zijn tijdens de feestdagen. 

Dit afhaal moment zal opnieuw het protocol volgen dat we bij eerdere afhaalmomenten gebruikt hebben. Print dus de bevestiging van je bestelling af en kom dan met de wagen naar het afhaalpunt aan sporthal De Vijfsprong tussen 17 en 20u om je bestelling op te pikken.

Voor de zakelijke bestellingen kan apart een afspraak gemaakt worden voor de levering, zodat je de producten nog tijdig bij je zakelijke relaties kan krijgen. 

### Vragen

Moest je problemen ondervinden met je online betaling, of heb je een andere praktische vraag over je bestelling, dan kan je steeds contact opnemen met [secretariaat@basketlummen.be](mailto://secretariaat@basketlummen.be).

<clubmgmt-purchase-order-wizard sale-id="a4118349-1e5a-4030-874b-dbc4f24bd250"></clubmgmt-purchase-order-wizard>

<template id="clubmgmt-purchase-order-form-template">
  <form class="responsive-form">
    <fieldset>
      <legend>Plaats je bestelling</legend>
    </fieldset>
  </form>
</template>

<template id="clubmgmt-purchase-order-sale-open-template">
    <table>
      <tbody>
        <tr>
          <td><label for="given-name">Voornaam</label></td>
          <td><input type="text" id="given-name" name="given-name" placeholder="Vul je voornaam in..." required></input></td>
        </tr>
        <tr>
          <td><label for="family-name">Familienaam</label></td>
          <td><input type="text" id="family-name" name="family-name" placeholder="Vul je familienaam in..." required></input></td>
        </tr>
        <tr>
          <td><label for="email">Email</label></td>
          <td><input type="text" id="email" name="email" placeholder="Vul je email in..."></input></td>
        </tr>
		    <tr>
          <td><label for="telephone">Telefoon</label></td>
          <td><input type="text" id="telephone" name="telephone" placeholder="Vul je telefoon in..."></input></td>
        </tr>
      </tbody>
      <tbody id="offers"></tbody>
      <tbody>    
        <tr class="total-row">
          <td><label>Te betalen</label></td>
          <td><label id="price">€ 0</label></td>
        </tr>   
      </tbody>      
      <tbody>
        <tr>
          <td style="vertical-align: top"><label for="comment">Opmerking</label></td>
          <td><textarea id="comment" name="comment" rows="4" style="width: initial" placeholder="Ga je bij iemand leveren? Extra wensen? Noteer het dan hier."></textarea></td>
        </tr> 
      </tbody>
      <tbody> 
        <tr>
          <td><label for="sendConfirmation">Stuur me een bevestiging</label></td>
          <td><input type="checkbox" id="sendConfirmation" name="sendConfirmation" checked></input> (vereist email)</td>
        </tr>  
      </tbody>
      <tbody id="delivery-types" style="display: none"></tbody>
      <tbody id="delivery-slots" style="display: none"></tbody>
      <tbody id="delivery-location" style="display: none"></tbody>
      <tbody>
        <tr>
          <td><label for="submit"></label></td>
          <td><submit-button>Doorgaan naar betalen</submit-button></td>
        </tr>
      </tbody>        
    </table>
</template>

<template id="clubmgmt-purchase-order-sale-pending-template">
    <table>
      <tr>
        <td><label>Registratie gaat pas open op <span class="sale-from"></span></label></td>
      </tr>
    </table>
</template>

<template id="clubmgmt-purchase-order-sale-over-template">
    <table>
      <tr>
        <td><label>Registratie is afgelopen</label></td>
      </tr>
    </table>
</template>

<template id="clubmgmt-purchase-order-offer-template">
    <tr>
        <td class="label-holder"><label></label></td>
        <td class="input-holder"></td>
    </tr>
</template>

<template id="clubmgmt-purchase-order-offer-collection-name-template">
    <tr>
        <td></td>
        <td><label class="collection-name"></label></td>
    </tr>
</template>

<template id="clubmgmt-purchase-order-offer-label-template">
    <label></label>
</template>

<template id="clubmgmt-purchase-order-offer-input-number-template">
    <input type="number" placeholder="0" min="0" />
</template>

<template id="clubmgmt-purchase-order-offer-input-toggle-template">
    <input />
</template>

<template id="clubmgmt-purchase-order-offer-input-dropdown-template">
    <select />
</template>

<template id="clubmgmt-purchase-order-offer-horizontal-container-template">
    <div class="horizontal-container"></span>
</template>

<template id="clubmgmt-purchase-order-offer-option-label-template">
    <span class="option-label"></span>
</template>

<template id="clubmgmt-purchase-order-delivery-types-template">
    <tr>
        <td><label>Levering</label></td>
        <td><select id="delivery-types-selector" name="delivery-types-selector"></select></td>
    </tr>
</template>

<template id="clubmgmt-purchase-order-delivery-slot-template">
    <tr>
        <td></td>
        <td><input type="radio" name="delivery"></input> <span class="slot-from"></span> tot <span class="slot-to"></span></td>
    </tr>
</template>

<template id="clubmgmt-purchase-order-delivery-location-template">
    <tr>
      <td><label for="addressLine1">Adres Lijn 1</label></td>
      <td><input type="text" id="addressLine1" name="addressLine1" placeholder="Vul je adres in..." required></input></td>
    </tr>
    <tr>
      <td><label for="addressLine2">Adres Lijn 2</label></td>
      <td><input type="text" id="addressLine2" name="addressLine2" placeholder="Vul je adres in..."></input></td>
    </tr>
    <tr>
      <td><label for="postcode">Postcode</label></td>
      <td><input type="text" id="zipCode" name="zipCode" value="3560" disabled required></input></td>
    </tr>
    <tr>
      <td><label for="city">Stad</label></td>
      <td><input type="text" id="city" name="city" value="Lummen" disabled required></input></td>
    </tr>
    <tr>
      <td><label for="stateProvince">Provincie</label></td>
      <td><input type="text" id="stateProvince" name="stateProvince" value="Limburg" disabled required></input></td>
    </tr>
    <tr>
      <td><label for="country">Land</label></td>
      <td><input type="text" id="country" name="country" value="België" disabled required></input></td>
    </tr>
</template>

<template id="clubmgmt-purchase-order-confirmation-template">
  <form class="responsive-form">
    <fieldset>
      <legend>Bedankt voor je bestelling!</legend>
      <table>
        <tr>
          <td colspan="2" class="align-left">
              We verwelkomen je op woensdag 22 december 2021 aan de sporthal van Lummen tussen 17u en 20u om je bestelling af te halen.
              Je kan je bestelling <a class="pdf-link" href="/order/confirmation/">hier</a> afdrukken.
          </td>
        </tr>
        <tr>
          <td colspan="2" class="align-left">
            <button id="new">Nog een bestelling plaatsen</button>
          </td>
        </tr>
      </table>
    </fieldset>
  </form>
</template>

<template id="clubmgmt-purchase-order-error-report-template">
  <form class="responsive-form">
    <fieldset>
      <legend>Er is iets fout gegaan!</legend>
      <table>
        <tr>
          <td colspan="2" class="align-left error-message">
          </td>
        </tr>
        <tr>
          <td colspan="2" class="align-left">
            <button id="new">Opnieuw een bestelling plaatsen</button>
          </td>
        </tr>
      </table>
    </fieldset>
  </form>
</template>

<!-- payment step -->

<template id="clubmgmt-purchase-order-payment-template">

  <form class="responsive-form" id="orderPayment">
    <fieldset>
      <legend>Kies een betaal methode</legend>
      <payment-method-selector id="paymentMethodSelector">
      </payment-method-selector>
      <submit-button>Betalen</submit-button>
    </fieldset>
  </form>
  
</template>

<template id="clubmgmt-payment-method-wiretransfer-form-template">
  <div class="table">	
		<div class="table-row">
			<div class="table-cell">
				 Gelieve het geld over te schrijven op rekeningnummer BE16 3630 4262 5274 met vermelding voor en achternaam zoals op de bestelling
			</div>	
      <div class="table-cell"></div>
		</div>
	</div>
</template>