---
layout: post
title:  "Pastadag Testing"
date:   2020-06-02 17:00:00
description: Testing Online Payments Pastadag
permalink: /news/2020-06-02-test-pastadag/
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
- people can order multiple products (buffet for a person)
- And specify a quantity themselves
- the sale will close July 5th UTC

<clubmgmt-purchase-order-wizard saleid="688b702f-7404-4b71-9ff2-e34ad1b586b4"></clubmgmt-purchase-order-wizard>

<div data-saleid="688b702f-7404-4b71-9ff2-e34ad1b586b4"  data-title="Plaats je bestelling" data-buttontext="Bestellen"  data-nexttext="Nog een bestelling plaatsen" data-optional="email"></div>
