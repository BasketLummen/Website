import { PurchaseOrderWizard } from "/js/clubmanagement.fundraising.sales.component.purchaseorderwizard.js"
import { PurchaseOrderForm } from "/js/clubmanagement.fundraising.sales.component.purchaseorderform.js"
import { PurchaseOrderPayment } from "/js/clubmanagement.fundraising.sales.component.purchaseorderpayment.js"
import { PurchaseOrderConfirmation } from "/js/clubmanagement.fundraising.sales.component.purchaseorderconfirmation.js"
import { PurchaseOrderErrorReport } from "/js/clubmanagement.fundraising.sales.component.purchaseordererrorreport.js"
import { PurchaseOrderPdf } from "/js/clubmanagement.fundraising.sales.component.purchaseorderpdf.js"
import { paymentsConfig } from "./clubmanagement.payments.config.js";

import shell from "./dish.shell.js"

(function() {

	paymentsConfig.language = "nl-be";

	shell.activate();

    customElements.define('clubmgmt-purchase-order-wizard', PurchaseOrderWizard);
    customElements.define('clubmgmt-purchase-order-form', PurchaseOrderForm);
	customElements.define('clubmgmt-purchase-order-payment', PurchaseOrderPayment);
	customElements.define('clubmgmt-purchase-order-confirmation', PurchaseOrderConfirmation);
	customElements.define('clubmgmt-purchase-order-error-report', PurchaseOrderErrorReport);
	customElements.define('clubmgmt-purchase-order-pdf', PurchaseOrderPdf);
 })();