

var Storage = function(key) {
	
	var self = this;
	self.key = key;
	
	self.supports_html5_storage = function () {
		try {
			return 'localStorage' in window && window['localStorage'] !== null;
		} catch (e) {
			return false;
		}
	};

	self.save = function(data) {
		if (self.supports_html5_storage()) {
			localStorage[self.key] = data;
		}
	};
	
	self.load = function() {
		var value = localStorage[self.key];
		if ($.isEmptyObject(value)) {
			return "[]";
		} else {
			return value;
		}		
	};
};
