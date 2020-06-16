import { appInsights } from "/js/ai.module.js"
import { queryString } from "/js/clubmanagement.querystring.js"
import { donationsConfig } from "/js/clubmanagement.fundraising.donations.config.js"

class DonationPdf extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-donation-pdf-template");
        this.baseUri = donationsConfig.donationsService + "/api/donations";
    }

    async connectedCallback() {
        // HTML2PDF clones the window, causing the component to re-render again.
        // Only render the first time. Identify the subsequent rendering by checking for component's inner HTML
        if (this.innerHTML !== '') 
            return;
        this.innerHTML = '<iframe id="printoutput" style="width:100vw; height: 100vh; border: none"></iframe><div id="confirmation-canvas" style="display: none;"></div>';
        
        const templateText = this.template.innerHTML
            .replace("{{{{raw}}}}", "")
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
        const dateTimeFormat = new Intl.DateTimeFormat('nl-BE', { year: 'numeric', month: 'short', day: '2-digit' });
        const template = Handlebars.compile(templateText);
        const body = template({
            data: {
                donationDate: dateTimeFormat.format(new Date(data.donationDate)),
                amount: data.amount,
                currency: this.getCurrencySymbol(data.currency),
                cardHolder: data.cardHolder
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

export { DonationPdf }