---
layout: post
title:  "Steak Testing"
date:   2020-06-02 17:00:00
description: Testing Online Payments Steak
permalink: /news/2020-06-02-test-steak/
preload_js:
  - config
modules:
  - ai.module
  - clubmanagement.fundraising.sales.app
---

This is a test for a sale where
- people can order a multiple products (dishes)
- specify quantity 
- but there are different variants of the steak (sauce, cuisine) with different pricing
- the sale will close July 5th UTC

<clubmgmt-purchase-order-wizard sale-id="7c033609-d93d-4eca-855f-7fb232233ba2"></clubmgmt-purchase-order-wizard>

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
          <td><label for="firstname">Voornaam</label></td>
          <td><input type="text" id="firstname" name="firstname" placeholder="Vul je voornaam in..." required></input></td>
        </tr>
        <tr>
          <td><label for="name">Familienaam</label></td>
          <td><input type="text" id="name" name="name" placeholder="Vul je familienaam in..." required></input></td>
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
      <tbody id="delivery-slots"></tbody>
      <tbody>  
        <tr>
          <td><label for="sendConfirmation">Stuur me een bevestiging</label></td>
          <td><input type="checkbox" id="sendConfirmation" name="sendConfirmation" placeholder="Vul je email in..." checked></input> (vereist email)</td>
        </tr>   
        <tr>
          <td><label for="submit"></label></td>
          <td><button type="submit"><img class="spinner" src="/img/loader-button.gif">Bestellen</button></td>
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

<template id="clubmgmt-purchase-order-delivery-slot-template">
    <tr>
        <td><label class="clear-subsequent">Wij komen van</label></td>
        <td><input type="radio" name="delivery"></input> <span class="slot-from"></span> tot <span class="slot-to"></span></td>
    </tr>
</template>


<!-- <div data-saleid="7c033609-d93d-4eca-855f-7fb232233ba2"  data-title="Plaats je bestelling" data-buttontext="Bestellen"  data-nexttext="Nog een bestelling plaatsen" data-optional="email"></div> -->