---
layout: post
title:  "Eindejaarsactie- 19 December 2020"
date:   2020-11-19 00:00:00
description: Ook onze eindejaarsactie organizeren we corona-proof, afhaal moment op 19 December 2020
cover: /news/img/2020-eindejaarsactie.png
permalink: /news/2020-11-19-eindejaarsactie/
modules:
  - dish.shell.monitoring.applicationinsights.app
  - clubmanagement.payments.app
  - clubmanagement.fundraising.sales.app
---

Met de eindejaarsdagen in zicht, sluiten we binnenkort met zijn allen een bijzonder bizar jaar af. Wij geloven alvast in een kleinschalig knallend feestje. Iedereen in zijn of haar kot. Gezellig tafelend om er het beste van te maken. En vooral: plannen smeden om in 2021 - eens we dat stomme virus de baas zijn - ons sociaal leven weer op te pakken.

Maar eerst nog 2020 vaarwel zeggen. En naar goede gewoonte bieden we vanuit Basketbalclub Lummen weer een smakelijk assortiment kwaliteitswijnen en ander lekkers aan. Deze keer werken we samen met ad Bibendum uit Sint-Truiden, De Kaarskesprocessie Leonidas uit Lummen en Ekofib uit Antwerpen. 

Zij hebben voor ons een mooi aanbod samengesteld waarmee we de eindejaarsdagen toch nog gezellig kunnen maken.

* Enerzijds zullen de smaakpapillen van elke wijn-, cava- en champagneliefhebber geprikkeld worden door de wijnen van ad Bibendum. In [deze folder](/news/downloads/eindejaarsactie-2020-ad-bibendum.pdf) vind je een volledig overzicht terug met een woordje uitleg én enkele foodpairing tips bij elke fles.
* Als dessert, of stiekem tussen door, hebben we opnieuw heerlijke Leonidas pralines in aanbod. Niemand kan weerstaan aan de beroemde Witte Manon praline. De heerlijke roomboter met koffiesmaak op een bedje van praliné, omhuld met witte chocolade, maken deze praline legendarisch. Hou je toch van wat meer afwisseling, dan vind je die zeker in een doosje gemengde pralines.
* Na de maaltijd zullen we het ook nog lekker gezellig maken met de lekker warme en comfortabele bamboe sokken van Ekofib. Deze zijn one size fits all (zowel voor hem als haar), anti geur, anti alergisch en werken vocht regulerend. Gezelligheid gegarandeerd dus.

### Hoe bestellen

Bestel je voor privé gebruik? Vul dan gewoon onderstaande bestel formulier in om je bestelling door te geven. Na het ingeven van je bestelling kan je betalen via Bancontact of via je krediet kaart. Cash betalingen zijn nog steeds niet mogelijk wegens de geldende corona maatregelen. Enkel betaalde bestellingen zullen aanvaard worden.

Bestel je voor zakelijk gebruik, bvb als relatiegeschenk, en heb je een factuur nodig? Stuur dan je bestelling per email naar [secretariaat@basketlummen.be](mailto://secretariaat@basketlummen.be).

Je kan bestellen tot en met Maandag 14 December, nadien zijn bestellingen echt niet meer mogelijk.

### Afhaal moment

We voorzien opnieuw een corona proof afhaal moment op zaterdag 19 December tussen 10 en 12u. Dit is het weekend voor Kerstmis zodat de pralines nog lekker vers zijn tijdens de feestdagen. Dit afhaal moment zal opnieuw het protocol volgen dat we bij de afhaal eetdag gebruikt hebben. Print dus de bevestiging van je bestelling af en kom dan met de wagen naar het afhaalpunt aan sporthal De Vijfsprong tussen 10 en 12u om je bestelling op te pikken.

Voor de zakelijke bestellingen kan apart een afspraak gemaakt worden voor de levering, zodat je de producten nog tijdig bij je zakelijke relaties kan krijgen. 

### Vragen

Moest je problemen ondervinden met je online betaling, of heb je een andere praktische vraag over je bestelling, dan kan je steeds contact opnemen met [secretariaat@basketlummen.be](mailto://secretariaat@basketlummen.be).


<clubmgmt-purchase-order-wizard sale-id="1f35da38-a943-472f-8977-dd11c81d53f6"></clubmgmt-purchase-order-wizard>

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
              We verwelkomen je op 19 december 2020 aan de sporthal van Lummen tussen 10u en 12u om je bestelling af te halen.
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