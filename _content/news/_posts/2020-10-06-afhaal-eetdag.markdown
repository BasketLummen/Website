---
layout: post
title:  "11 November 2020: Afhaal Eetdag"
date:   2020-10-06 00:00:00
description: Wij organizeren onze eerste, corona-proof, afhaal eetdag op 11 November 2020
permalink: /news/2020-10-06-afhaal-eetdag/
modules:
  - dish.shell.monitoring.applicationinsights.app
  - clubmanagement.payments.app
  - clubmanagement.fundraising.sales.app
---

Omwille van de coronamaatregelen is het voor de club niet mogelijk om de traditionele eetdag te organiseren. Wij hopen dat u dit kan begrijpen.

We willen toch iedereen de kans geven om in zijn of haar bubbel lekker te kunnen eten en tegelijkertijd de werking van onze club te steunen.

Onnodig om te zeggen dat we jullie steun keihard nodig hebben om het seizoen door te geraken.

We organiseren daarom onze eerste afhaal-eetdag op woensdag 11 november 2020.

Je kan kiezen ui een 8-tal lekkere gerechten.

### Hoe gaat het in zijn werk?

- Je bezoekt net als alle andere jaren de buren, vrienden, familie, kennissen aan wie je een kaart voor de eetdag wil verkopen. Dit jaar vragen we je om nog een extra inspanning te doen en deur aan deur bij jou in de buurt rond te gaan.
- Je noteert de bestellingen en gebruikt hiervoor [dit document](/news/downloads/afhaal-eetdag.pdf) dat je zo vaak kan afdrukken als nodig. Eén helft geef je aan de buurman, nonkel of kennis en de andere helft hou je bij.
- Je vraagt ook dadelijk af te rekenenen en neemt het geld mee naar huis.
- Als je thuis komt breng je de bestellingen in via onderstaande formulier en je stort het geld onmiddelijk door naar de club via de nieuwe online betaal opties.
- Op woensdag 11 november kom je tussen 9u en 12u je bestellingen oppikken aan de sporthal in Lummen. Deze worden gekoeld bewaard en de bedoeling is dat je ze na afhaling direct bij de mensen aan wie jij een kaart verkocht hebt gaat leveren. We verpakken ze per bestelling met de naam erop vermeld bij wie je moet leveren.
- Smakelijk!

### Hoe klaarmaken

- Elke portie bevat ongeveer 600 gram en is bereid met verse producten.
- Je hoeft enkel een paar gaatjes in de folie te prikken en na 5 minuten in de microgolfovern kan je aan tafel!
- Je kan een menu nog een week in de koelkast bewaren of invriezen voor later. Bestel dus gerust wat meer om een week niet meer te hoeven koken!
- Omwille van praktische en hygiënische redenen moeten we met plastic bakjes werken. We roepen iedereen dan ook op om deze correct te recycleren en niet bij het grof vuil mee te geven.

### Gerechten

Je kan kiezen uit volgende gerechten:

- Spaghetti Bolognese **€9,00**
- Macaroni met kaas en ham **€9,00**
- Linguini met scamp **€11,00**
- Vidée met puree **€10,00**
- Balletjes in tomatensaus en puree **€10,00**
- Hespenrolletjes met witloof en puree **€10,00**
- Vispannetje met puree **€11,00**
- Schelvishaasje gestoofde prei puree **€11,00**
- Vegetarische wok **€10,00**
- Tomatensoep met balletjes (1L) **€5,00**
- Aspergeroomsoep (1L) **€5,00**

### Opgelet!

Bestellingen moeten uiterlijk **woensdag 4 november 2020**. In tegenstelling tot bij onze klassieke eetdagen zijn latere bestellingen echt **NIET** mogelijk.

<clubmgmt-purchase-order-wizard sale-id="be11416f-e7bb-41f0-92c0-5df34e34fca8"></clubmgmt-purchase-order-wizard>

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
          <td><label for="sendConfirmation">Stuur me een bevestiging</label></td>
          <td><input type="checkbox" id="sendConfirmation" name="sendConfirmation" checked></input> (vereist email)</td>
        </tr>  
      </tbody>
      <tbody id="delivery-types"></tbody>
      <tbody id="delivery-slots"></tbody>
      <tbody id="delivery-location"></tbody>     
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
              We verwelkomen je op 11 november 2020 aan de sporthal van Lummen tussen 9u en 12u.
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
      <legend>Online betaling, kies je betaal methode</legend>
      <payment-method-selector id="paymentMethodSelector">
      </payment-method-selector>
      <submit-button>Betalen</submit-button>
    </fieldset>
  </form>
  
</template>