import { Donate } from "/js/donations.component.donate.js"
import { DonationConfirmation } from "/js/donations.component.confirmation.js"

(function() {
    // your page initialization code here
    customElements.define('donate-form', Donate);
    customElements.define('donation-confirmation', DonationConfirmation);
 })();