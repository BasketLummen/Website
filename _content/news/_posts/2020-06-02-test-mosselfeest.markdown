---
layout: post
title:  "Mosselfeest Testing"
date:   2020-06-02 17:00:00
description: Testing Online Payments Mosselfeest
permalink: /news/2020-06-02-test-mosselfeest/
preload_js:
  - config
custom_js:
  - purchaseorder
modules:
  - ai.module
  - clubmanagement.fundraising.sales.app
---

This is a test for a sale where
- people can order multiple products
- And specify a quantity themselves (specific dishes)
- the sale will close July 5th UTC

<clubmgmt-purchase-order-wizard sale-id="3a8c5ca3-617f-4080-bb7d-2beabdfd7859"></clubmgmt-purchase-order-wizard>

<div data-saleid="3a8c5ca3-617f-4080-bb7d-2beabdfd7859"  data-title="Plaats je bestelling" data-buttontext="Bestellen"  data-nexttext="Nog een bestelling plaatsen" data-optional="email"></div>
