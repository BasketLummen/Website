import shell from "/js/dish.shell.js"

class PurchaseOrderErrorReport extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-purchase-order-error-report-template");
    }

    static get observedAttributes() {
        return ['data-context'];
    }

    get contextData() {
        return this.getAttribute('data-context');
    }

    set contextData(val) {
        if (val) {
            this.setAttribute('data-context', val);
        } else {
            this.removeAttribute('data-context');
        }
    }

    async connectedCallback() {

        this.context = JSON.parse(this.contextData);    

        var content = this.template.content.cloneNode(true);

        var messages = content.querySelectorAll(".error-message");
        messages.forEach(message => {
            message.innerText = this.context.error;
        });

        var form = content.querySelector("form");       

        form.addEventListener('submit', async (event) => {
			event.preventDefault();

            this.dispatchEvent(new Event('new'));
            
        });

        this.append(content);

        shell.appInsights.trackEvent({
            name: "PurchaseOrderErrorReportRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
    }
}

export { PurchaseOrderErrorReport }