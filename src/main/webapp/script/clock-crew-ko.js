var Clock = function(name, value) {
	var self = this;
	self.name = ko.observable(name);
	self.level = ko.observable(value);
};

var SprawlCrewVM = function(id, viewId, name) {
	var self = this;
	self.id = id;
	self.viewId = viewId;
	self.name = ko.observable(name);
	self.clocks = ko.observableArray([]);	
	
	self.name.subscribe(function(newValue){ 
		document.title = self.name() 
	});
	
	self.clear = function() {
		sprawl.clocks.removeAll();
	};

	self.load = function(newClocks) {
		sprawl.name(newClocks.name);
	 	sprawl.clocks([]);
		$.each(newClocks.clocks, function(i, v){
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
				self.name (data.data.name);
				$.each(data.data.clocks, function(key, val) {
					var name = val.name;
					var level = val.level;
					var c = new Clock(name, level);
					self.clocks.push(c);
				});
			}
		);
	};	
};
