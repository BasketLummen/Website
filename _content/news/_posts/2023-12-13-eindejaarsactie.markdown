---
layout: post
hidden: true
title:  "13 december 2023: Eindejaarsactie"
date:   2023-12-13 00:00:00
description: Eindejaarsactie op 13 december 2023
permalink: /news/2023-12-13-eindejaarsactie/
cover: /news/img/2020-eindejaarsactie.png
---

Coming soon...

<style>
    clubmgmt-checkout-form .table-row .table-cell:first-of-type
    {
        width: 50%;
    }

    payment-method
    {
        display: table-row-group;
    }
</style>

<!-- Import, configure and activate the sales library using a script tag -->
<script type="module">

 import { shell, translations } from "https://fundraising.clubmanagement.io/cdn/release/1.0.5/clubmanagement.sales.public.min.js";

 (async function() {			

	translations.language = "nl";

	translations.CheckoutFormOrderConfirmationLegend.nl = "We verwelkomen je op woensdag 23 december 2023 aan de sporthal van Lummen tussen 17u en 20u om je bestelling af te halen.";
    translations.CheckoutFormChoosePaymentMethodCashMessage.nl = "Gelieve het te betalen bedrag te bezorgen aan de coach of aan een bestuurslid.";
    translations.CheckoutFormChoosePaymentMethodWireTransferMessage.nl = " Gelieve het geld over te schrijven op rekeningnummer BE16 3630 4262 5274 met vermelding voor en achternaam zoals op de bestelling";

	await shell.activate();		
	
 })();
	
</script>

<!-- Add this tag on the promotion page of your sale -->
<!-- <clubmgmt-checkout data-sale-id="86e9cac4-fb48-3e00-53fa-b046815224aa" data-organization-id="5159e64f-4d2e-42c4-968d-6ff38338129b"></clubmgmt-checkout> -->