
    var Chat = function(model){
    	var self = this;
    	
    	self.socket = null;
    	
        self.connect = function() {
        	var uri = ""
            if (window.location.protocol == 'http:') {
                uri = 'ws://' + window.location.host + ':8000/clocks/commChanel/' + model.viewId;
            } else {
                uri = 'wss://' + window.location.host + ':8443/clocks/commChanel/' + model.viewId;
            }

            if ('WebSocket' in window) {
                self.socket = new WebSocket(uri);
            } else if ('MozWebSocket' in window) {
                self.socket = new MozWebSocket(uri);
            } else {
            	alertify.notify('WebSocket connection opened.','', 3);
                return;
            }

            self.socket.onopen = function () {
            	alertify.notify('WebSocket connection opened.','', 1);
            };

            self.socket.onclose = function () {
            	alertify.notify('WebSocket connection closed.','', 1);
        		// Keeps the connection alive
       			setTimeout(self.connect, 1000);
            };

            self.socket.onmessage = function (evt) {
            	var msg = $.parseJSON(evt.data);
            	if (model.id === model.viewId) {            		
                	model.reload();
            	}
            };
        };
    	
        self.sendMessage = (function(message) {
            if (message != '') {
                self.socket.send(message);
            }
        });
    };
