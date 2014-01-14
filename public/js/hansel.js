define('hansel', 
	
	['ko', 'net'],
	
	function(ko, net){

		var test = function(){
			net.ajax.get({
			  url: 'http://localhost:4567/json/json.html',
			  success: function(req) {
			  	alert(req.response);
			  },
			  error: function(req) {
			    console.log('error bitches');
			  }
			});
		}

	    var SimpleListModel = function(items) {
	        this.items = ko.observableArray(items);
	        this.itemToAdd = ko.observable("");
	        this.addItem = function() {
	        	
	        	test();

	            if (this.itemToAdd() != "") {
	                this.items.push(this.itemToAdd()); // Adds the item. Writing to the "items" observableArray causes any associated UI to update.
	                this.itemToAdd(""); // Clears the text box, because it's bound to the "itemToAdd" observable
	            }
	        }.bind(this);  // Ensure that "this" is always this view model
	    };

	    ko.applyBindings(new SimpleListModel(["Alpha", "Beta", "Gamma"]));
	}
);