---
layout: post
title:  "Testing Take Away & Home Delivery"
date:   2020-09-02 17:00:00
description: Testing Take Away & Home Deliver
permalink: /news/2020-09-02-test-delivery/
modules:
  - dish.shell.monitoring.applicationinsights.app
  - clubmanagement.payments.app
  - clubmanagement.fundraising.sales.app
---

This is a test for a sale where
- people can order multiple products 
- and have multiple delivery options
- the sale will close October 5th 

<clubmgmt-purchase-order-wizard sale-id="fe8430bf-00a4-42b7-b077-87d8fff4ba68"></clubmgmt-purchase-order-wizard>

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
          <td><input type="checkbox" id="sendConfirmation" name="sendConfirmation" placeholder="Vul je email in..." checked></input> (vereist email)</td>
        </tr>  
      </tbody>
      <tbody id="delivery-types"></tbody>
      <tbody id="delivery-slots"></tbody>
      <tbody id="delivery-location"></tbody>     
      <tbody>
        <tr>
          <td><label for="submit"></label></td>
          <td><submit-button>Bestellen</submit-button></td>
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
              We zien je op het mosselfeest (hier moet meer info over plaats & tijdstip).
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
      <legend>Online betaling</legend>
      <payment-method-selector id="paymentMethodSelector">
      </payment-method-selector>
      <submit-button>Betalen</submit-button>
    </fieldset>
  </form>
  
</template>