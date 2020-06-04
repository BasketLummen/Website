---
layout: post
title:  "Steak Testing"
date:   2020-06-02 17:00:00
description: Testing Online Payments Steak
permalink: /news/2020-06-02-test-steak/
custom_js:
- handlebars-v4.0.12
- ptsans
- jspdf.min
- purchaseorder
modules:
  - ai.module
  - clubmanagement.fundraising.sales.app
---

This is a test for a sale where
- people can order a multiple products (dishes)
- specify quantity 
- but there are different variants of the steak (sauce, cuisine) with different pricing
- the sale will close July 5th UTC

<clubmgmt-purchase-order-wizard saleid="7c033609-d93d-4eca-855f-7fb232233ba2"></clubmgmt-purchase-order-wizard>

<div data-saleid="7c033609-d93d-4eca-855f-7fb232233ba2"  data-title="Plaats je bestelling" data-buttontext="Bestellen"  data-nexttext="Nog een bestelling plaatsen" data-optional="email"></div>