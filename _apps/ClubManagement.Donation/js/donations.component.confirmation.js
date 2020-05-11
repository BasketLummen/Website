import { appInsights } from "/js/ai.module.js"
import { queryString } from "/js/utils.querystring.js"

class DonationConfirmation extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("donation-template");
        this.baseUri = "https://clubmgmt-donation-service-test.azurewebsites.net/api/donations";
    }

    async connectedCallback() {
        // HTML2PDF clones the window, causing the component to re-render again.
        // Only render the first time. Identify the subsequent rendering by checking for component's inner HTML
        if (this.innerHTML !== '') 
            return;
        this.append(document.createElement("span"));
        
        const templateText = document.getElementById("confirmation-template")
            .innerText.replace("{{{{raw}}}}", "")
            .replace("{{{{/raw}}}}", "");

        const donationId = queryString.get("d");
        const url = `${this.baseUri}/${donationId}/receipt`;

        const response = await fetch(url, {
            method: 'GET',
            mode: 'cors',
            cache: 'no-cache',
            headers: { 'Content-Type': 'application/json' }
        });
        
        const data = await response.json();
        const template = Handlebars.compile(templateText);
        const body = template({
            data: {
                donationDate: data.donationDate,
                amount: data.amount,
                currency: this.getCurrencySymbol(data.currency)
            }
        });

        const canvas = document.getElementById("confirmation-canvas");
        canvas.innerHTML = body;
        canvas.style.display = "block";
        
        const pdf = await html2pdf()
            .set({ html2canvas: { scale: 4, letterRendering: true } })
            .from(canvas)
            .toPdf()
            .get('pdf');
        
        const documentUrl = pdf.output('bloburl');

        appInsights.trackEvent({
            name: "ConfirmationPdfGenerated",
            properties: { eventCategory: "Fundraising.Donations", eventAction: "render", 
                donationId: donationId, documentUrl: documentUrl }
        });

        canvas.style.display = "none";

        const iframe = document.getElementById('printoutput');
        iframe.src = `/pdf/viewer.html?file=${documentUrl}`;
    }

    getCurrencySymbol(currencyCode) {
        if (currencyCode === "eur") {
            return "&euro;"
        }
        
        return currencyCode;
    }
}

export { DonationConfirmation }