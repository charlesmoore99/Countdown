var Clock = function(name, value) {
	var self = this;
	self.name = ko.observable(name);
	self.level = ko.observable(value);
};

var SprawlVM = function(id, viewId) {
	var self = this;
	self.id = id;
	self.viewId = viewId
	self.clocks = ko.observableArray([]);

	self.add = function() {
		alertify.prompt(
			'Add a Countdown Clock',
			'Name',
			'Clock X',
			function(evt, value) {
				// Check to see if clock already exists
				var result = $.grep(sprawl.clocks(), function(e) {
					return e.name() === value;
				});
				if (result.length == 0) {
					// not found
					var c = new Clock(value, 0);
					sprawl.clocks.push(c);
					self.save();
				} else {
					alertify.error('A clock by that name already exists. Countdowm Clock Creation canceled','', 4)
				}
			}, function() {
				alertify.notify('Countdown Clock creation canceled', '', 2)
			}
		);
	};

	self.removeByName = function(c) {
		sprawl.clocks.remove(function(item) {
			return item.name() === c.name();
		});
		self.save();
	};

	self.clear = function() {
		alertify.confirm(
   				'Please Confim:',
   				'Delete ALL Clocks?', 
   				function(evt, value) { 
   					sprawl.clocks.removeAll();
   					self.save();
   				}, function() { 
   					alertify.notify('Delete cancled','',2) 
   				}
   			);	
	};

	self.save = function() {
	    $("#loading").removeClass('hide');     
		$.post("save.jsp", "data=" + ko.toJSON(self), function() {
		}).always(function() {
			alertify.notify('Sync\'d', '', .75);
			websocket.sendMessage(ko.toJSON(self.clocks));
		    $("#loading").addClass('hide');
		})
	};

	self.reload = function() {
	    $("#loading").removeClass('hide');     
		$.getJSON("load.jsp", function(data) {
			self.clear();
			$.each(data, function(key, val) {
				var n = data.name;
				var v = data.level;
				var c = new Clock(name, level);
				self.clocks.push(c);
			    $("#loading").addClass('hide');
			});
		});
	};
};
