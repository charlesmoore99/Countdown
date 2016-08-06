ko.components.register('mc-clock-widget', {
	viewModel: function(params) {
		var self = this;
		self.sprawl = params.sprawl;
        self.name = params.name;
        self.value = params.value;

    	self.color = function(v){
    		switch (v) {
    		case 1:
    			return "#FFBF00";
    		case 2:
    			return "#F0A400";
    		case 3:
    			return "#E18B00";
    		case 4:
    			return "#CA5900";
    		case 5:
    			return "#BA2B00";
    		case 6:
    			return "#B40000";
    		default :
    			return "black";
    		}
    	};
    	
    	self.color1 = ko.pureComputed(function(){
    		return self.color(self.value());
    	});
    	
    	self.color2 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 2: 
    		case 3: 
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	
    	self.color3 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 3: 
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color4 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color5 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color6 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	
        // make buttons clickey
    	$( "button.button" )
    	  .mousedown(function() {
    		    $( this ).addClass( "pressed" );
    	  });	

    	$( "button.button" )
    	  .mouseup(function() {
    		    $( this ).removeClass( "pressed" );
    	  })
    	  
        // Behaviors
        this.advance = function() {
	        if (this.value() < 6) {
	        	this.value(this.value() + 1); 
	        	self.sprawl.save();
	        }
        }.bind(this);
        
        this.decrease = function() {
        	if  (this.value() > 0) { 
        		this.value(this.value() - 1);
        		self.sprawl.save();
        	} 
        	
        }.bind(this);
        
        this.remove = function(name) {
    		alertify.confirm(
   				'Please Confim:',
   				'Delete Clock?', 
   				function(evt, value) { 
   					self.sprawl.removeByName(name);
   					alertify.notify('Deleted Clock...','',2)
   				}, function() { 
   					alertify.notify('Delete cancled','',2) 
   				}
   			);			
        }.bind(this);
    },
    template: `
<div class="full-clock">
	<div style="position: relative; width:100%; height: 14em;;">
		<button style="position: absolute; left:23px;  top:10px; z-index:2"    id="one"   class="button" data-bind="click: decrease">&#8630;</button>
		<button style="position: absolute; left:170px; top:10px; z-index:2;"  id="two"  class="button" data-bind="click: advance">&#8631;</button>				
		<svg style="position: absolute; left:28px; top:10px; z-index:1;" width="200px" height="200px" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 130 130">
		  <text id="three" x="112px" y="65px" class="dial">3</text>
		  <text id="six" x="57" y="120" class="dial">6</text>
		  <text id="nine" x="2" y="65" class="dial"> 9</text>
		  <text id="twelve" x="55" y="8" class="dial">12</text>
		  <path data-bind="attr: { fill : color1 }" stroke="white" stroke-width="1" d="M 110.00 60.00 A 50 50 0 0 0 60.00 10.00 L 60 60 L 110.00 60.00"/>
		  <path data-bind="attr: { fill : color2 }" stroke="white" stroke-width="1" d="M 60.00 110.00 A 50 50 0 0 0 110.00 60.00 L 60 60 L 60.00 110.00"/>
		  <path data-bind="attr: { fill : color3 }" stroke="white" stroke-width="1" d="M 10.00 60.00 A 50 50 0 0 0 60.00 110.00 L 60 60 L 10.00 60.00"/>
		  <path data-bind="attr: { fill : color4 }" stroke="white" stroke-width="1" d="M 16.70 35.00 A 50 50 0 0 0 10.00 60.00 L 60 60 L 16.70 35.00"/>
		  <path data-bind="attr: { fill : color5 }" stroke="white" stroke-width="1" d="M 35.00 16.70 A 50 50 0 0 0 16.70 35.00 L 60 60 L 35.00 16.70"/>
		  <path data-bind="attr: { fill : color6 }" stroke="white" stroke-width="1" d="M 60.00 10.00 A 50 50 0 0 0 35.00 16.70 L 60 60 L 60.00 10.00"/>
		  <circle id="hub" fill="white" r="3" cx="60" cy="60" />
		</svg>
	</div>
	<div style="position:relative; width: 100%;">
		<button class="button"  data-bind="click: remove, params=n : name">-</button>
		<span class="mc-clock-name" data-bind="text: name"></span>
	</div>
</div>    
    `
	});

ko.components.register('crew-clock-widget', {
	viewModel: function(params) {
		var self = this;
        self.name = params.name;
        self.value = params.value;

    	self.color = function(v){
    		switch (v) {
    		case 1:
    			return "#FFBF00";
    		case 2:
    			return "#F0A400";
    		case 3:
    			return "#E18B00";
    		case 4:
    			return "#CA5900";
    		case 5:
    			return "#BA2B00";
    		case 6:
    			return "#B40000";
    		default :
    			return "black";
    		}
    	};
    	
    	self.color1 = ko.pureComputed(function(){
    		return self.color(self.value());
    	});
    	
    	self.color2 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 2: 
    		case 3: 
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	
    	self.color3 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 3: 
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color4 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 4: 
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color5 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 5: 
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	self.color6 = ko.pureComputed(function(){
    		switch(self.value()) {
    		case 6: 
    			return self.color(self.value()); 
    		default : return "black";
    		}
    	});
    	
},
    template: `
<div class="full-clock">
	<div style="position: relative; width:100%; height: 14em;;">
		<svg style="position: absolute; left:28px; top:10px; z-index:1;" width="200px" height="200px" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 130 130">
		  <text id="three" x="112px" y="65px" class="dial">3</text>
		  <text id="six" x="57" y="120" class="dial">6</text>
		  <text id="nine" x="2" y="65" class="dial"> 9</text>
		  <text id="twelve" x="55" y="8" class="dial">12</text>
		  <path data-bind="attr: { fill : color1 }" stroke="white" stroke-width="1" d="M 110.00 60.00 A 50 50 0 0 0 60.00 10.00 L 60 60 L 110.00 60.00"/>
		  <path data-bind="attr: { fill : color2 }" stroke="white" stroke-width="1" d="M 60.00 110.00 A 50 50 0 0 0 110.00 60.00 L 60 60 L 60.00 110.00"/>
		  <path data-bind="attr: { fill : color3 }" stroke="white" stroke-width="1" d="M 10.00 60.00 A 50 50 0 0 0 60.00 110.00 L 60 60 L 10.00 60.00"/>
		  <path data-bind="attr: { fill : color4 }" stroke="white" stroke-width="1" d="M 16.70 35.00 A 50 50 0 0 0 10.00 60.00 L 60 60 L 16.70 35.00"/>
		  <path data-bind="attr: { fill : color5 }" stroke="white" stroke-width="1" d="M 35.00 16.70 A 50 50 0 0 0 16.70 35.00 L 60 60 L 35.00 16.70"/>
		  <path data-bind="attr: { fill : color6 }" stroke="white" stroke-width="1" d="M 60.00 10.00 A 50 50 0 0 0 35.00 16.70 L 60 60 L 60.00 10.00"/>
		  <circle id="hub" fill="white" r="3" cx="60" cy="60" />
		</svg>
	</div>
	<div style="position:relative; width: 100%;">
		<span class="mc-clock-name" data-bind="text: name"></span>
	</div>
</div>    
    `
	});


