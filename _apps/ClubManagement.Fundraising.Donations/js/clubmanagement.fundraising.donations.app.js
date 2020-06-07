import { DonationForm } from "/js/clubmanagement.fundraising.donations.component.donationform.js"
import { DonationPdf } from "/js/clubmanagement.fundraising.donations.component.pdf.js"

(function() {
    // your page initialization code here
    customElements.define('clubmgmt-donation-form', DonationForm);
    customElements.define('clubmgmt-donation-pdf', DonationPdf);
 })();