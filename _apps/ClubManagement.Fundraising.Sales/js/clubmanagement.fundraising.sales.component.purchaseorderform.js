import { appInsights } from "/js/ai.module.js"
import { salesConfig } from "/js/clubmanagement.fundraising.sales.config.js"
import { club } from "/js/club.config.js"
import { guid } from "/js/clubmanagement.guid.js"

class PurchaseOrderForm extends HTMLElement {

    constructor(){
		super();    
		
		this.template = document.getElementById("clubmgmt-purchase-order-form-template");
		this.saleOpenTemplate = document.getElementById("clubmgmt-purchase-order-sale-open-template");
		this.salePendingTemplate = document.getElementById("clubmgmt-purchase-order-sale-pending-template");
		this.saleOverTemplate = document.getElementById("clubmgmt-purchase-order-sale-over-template");
		this.deliverySlotTemplate = document.getElementById("clubmgmt-purchase-order-delivery-slot-template");
		this.offerTemplate = document.getElementById("clubmgmt-purchase-order-offer-template");
		this.numberInputTemplate = document.getElementById("clubmgmt-purchase-order-offer-input-number-template");
		this.toggleInputTemplate = document.getElementById("clubmgmt-purchase-order-offer-input-toggle-template");
		this.dropdownTemplate = document.getElementById("clubmgmt-purchase-order-offer-input-dropdown-template");
		this.optionLabelTemplate = document.getElementById("clubmgmt-purchase-order-offer-option-label-template");
		this.horizontalContainerTemplate = document.getElementById("clubmgmt-purchase-order-offer-horizontal-container-template");

		this.selectedOptionMemory = [];
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
	
	get orderId() {
		return this.getAttribute('order-id');
  	}

 	set orderId(val) {
		if (val) {
			this.setAttribute('order-id', val);
		} else {
			this.removeAttribute('order-id');
		}
	}  
	
	get total() {
		return this.getAttribute('order-total');
  	}

	set total(val) {
	if (val) {
		this.setAttribute('order-total', val);
	} else {
		this.removeAttribute('order-total');
	}
	}  
	
	get currency() {
		return this.getAttribute('order-currency');
  	}

 	 set currency(val) {
		if (val) {
			this.setAttribute('order-currency', val);
		} else {
			this.removeAttribute('order-currency');
		}
  	}  

    async connectedCallback() { 
        this.sale = await this.loadSale();
		this.collection = await this.loadCollection();

		this.createIndexes();

		await this.registerSequence(); // todo: only zolder needs this, lummen doesn't, perhaps factor out in a strategy?

        await this.render();
    }

    async render(){
		
		var content = this.template.content.cloneNode(true);

		var today = new Date();
		var fromDate = new Date(this.sale.start);
		var saleStarted = fromDate < today;
		var saleIsOver = new Date(this.sale.end) <= today;

		var form = content.querySelector("form");
		var fieldset = content.querySelector("fieldset");

		if(!saleStarted){
			var pendingContent = this.salePendingTemplate.content.cloneNode(true);
			var from = pendingContent.querySelector(".sale-from");
			from.innerText = fromDate.toLocaleDateString("nl-BE", { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
			fieldset.append(pendingContent);
		} else 
		if(saleIsOver){
			fieldset.append(this.saleOverTemplate.content.cloneNode(true));
		}
		else{
			var openContent = this.saleOpenTemplate.content.cloneNode(true);

			this.renderVariants(openContent);	
			this.renderDeliverySlots(openContent);

			fieldset.append(openContent);
		}

		this.append(content);

		form.addEventListener('submit', async (event) => {
			event.preventDefault();

			this.orderId = guid();

			var sequence = await this.claimSequence();

			var cmd = this.composeCommand(sequence);

			this.placeOrder(cmd);
			
			var total = this.computeTotal();
			this.total = total.amount;			
			this.currency = total.currency;

			this.dispatchEvent(new Event('pay'));

			//this.dispatchEvent(new Event('confirm'));
			// this.dispatchEvent(new CustomEvent('error', {
			// 	detail: {
			// 		error: "Oops"
			// 	}
			// }));

		});

        appInsights.trackEvent({
            name: "PurchaseOrderFormRendered",
            properties: { eventCategory: "Fundraising.Sales", eventAction: "render" }
        });
	}

	renderDeliverySlots(content){
		if(this.sale.deliverySlots.length > 0)
        {
			var slots = content.querySelector("#delivery-slots");
            this.sale.deliverySlots.forEach((d, i) => {

                var start = new Date(d.start);
                var end = new Date(d.end);

				var template =  this.deliverySlotTemplate.content.cloneNode(true);

				var slotFrom = template.querySelector(".slot-from");
				slotFrom.innerText =  start.toLocaleTimeString("nl-BE", {hour: '2-digit', minute:'2-digit'});

				var slotTo = template.querySelector(".slot-to");
				slotTo.innerText =  end.toLocaleTimeString("nl-BE", {hour: '2-digit', minute:'2-digit'});

				var input = template.querySelector("input");
				input.setAttribute("id", "delivery_" + i);
				input.setAttribute("value", JSON.stringify(d));
				input.checked = i==0;

				if(i!=0){
					var toclear = template.querySelectorAll(".clear-subsequent");
					toclear.forEach(c => c.innerHTML = '');
				}

				slots.append(template);
            });
        }
	}
	
	renderVariants(content){
		var offers = content.querySelector("#offers");
		
		for (var itemId in this.variantsPerItem) {
			if (this.variantsPerItem.hasOwnProperty(itemId)){
				var variants = this.variantsPerItem[itemId];				
				if(variants.length > 0){
					var itemDescription = this.itemDescriptions[itemId];					
					var template = this.offerTemplate.content.cloneNode(true);

					this.renderOfferLabel(template, variants, itemDescription);
					this.renderOfferInputOrOptionLabels(template, variants, itemDescription);							
					
					offers.append(template);	

					this.renderOptions(content, variants, itemDescription);	
				}
			}
		}		
	}

	renderOptions(content, variants, itemDescription){
		if(!itemDescription || itemDescription.optionSets == null) return;

		var uniqueOptionSets = this.extractUniqueOptionSets(itemDescription);
		
		if(itemDescription.optionSets.length >= 1 && uniqueOptionSets.length == 1){ // all values in the different optionsets are equal
			var toggle = content.querySelector(`[data-itemid="${itemDescription.id}"]`);
			toggle.addEventListener("change", (event) =>{
				this.renderOptionsAsDropDowns(this, itemDescription);
			});
			
		}
	
		if(itemDescription.optionSets.length >= 2 && uniqueOptionSets.length == 2){ // render this as a table
			this.renderOptionsAsTable(content, variants, itemDescription);
		}
	}

	renderOptionsAsDropDowns(content, itemDescription){
		
		var offers = content.querySelector("#offers");
		var toRemove = content.querySelectorAll(".temporary");
		toRemove.forEach(r => r.remove());

		for(var optionSet of itemDescription.optionSets){

			var template = this.offerTemplate.content.cloneNode(true);
			for(var child of template.children){
				child.classList.add("temporary");
			}
			this.renderOptionLabel(template, null, optionSet.name);
			this.renderSelect(template, itemDescription.id, optionSet);
			
			offers.append(template);
		}

	}

	renderSelect(template, itemId, optionSet){
		var inputHolder = template.querySelector(".input-holder");
		var dropdownTemplate = this.dropdownTemplate.content.cloneNode(true);
		var select = dropdownTemplate.querySelector("select");
		select.setAttribute("data-itemid", itemId);
		select.setAttribute("data-optionsetid",  optionSet.id);
		select.innerHTML = "";
		for(var option of optionSet.options){
			var opt = document.createElement("option");
			opt.value = option.id;
			opt.innerText = option.name;
			select.append(opt);
		}
		var previouslySelected = this.selectedOptionMemory.hasOwnProperty(optionSet.name);
		if(previouslySelected){
			select.value = this.selectedOptionMemory[optionSet.name];
		}
		select.addEventListener("change", (event) =>{
			this.selectedOptionMemory[optionSet.name] = select.value;
		});
		inputHolder.append(dropdownTemplate);
	}

	renderOptionsAsTable(content, variants, itemDescription){
		var offers = content.querySelector("#offers");
		var uniqueOptionSets = this.extractUniqueOptionSets(itemDescription);

		var xAxis = this.findOptionSetWithSmallestTotalLabelLength(uniqueOptionSets);
		var yAxis = this.findOptionSetWithHighestTotalLabelLength(uniqueOptionSets);		

		for(var option of yAxis.optionSet.options.slice()){

			var variant = variants.filter(o => o.variantLimits[0].matchingValues.includes(option.id))[0]

			var template = this.offerTemplate.content.cloneNode(true);
			this.renderOptionLabel(template, variant, option.name);

			var inputHolder = template.querySelector(".input-holder");
			inputHolder.innerHTML = '';

			var containerTemplate = this.horizontalContainerTemplate.content.cloneNode(true);
			var container = containerTemplate.querySelector(".horizontal-container");

			var count = xAxis.optionSet.options.length;
			var width = "calc(" + (400 / count) + "px - " +  ((0.2 * count) - (0.4 / count)) + "em)";

			for (var opt of xAxis.optionSet.options){
				
				this.renderInputField(container, variant,  [{
					optionSetId: yAxis.optionSet.id,
					option: option
				}, {
					optionSetId: xAxis.optionSet.id,
					option: opt
				}]);

				var inputs = container.querySelectorAll("input");
				inputs.forEach(input => {
					// fix the fact that inputs do not respect flex
					input.style.width = width; 
					input.style.minWidth = width; 
				});
				
			}

			inputHolder.append(containerTemplate);
			offers.append(template);
		}
	}

	renderOfferLabel(template, variants, itemDescription){
		var label = template.querySelector("label");
		if(variants.length == 1){
			var variant = variants[0];
			label.innerText = itemDescription.name + (variant.price.value > 0 ? " " + variant.price.currency + variant.price.value : "");
		}
		else{
			label.innerText = itemDescription.name;
		}
	}

	renderOptionLabel(template, variant, name){
		var labelHolder = template.querySelector(".label-holder");
		var labelTemplate = this.optionLabelTemplate.content.cloneNode(true);
		var label = labelTemplate.querySelector(".option-label");
		label.innerText = name + (variant != null  && variant.price.value > 0 ? " " + variant.price.currency + variant.price.value : "");
		labelHolder.append(label);
	}

	renderOfferInputOrOptionLabels(template, variants, itemDescription){
		if(variants.length == 1){ // single variant, render the input field
			var variant = variants[0];
			var inputHolder = template.querySelector(".input-holder");
			inputHolder.innerHTML = '';
			this.renderInputField(inputHolder, variant);
		}
		else{
			this.renderHorizontalOptionLabels(template, variants, itemDescription);
		}
	}

	renderInputField(inputHolder, variant, matchingOptions){	

		var inputTemplate = this.numberInputTemplate.content.cloneNode(true);
		var input = inputTemplate.querySelector("input");
		var id = guid();
		input.setAttribute("id", id);
		input.setAttribute("data-itemid", variant.id);

		if(matchingOptions){
			for(var matchingOption of matchingOptions){
				input.setAttribute("data-variant-" + matchingOption.optionSetId, matchingOption.option.id);
			}
		}

		if(variant.orderLimit != null){
			var min = variant.orderLimit.minimumQuantity != null ? variant.orderLimit.minimumQuantity : 0;
			var max = variant.orderLimit.maximumQuantity != null ? variant.orderLimit.maximumQuantity : Number.MAX_SAFE_INTEGER; 
		
			input.setAttribute("min", min);
			input.setAttribute("max", max);

			var useToggle = !(variant.orderLimit.maximumQuantity > 1 || variant.orderLimit.maximumQuantity == null);
			if(useToggle){
				input.style.display= "none";
				var toggleTemplate = this.toggleInputTemplate.content.cloneNode(true);
				var toggle = toggleTemplate.querySelector("input");
				toggle.setAttribute("type", this.sale.choice == "Multiple" ? 'checkbox' : 'radio');
				toggle.setAttribute("name", this.sale.choice == "Multiple" ? "toggle-" + variant.id : "toggle")
				toggle.setAttribute("data-target-itemid", variant.id)
				toggle.addEventListener("change", (event) => {
					var otherCheckboxes = this.querySelectorAll(`input[name='${event.target.name}']`);
					otherCheckboxes.forEach(c =>{
						var targetId = c.getAttribute("data-target-itemid");
						var toReset =  this.querySelector(`input[data-itemid='${targetId}']`);
						toReset.value = min;
					});

					if(event.target.checked){
						input.value = max;						
					}
					input.dispatchEvent(new Event('change'));
				} );

				inputHolder.append(toggleTemplate);
			}	
		}

		input.addEventListener("change", (event) => {
			var total = this.computeTotal();
			this.querySelector('#price').innerText = total.currency + " " + total.amount;
		});
		
		inputHolder.append(inputTemplate);
	}

	computeTotal(){
		var sum = 0;
		var currency = "€";
		var inputs = this.querySelectorAll("input[data-itemid]");
		inputs.forEach(input => {
	
			var quantity = input.value;
			if(quantity == null || quantity.length == 0) quantity = 0;
			if(quantity == 0) return;
			
			var itemId = input.getAttribute("data-itemid");
	
			var matchingOptions = this.determineMatchingOptions(input);		
			
			var variant = this.determineVariant(itemId, matchingOptions);
			
			if(variant) {
				currency = variant.price.currency;
				sum += quantity * variant.price.value;
			}
		});
	
		return {
			currency: currency,
			amount: sum
		};
	};

	determineMatchingOptions(input){
		var options = [];
		var attributes = this.getAttributes(input);
		
		for (var key in attributes) {
			if (attributes.hasOwnProperty(key)){
				if(key.startsWith("data-variant-")){
					options.push({
						id: key.replace("data-variant-", ""),
						value: attributes[key]
					});
				}
			}
		}
			
		return options;		
	}

	getAttributes ( node ) {
		var i,
			attributeNodes = node.attributes,
			length = attributeNodes.length,
			attrs = {};

		for ( i = 0; i < length; i++ ) attrs[attributeNodes[i].name] = attributeNodes[i].value;
		return attrs;
	}

	determineVariant(itemId, matchingOptions){
		if(this.variantsPerItem.hasOwnProperty(itemId)){
			var potentialVariants = this.variantsPerItem[itemId];
			if(potentialVariants.length == 1) return potentialVariants[0];		
	
			if(matchingOptions && matchingOptions.length > 0){
				for(var matchingOption of matchingOptions){
					return potentialVariants.filter(o => o.variantLimits[0].optionSetId == matchingOption.id && o.variantLimits[0].matchingValues.includes(matchingOption.value))[0]
				}
			}        
		}
		return null;
	}

	renderHorizontalOptionLabels(template, variants, itemDescription){		
		var inputHolder = template.querySelector(".input-holder");
		inputHolder.innerHTML = '';

		var uniqueOptionSets = this.extractUniqueOptionSets(itemDescription);

		if(uniqueOptionSets.length > 1){
			var toRender = this.findOptionSetWithSmallestTotalLabelLength(uniqueOptionSets) 

			var containerTemplate = this.horizontalContainerTemplate.content.cloneNode(true);
			var container = containerTemplate.querySelector(".horizontal-container");

			var count = toRender.optionSet.options.length;
			var width = "calc(" + (400 / count) + "px - " +  ((0.2 * count) - (0.4 / count)) + "em)";


			for(var option of toRender.optionSet.options){
				
				var variant = variants.filter(o => o.variantLimits[0].matchingValues.includes(option.id))[0]
				var labelTemplate = this.optionLabelTemplate.content.cloneNode(true);
				var label = labelTemplate.querySelector(".option-label");
				label.innerText = option.name + ((variant != null && variant.price.value > 0) ? " " + variant.price.currency + variant.price.value : "");
				label.style.width = width;
				label.style.minWidth = width;
				container.append(labelTemplate);
			}

			inputHolder.append(containerTemplate);
		}
	}	

	extractUniqueOptionSets(itemDescription){
		var filtered = [];
	
		for(var optionSet of itemDescription.optionSets){	
				
			var found = false;
	
			for(var toCompare of filtered){
				found = this.compare(toCompare.options, optionSet.options, "id");
				if(found) break;
			}
	
			if(!found){
				filtered.push(optionSet);
			}
	
		}
	
		return filtered;
	}

	findOptionSetWithSmallestTotalLabelLength(optionSets){
		var potential = this.computeTotalLabelLengthPerOptionSet(optionSets);
		var lowest = potential[0];
		var mayBeLower;
		for (var i=potential.length-1; i>=0; i--) {
			mayBeLower = potential[i];
			if (mayBeLower.length < lowest.length) lowest = mayBeLower;
		}
		return lowest;
	}

	findOptionSetWithHighestTotalLabelLength(optionSets){
		var potential = this.computeTotalLabelLengthPerOptionSet(optionSets);
		var highest = potential[0];
		var mayBeHigher;
		for (var i=potential.length-1; i>=0; i--) {
			mayBeHigher = potential[i];
			if (mayBeHigher.length > highest.length) highest = mayBeHigher;
		}
		return highest;
	}

	computeTotalLabelLengthPerOptionSet(optionSets){
		var results = [];
	
		for(var optionSet of optionSets){
			var length = 0;
			for(var option of optionSet.options){			
				length += option.name.length;	
			}		
			results.push({
				length: length,
				optionSet: optionSet
			});
		}
	
		return results;
	}

	compare(array1, array2, prop) {
		if (array1.length != array2.length) {
		  return false;
		}
	  
		array1 = array1.slice();
		array1.sort();
		array2 = array2.slice();
		array2.sort();
	  
		for (var i = 0; i < array1.length; i++) {
		  if (array1[i][prop] != array2[i][prop]) {
			return false;
		  }
		}
	  
		return true;
	}


    async loadSale(){
        var uri = `${salesConfig.salesService}/api/sales/${club.organizationId}/${this.saleId}`;
        var request = await fetch(uri, {
            method: "GET",
            mode: 'cors',
            headers: {
              "Content-Type": "application/json"
            }        
        });
        return await request.json();
    }

    async loadCollection(){
      if(this.sale && this.sale.items){
        var item = this.sale.items[0]; // assume all items from same catalog & collection for now

        var uri = `${salesConfig.catalogService}/api/catalogs/${club.organizationId}/${item.catalogId}/collections/${item.collectionId}`;
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

    async registerSequence(){
      if(this.sale && this.sale.items){
        var uri = `${salesConfig.sequenceService}/api/sequences/${this.sale.id}`;

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
	
	async claimSequence(){
		if(this.sale && this.sale.items){
		  var uri = `${salesConfig.sequenceService}/api/sequences/${this.sale.id}/claim`;
  
		  var request = await fetch(uri, {
			  method: "POST",
			  mode: 'cors',
			  headers: {
				"Content-Type": "application/json"
			  }
		  });
		  return await request.json();
		}
		return null;
	}

	async placeOrder(cmd){
		if(this.sale && this.sale.items){
		  var uri = `${salesConfig.bookingService}/api/orderbookings/${club.organizationId}/${this.sale.id}`;
  
		  await fetch(uri, {
			  method: "POST",
			  mode: 'cors',
			  headers: {
				"Content-Type": "application/json"
			  },
			  body:  JSON.stringify(cmd)
		  });
		}
	}

    createIndexes(){
		var variantsPerItem = {};
		var itemDescriptions = [];

		for (var key in this.sale.items) {
			if (this.sale.items.hasOwnProperty(key)){
				var item = this.sale.items[key];
				var itemDescription = this.collection.items.filter(function(i){ return i.id == item.id})[0];
				itemDescriptions[item.id] = itemDescription;
				
				if (!variantsPerItem.hasOwnProperty(item.id)){
					variantsPerItem[item.id] = []
				}
				variantsPerItem[item.id].push(item);               
			}
		}
		this.variantsPerItem = variantsPerItem;
		this.itemDescriptions= itemDescriptions;
	}   
	
	composeCommand(sequence){

		var name = this.querySelector('#family-name').value;
		var firstname = this.querySelector('#given-name').value;
		var optionalEmailInput = this.querySelector('#email');
		var email = optionalEmailInput != null ? optionalEmailInput.value : null;                
		var optionalTelephoneInput = this.querySelector('#telephone');
		var telephone = optionalTelephoneInput != null ? optionalTelephoneInput.value : null;
		var optionalAddressInput = this.querySelector('#address');
		var address = optionalAddressInput != null ?  optionalAddressInput.value: null;
		var statusUpdatesRequested = this.querySelector('#sendConfirmation').checked;

		var buyer = {
			name : firstname + " " + name,
			email : email,
			telephone : telephone,
			address : address
		}

		var orderLines = this.composeOrderLines();

		var expectedDeliveryDateRangeInput = this.querySelector("input[name=delivery]:checked");
		var expectedDeliveryDateRangeJson = expectedDeliveryDateRangeInput != null ? expectedDeliveryDateRangeInput.value : null;
		var expectedDeliveryDateRange = expectedDeliveryDateRangeJson != null ? JSON.parse(expectedDeliveryDateRangeJson) : null;

		var cmd = {
			orderId: this.orderId, 
			saleId: this.sale.id,
			sellerId: club.organizationId,
			buyer: buyer,
			orderLines: orderLines,
			statusUpdateRequested: statusUpdatesRequested,
			deliveryExpectations: expectedDeliveryDateRange != null ? {
				expectedDeliveryDateRange: {
					start: expectedDeliveryDateRange.start,
					end: expectedDeliveryDateRange.end
				}
			} : null,
			referenceNumber: sequence
		};

		return cmd
	}

	composeOrderLines(){
		var orderLines = [];

		var inputs = this.querySelectorAll("input[data-itemid]");
		inputs.forEach(input => {
	
			var quantity = input.value;
			if(quantity == null || quantity.length == 0) quantity = 0;
			if(quantity == 0) return;
			
			var itemId = input.getAttribute("data-itemid");
	
			var matchingOptions = this.determineMatchingOptions(input);		
			
			var variant = this.determineVariant(itemId, matchingOptions);
			
			if(variant) {
				
				var description = this.itemDescriptions[variant.id];

				var selectedOptions = null;
				if(matchingOptions && matchingOptions.length > 0){
					selectedOptions = [];
					matchingOptions.forEach(function(option){
						var optionSet = description.optionSets.filter(s => s.id == option.id)[0];                               
						selectedOptions.push({
							id: optionSet.id,
							name: optionSet.name,
							value: option.value
						});
					});
				}

				orderLines.push({
					id: guid(), 
					orderedItem: {
						id: variant.id,
						catalogId: variant.catalogId,
						collectionId: variant.collectionId,
						name: description.name,
						price: {
							currency: variant.price.currency,
							value: variant.price.value
						},
						selectedOptions : selectedOptions
					},
					quantity: quantity                               
				});

			}
		});

		orderLines.forEach(orderLine =>{
			if(orderLine.orderedItem.selectedOptions == null){
				var selectedOptions = [];
				var itemDescription = this.itemDescriptions[orderLine.orderedItem.id];
				if(itemDescription.optionSets !== "undefined" && itemDescription.optionSets !== null){
					itemDescription.optionSets.forEach(optionSet => {
						var selectedInput = this.querySelector('[data-itemid="' + orderLine.orderedItem.id + '"][data-optionsetid="' + optionSet.id + '"]');
						if(selectedInput){
							var selected = selectedInput.value;
							var val = optionSet.options.filter(v => { return v.id == selected })[0];
							selectedOptions.push({
								id: optionSet.id,
								name: optionSet.name,
								value: val.id
							});
						}						
					});
					orderLine.orderedItem.selectedOptions = selectedOptions;
				} 
			}                                      
		});

		return orderLines;
	}
}

export { PurchaseOrderForm }