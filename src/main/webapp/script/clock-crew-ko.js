var Clock = function(name, value) {
	var self = this;
	self.name = ko.observable(name);
	self.level = ko.observable(value);
};

var SprawlCrewVM = function(id, viewId) {
	var self = this;
	self.id = id;
	self.viewId = viewId;
	self.clocks = ko.observableArray([]);	
	
	self.clear = function() {
		sprawl.clocks.removeAll();
	};

	self.load = function(newClocks) {
	 	sprawl.clocks([]);
		$.each(newClocks, function(i, v){
		 	var c = new Clock();
		 	c.name(v.name);
		 	c.level(v.level);
		 	sprawl.clocks.push(c);
		});	
	};
	
	self.reload = function() {
		$.getJSON(
			"loadView.jsp?viewId=" + self.viewId,
			function(data) {
				self.clear();
				$.each(data.data, function(key, val) {
					var name = val.name;
					var level = val.level;
					var c = new Clock(name, level);
					
					self.clocks.push(c);
				});
			}
		);
	};	
};
