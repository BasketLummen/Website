import { PurchaseOrderWizard } from "/js/clubmanagement.fundraising.sales.component.purchaseorderwizard.js"
import { PurchaseOrderForm } from "/js/clubmanagement.fundraising.sales.component.purchaseorderform.js"
import { PurchaseOrderPayment } from "/js/clubmanagement.fundraising.sales.component.purchaseorderpayment.js"
import { PurchaseOrderConfirmation } from "/js/clubmanagement.fundraising.sales.component.purchaseorderconfirmation.js"
import { PurchaseOrderPdf } from "/js/clubmanagement.fundraising.sales.component.purchaseorderpdf.js"

(function() {
    customElements.define('clubmgmt-purchase-order-wizard', PurchaseOrderWizard);
    customElements.define('clubmgmt-purchase-order-form', PurchaseOrderForm);
	customElements.define('clubmgmt-purchase-order-payment', PurchaseOrderPayment);
	customElements.define('clubmgmt-purchase-order-confirmation', PurchaseOrderConfirmation);
	customElements.define('clubmgmt-purchase-order-pdf', PurchaseOrderPdf);
 })();