var Clock = function(name, value) {
    var self = this;
    self.name = ko.observable(name);
    self.level = ko.observable(value);
};

var SprawlVM = function(id, dataStore) {
    var self = this;
    self.NUM_PER_PAGE = 4;
    self.id = id;
    self.name = ko.observable("");

    self.page = ko.observable(0);
    self.dataStore = dataStore;

    self.clocks = ko.observableArray([]);

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
			},
			function() {
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
        var clockString = ko.toJSON(self.clocks)
        self.dataStore.save(clockString);
        sendMessage(clockString);
        $("#loading").addClass('hide');
    };

    self.reload = function() {
        $("#loading").removeClass('hide');
        $("#loading").addClass('hide');
    };
};