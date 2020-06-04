import { appInsights } from "/js/ai.module.js"

class PurchaseOrderWizard extends HTMLElement {

    constructor(){
        super();

    }

    static get observedAttributes() {
        return ['sale-id'];
      }
  
      get saleId() {
        return this.getAttribute('sale-id');
      }
  
      set saleId(val) {
        if (val) {
          this.setAttribute('sale-id', val);
        } else {
          this.removeAttribute('sale-id');
        }
      }    
  

    async connectedCallback() {    
        this.showStep( "clubmgmt-purchase-order-form"); 

        appInsights.trackEvent({
            name: "PurchaseOrderWizardRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }

    showStep(name){
        
        this.innerHTML = '';
        
        var step = document.createElement(name);
        step.setAttribute('sale-id', this.saleId);

        step.addEventListener("pay", (event) => {
            this.showStep("clubmgmt-purchase-order-payment");
        } );
        step.addEventListener("confirm", (event) => {
            this.showStep("clubmgmt-purchase-order-confirmation");
        }); 
        step.addEventListener("new", (event) => {
            this.showStep("clubmgmt-purchase-order-form");
        });

        this.append(step);       
    }
}

export { PurchaseOrderWizard }