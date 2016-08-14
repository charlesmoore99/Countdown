
var Clock = function(name, value) {
	var self = this;
	self.name = ko.observable(name);
	self.level = ko.observable(value);
};

var ViewData = function(name, clocks){
	var self = this;
	self.name = name;
	self.clocks =  clocks;
;}

var SprawlVM = function(id, viewId, name) {
	var self = this;
	self.NUM_PER_PAGE = 4;
	self.id = id;
	self.viewId = viewId
	self.name = ko.observable(name);
	self.page = ko.observable(0);
	self.clocks = ko.observableArray([]);

	self.name.subscribe(function(newValue){ 
		document.title = self.name() 
	});
	
	self.clocksToShow = ko.pureComputed(function() {
		var start = self.page() * self.NUM_PER_PAGE;
		var end = start + self.NUM_PER_PAGE;
		return self.clocks().slice(start, end)
	}, this);

	self.showClock = function(elem) {
		if (elem.nodeType === 1) {
			$(elem).hide().fadeIn()
		}
	};

	self.hideClock = function(elem) {
		if (elem.nodeType === 1) {
			// $(elem).fadeOut(10, function() { $(elem).remove(); })
			$(elem).remove();
		}
	};

	self.setName = function() {
		alertify.prompt( 'Set Campaign Name (limit 60 chars)', 'Name', self.name(),
			function(evt, value) {
				// truncate to 60 chars							
				self.name(truncate(value, 60, false));
				self.save();
			}, function() {
				//noop
			}
		);
	};


	
	self.add = function() {
		alertify.prompt( 'Add a Countdown Clock (limit 30 chars)', 'Name', 'Clock X',
			function(evt, value) {
				var val = truncate(value, 30, false);

				// Check to see if clock already exists
				var result = $.grep(sprawl.clocks(), function(e) {
					return e.name() === val;
				});
				if (result.length == 0) {
					// not found
					var c = new Clock(val, 0);
					sprawl.clocks.push(c);
					self.save();
				} else {
					alertify.error('A clock by that name already exists. Countdowm Clock Creation canceled','', 4)
				}
			}, function() {
				alertify.notify(
						'Countdown Clock creation canceled', '', 2)
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
		alertify.confirm('Please Confim:', 'Delete ALL Clocks?', function(evt,
				value) {
			sprawl.clocks.removeAll();
			self.save();
		}, function() {
			alertify.notify('Delete cancled', '', 2)
		});
	};

	self.load = function() {
		var clockString = self.dataStore.load();
		var clocks = $.parseJSON(clockString);
		$.each(clocks, function(i, v) {
			var c = new Clock();
			c.name(v.name);
			c.level(v.level);
			sprawl.clocks().push(c);
		});
	};

	self.save = function() {
		$("#loading").removeClass('hide');
		$.post("save.jsp", "data=" + ko.toJSON(self), function() {
		}).always(function() {
			alertify.notify('Sync\'d', '', .75);
			var clockStruct = new ViewData(self.name, self.clocks);
			var clockString =  ko.toJSON(clockStruct);
			websocket.sendMessage(clockString);
			sendMessage(clockString);
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