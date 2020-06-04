import { appInsights } from "/js/ai.module.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { club } from "/js/club.config.js"

class PurchaseOrderForm extends HTMLElement {

    constructor(){
		super();    
		
		this.template = document.getElementById("clubmgmt-purchase-order-form-template");
		this.saleOpenTemplate = document.getElementById("clubmgmt-purchase-order-sale-open-template");
		this.salePendingTemplate = document.getElementById("clubmgmt-purchase-order-sale-pending-template");
		this.saleOverTemplate = document.getElementById("clubmgmt-purchase-order-sale-over-template");
		this.deliverySlotTemplate = document.getElementById("clubmgmt-purchase-order-delivery-slot-template");
		this.offerTemplate = document.getElementById("clubmgmt-purchase-order-offer-template");
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
        var sale = await this.loadSale();
		var collection = await this.loadCollection(sale);
		var indexes = this.createIndexes(sale, collection);

		await this.registerSequence(sale); // todo: only zolder needs this, lummen doesn't, perhaps factor out in a strategy?

        await this.render(sale, collection, indexes.offersPerItem, indexes.itemDescriptions);
    }

    async render(sale, collection, offersPerItem, itemDescriptions){
		
		var content = this.template.content.cloneNode(true);

		var today = new Date();
		var fromDate = new Date(sale.start);
		var saleStarted = fromDate < today;
		var saleIsOver = new Date(sale.end) <= today;

		var fieldset = content.querySelector("fieldset");

		if(!saleStarted){
			var pendingContent = this.salePendingTemplate.content.cloneNode(true);
			var label = pendingContent.querySelector("label");
			label.innerText += fromDate.toLocaleDateString("nl-BE", { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
			fieldset.append(pendingContent);
		} else 
		if(saleIsOver){
			fieldset.append(this.saleOverTemplate.content.cloneNode(true));
		}
		else{
			var openContent = this.saleOpenTemplate.content.cloneNode(true);

			this.renderOffers(openContent, offersPerItem);	
			this.renderDeliverySlots(openContent, sale);

			fieldset.append(openContent);
		}

		this.append(content);

        appInsights.trackEvent({
            name: "PurchaseOrderFormRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
	}

	renderDeliverySlots(content, sale){
		if(sale.deliverySlots.length > 0)
        {
			var slots = content.querySelector("#delivery-slots");
            sale.deliverySlots.forEach((d, i) => {

                var start = new Date(d.start);
                var end = new Date(d.end);

				var tr =  this.deliverySlotTemplate.content.cloneNode(true);

				var slotFrom = tr.querySelector(".slot-from");
				slotFrom.innerText =  start.toLocaleTimeString("nl-BE", {hour: '2-digit', minute:'2-digit'});

				var slotTo = tr.querySelector(".slot-to");
				slotTo.innerText =  end.toLocaleTimeString("nl-BE", {hour: '2-digit', minute:'2-digit'});

				var input = tr.querySelector("input");
				input.setAttribute("id", "delivery_" + i);
				input.setAttribute("value", JSON.stringify(d));
				input.checked = i==0;

				if(i!=0){
					var toclear = tr.querySelectorAll(".clear-subsequent");
					toclear.forEach(c => c.innerHTML = '');
				}

				slots.append(tr);
            });
        }
	}
	
	renderOffers(content, offersPerItem, itemDescriptions){
		var offers = content.querySelector("#offers");
		
		for (var itemId in offersPerItem) {
			if (offersPerItem.hasOwnProperty(itemId)){				
				if(offersPerItem[itemId].length > 0){
					
					var tr = this.offerTemplate.content.cloneNode(true);
				/*	shouldShowTotal = shouldShowTotal && offersPerItem[itemId].filter(o => (o.price.value > 0)).length > 0;
					var itemDescription = itemDescriptions[itemId];
					
					var tr =  $('<tr>');
					var td1 =  $('<td>');
					var td2 =  $('<td>');
	 
					renderItemLabel(td1, offersPerItem[itemId], itemDescription);
					var targetId = renderOfferOrOptionLabels(td2, offersPerItem[itemId], itemDescription, rules, messages);
					
					tr.append(td1);
					tr.append(td2);
					table.append(tr);
	
					renderOptions(tr, targetId, offersPerItem[itemId], itemDescription, rules, messages);*/
					
					offers.append(tr);	
				}
			}
		}

		offers.append(tr);
	}

    async loadSale(){
        var uri = salesConfig.salesService + "/api/sales/" + club.organizationId + "/" + this.saleId + "/";
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            }        
        });
        return await request.json();
    }

    async loadCollection(sale){
      if(sale && sale.items){
        var item = sale.items[0]; // assume all items from same catalog & collection for now

        var uri = salesConfig.catalogService + "/api/catalogs/" + club.organizationId + "/" + item.catalogId + "/collections/" + item.collectionId;
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            }        
        });
        return await request.json();
      }
      return null;
    }   

    async registerSequence(sale){
      if(sale && sale.items){
        var uri = salesConfig.sequenceService + "/api/sequences/" + sale.id;

        var defineSequence = {
          initialOffset: 700,
          rangeSize: 10
      	}

        await fetch(uri, {
            method: "POST",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            },
            body:  JSON.stringify(defineSequence)
        });
      }
      return null;
    }

    createIndexes(sale, collection){
		var offersPerItem = {};
		var itemDescriptions = [];

		for (var key in sale.items) {
			if (sale.items.hasOwnProperty(key)){
				var item = sale.items[key];
				var itemDescription = collection.items.filter(function(i){ return i.id == item.id})[0];
				itemDescriptions[item.id] = itemDescription;
				
				if (!offersPerItem.hasOwnProperty(item.id)){
					offersPerItem[item.id] = []
				}
				offersPerItem[item.id].push(item);               
			}
		}
		return{
			offersPerItem: offersPerItem,
			itemDescriptions: itemDescriptions
		};
    }   
}

export { PurchaseOrderForm }