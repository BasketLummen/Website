import { appInsights } from "/js/ai.module.js"

class Donate extends HTMLElement {

    constructor(){
        super();

        this.template = document.getElementById("donation-template");
        this.baseUri = "https://clubmgmt-donation-service-test.azurewebsites.net/api/donations";
        this.stripe = Stripe("pk_test_8U57DC7IOjILi4nOIQM3lmVg");
    }

    async connectedCallback() {
        this.innerHTML = this.template.innerHTML;

        let amountForm = this.querySelector('#amount-form');

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
            const prepareDonation = {
                donationId: donationId,
                amount: donation.value,
                currency: "eur"
            };
            const url = `${this.baseUri}/${donationId}/prepare`;

            const response = await fetch(url, {
                method: 'POST',
                mode: 'cors',
                cache: 'no-cache',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(prepareDonation),
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
                const url = `${this.baseUri}/${donationId}/confirm`;
                const registerDonationConfirmed = {
                    donationId: donationId,
                    paymentIntentId: paymentIntent.paymentIntentId,
                    cardHolder: cardHolder.value
                };
                
                const response = await fetch(url, {
                    method: 'PUT',
                    mode: 'cors',
                    cache: 'no-cache',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(registerDonationConfirmed),
                });

                // todo: add "Email confirmation will be sent if the user opted in"
                resultMessage.innerText = "Thank you for your donation!"
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

export { Donate }