---
layout: post
hidden: false
title:  "24 oktober 2021: Afhaal Pastadag"
date:   2021-09-21 00:00:00
description: Afhaal restaurantdag op 24 oktober 2021
permalink: /news/2021-10-24-afhaal-eetdag/
cover: /news/img/2021-03-21-afhaal-eetdag.jpg
modules:
  - dish.shell.monitoring.applicationinsights.app
  - clubmanagement.payments.public.app
  - clubmanagement.fundraising.sales.app
---

**De verkoop voor de afhaal pastadag is nog niet open.**

### Afhaal restaurantdag

Deze actie werd mede mogelijk gemaakt door restaurant La Passione uit Bolderberg.

Het afhaalmoment zal plaatsvinden **op zondag 24 oktober 2021 van 9u tot 12u aan sporthal De Vijfsprong, Sportweg 8 Lummen**

Je kan kiezen uit een 9-tal lekkere gerechten.

### Hoe klaarmaken

- Elke portie bevat ongeveer 500 gram en is bereid met verse producten.
- Je hoeft enkel een paar gaatjes in de folie te prikken en na 5 minuten in de microgolfovern kan je aan tafel!
- **Je kan een menu nog een week in de koelkast bewaren of invriezen voor later. Bestel dus gerust wat meer om een week niet meer te hoeven koken!**
- Omwille van praktische en hygiënische redenen moeten we met plastic bakjes werken. We roepen iedereen dan ook op om deze correct te recycleren en niet met het grof vuil mee te geven.

### Gerechten

Je kan kiezen uit volgende gerechten:

- Spaghetti Bolognese **€10,00**
- Spaghetti carbonara **€10,00**
- Pasta Noordzeevruchten **€12,00**
- Lasagna bolognese **€10,00**
- Veggie Lasagna **€10,00**
- Koninginnehapje **€11,00**
- Stoofvlees met puree **€11,00**
- Tomatensoep met balletjes **€7,00**
- Witte wijn (fles) **€12,00**
- Rode wijn (fles) **€12,00**
- Rosé wijn (fles) **€12,00**

### Betaling

Na het ingeven van je bestelling kan je betalen via Bancontact of via je krediet kaart. Moest je problemen ondervinden met je online betaling, dan kan je contact opnemen met [secretariaat@basketlummen.be](mailto://secretariaat@basketlummen.be).

Verder kan je ook terug cash betalen door het geld aan één van onze coaches of bestuursleden te bezorgen; of je kan het geld overschrijven op rekeningnummer BE16 3630 4262 5274 met vermelding voor en achternaam zoals op de bestelling.

### Opgelet!

Bestellingen moeten uiterlijk op **woensdag 20 oktober 2021** binnen zijn. In tegenstelling tot bij klassieke eetdagen zijn latere bestellingen echt **NIET** mogelijk. 

Enkel betaalde bestellingen zullen geleverd worden. 

<clubmgmt-purchase-order-wizard sale-id="054cb0f4-5894-4732-9f68-07d90a08e2ce"></clubmgmt-purchase-order-wizard>

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
          <td><textarea id="comment" name="comment" rows="4" style="width: initial" placeholder="Ga je bij iemand leveren? Noteer het dan hier."></textarea></td>
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

<template id="clubmgmt-purchase-order-sold-out-template">
    <table>
      <tr>
        <td><label>Wij zijn uitverkocht!</label></td>
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
              We verwelkomen je op zondag 24 oktober 2021 aan de sporthal van Lummen tussen 9u en 12u om je bestelling af te halen.
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

<template id="clubmgmt-purchase-order-payment-template">

  <form class="responsive-form" id="orderPayment">
    <fieldset>
      <legend>Kies een betaal methode</legend>
      <payment-method-selector id="paymentMethodSelector">
      </payment-method-selector>
      <submit-button>Doorgaan</submit-button>
    </fieldset>
  </form>
  
</template>

<template id="clubmgmt-payment-method-cash-form-template">
  <div class="table">	
      <div class="table-row">
        <div class="table-cell">
          Gelieve het te betalen bedrag te bezorgen aan de coach of aan een bestuurslid.
        </div>
        <div class="table-cell"></div>
      </div>    
  </div>
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