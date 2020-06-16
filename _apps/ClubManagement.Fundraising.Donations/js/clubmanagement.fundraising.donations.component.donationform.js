import { appInsights } from "/js/ai.module.js"
import { donationsConfig } from "/js/clubmanagement.fundraising.donations.config.js"
import { club } from "/js/club.config.js"
import { guid } from "/js/clubmanagement.guid.js"

class DonationForm extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("clubmgmt-donation-form-template");
        this.donationsBaseUri = donationsConfig.donationsService + "/api/donations";
        this.paymentsBaseUri = donationsConfig.paymentsService + "/api/payments";
        this.stripe = Stripe(donationsConfig.stripeKey);
    }

    async connectedCallback() {
        this.innerHTML = this.template.innerHTML;

        let amountForm = this.querySelector('#amount-form');
        
        let emailAddress = this.querySelector('#email');
        let emailRow = this.querySelector('#emailRow');
        let emailConformation = this.querySelector('#emailConfirmation');
        emailConformation.addEventListener('change', async (event) => {
           if (event.target.checked === true){
               emailAddress.setAttribute('required', '');
               emailRow.style.display = 'table-row';
           }
           else {
               emailAddress.removeAttribute('required');
               emailAddress.value = '';
               emailRow.style.display = 'none';
           }
        });

        let donate5 = this.querySelector("#donate5");
        let donate10 = this.querySelector("#donate10");
        let donate20 = this.querySelector("#donate20");
        let donation = this.querySelector("#donateOther");
        let cardHolder = this.querySelector('#card-holder');
        
        let updateAndValidateDonation = function(amount){
            donation.value = amount;
            donation.dispatchEvent(new InputEvent('change'));
        };
        
        donate5.addEventListener('click', async (event) =>{
            updateAndValidateDonation(5);
        });
        donate10.addEventListener('click', async (event) =>{
            updateAndValidateDonation(10);
        });
        donate20.addEventListener('click', async (event) =>{
            updateAndValidateDonation(20);
        });

        let amountProvided;
        let cardHolderProvided;
        let showCardInformation = () => {
            if (amountProvided && cardHolderProvided){
                // Show CC form
                const elements = this.stripe.elements();
                this.card = elements.create("card");
                this.card.mount("#card-element");
            }
        };
        
        donation.addEventListener('change', async (event) =>{
            amountProvided = !!event.target.value;

            appInsights.trackEvent({
                name: "DonationFormAmountSelected",
                properties: { eventCategory: "Fundraising.Donations", eventAction: "amount", amount: event.target.value }
            });
            
            showCardInformation();
        });
        cardHolder.addEventListener('change', async (event) =>{
            cardHolderProvided = !!event.target.value;

            appInsights.trackEvent({
                name: "DonationFormCardholderProvided",
                properties: { eventCategory: "Fundraising.Donations", eventAction: "cardholder" }
            });
            
            showCardInformation();
        });

        var donationCommand = {
            amount: donation.value
        };

        amountForm.addEventListener('submit', async (event) => {
            event.preventDefault();
           
            // Prepare donation
            const donationId = guid();
         /*   const prepareDonation = {
                donationId: donationId,
                amount: donation.value,
                currency: "eur"
            };
            const url = `${this.donationsBaseUri}/${donationId}/prepare`;

            const response = await fetch(url, {
                method: 'POST',
                mode: 'cors',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(prepareDonation),
            });*/

            const paymentId = guid();
            const preparePayment = {
                paymentId: paymentId,
                amount: {
                    value: donation.value,
                    currency: "eur"
                },
                payedBy: {
                    id: null,
                    name: cardHolder.value
                },
                beneficiary: {
                    id: club.organizationId,
                    name: club.name
                },
                paymentMethod: "card",
                metadata: {
                    paymentType: "donation",
                    donationId: donationId
                }                
            };
            const url = `${this.paymentsBaseUri}/beneficiaries/${club.organizationId}/${paymentId}/prepare`;

            const response = await fetch(url, {
                method: 'POST',
                mode: 'cors',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(preparePayment),
            });

            const paymentIntent = await response.json();

            const result = await this.stripe.confirmCardPayment(paymentIntent.secret, {
                payment_method: {
                    card: this.card,
                    billing_details: {
                        name: cardHolder.value
                    }
                }
            });

            // Show donation confirmation
            let resultMessage = this.querySelector('#result');
            
            if (result.error){
                resultMessage.innerText = "There was an error. Please try again."
            }
            else
            {
              /*  const url = `${this.donationsBaseUri}/${donationId}/confirm`;
                const registerDonationConfirmed = {
                    donationId: donationId,
                    paymentIntentId: paymentIntent.paymentIntentId,
                    cardHolder: cardHolder.value,
                    sendEmailConfirmation: emailConformation.checked,
                    confirmationEmailAddress: emailAddress.value
                };
                
                const response = await fetch(url, {
                    method: 'PUT',
                    mode: 'cors',
                    cache: 'no-cache',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(registerDonationConfirmed),
                });*/

                const url = `${this.paymentsBaseUri}/beneficiaries/${club.organizationId}/${paymentId}/confirm`;
                const confirmPayment = {
                    paymentId: paymentId
                };
                
                const response = await fetch(url, {
                    method: 'PUT',
                    mode: 'cors',
                    cache: 'no-cache',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(confirmPayment),
                });

                // todo: add "Email confirmation will be sent if the user opted in"
                resultMessage.innerText = "Thank you for your donation!"
                
                if (emailConformation.checked) {
                    resultMessage.append(document.createElement('br'));
                    resultMessage.append("Confirmation will be emailed.");
                }
            }
            
            // testing Stripe CC: 4000002500003155

            appInsights.trackEvent({
                name: "DonationFormSubmitted",
                properties: { eventCategory: "Fundraising.Donations", eventAction: "submit", success:  !result.error}
            });
        });

        const cancel = amountForm.querySelector('#cancel');
        cancel.addEventListener('click', async (event) => {
            event.preventDefault();

            donation.value = 0;
        });

        appInsights.trackEvent({
            name: "DonationFormRendered",
            properties: { eventCategory: "Fundraising.Donations", eventAction: "render" }
        });
    }
}

export { DonationForm }