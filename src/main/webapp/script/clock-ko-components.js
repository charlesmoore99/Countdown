ko.components.register('mc-clock-widget', {
	viewModel: function(params) {
		var self = this;
		self.sprawl = params.sprawl;
        self.name = params.name;
        self.value = params.value;

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
    <div>
    <table>
    	<tr>
    	<td><button class="button"  data-bind="click: remove, params=n : name">-</button></td><td><div class="mc-clock-name" data-bind="text: name"></div></td></tr>
    </table>
	<table>
		<tr>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert1: value() === 1,  alert2: value() === 2,  alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert2: value() === 2,  alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert6: value() === 6}"></div></td>
			<td style="padding-left:1em"><button class="button"  data-bind="click: decrease">-</button></td><td>&nbsp;</td><td><button class="button" data-bind="click: advance">+</button></td>				
		</tr>
		<tr class="legend">
			<td>&nbsp;</td><td><span class="legend">15:00</span></td>
			<td>&nbsp;</td><td><span class="legend">18:00</span></td>
			<td>&nbsp;</td><td><span class="legend">21:00</span></td>
			<td>&nbsp;</td><td><span class="legend">22:00</span></td>
			<td>&nbsp;</td><td><span class="legend">23:00</span></td>
			<td>&nbsp;</td><td><span class="legend">00:00</span></td>
		</tr>
	</table>
    </div>	
    `
	});

ko.components.register('crew-clock-widget', {
	viewModel: function(params) {
		var self = this;
        self.name = params.name;
        self.value = params.value;
    },
    template: `
    <div class="crew-clock">
    <table>
    	<tr>
    	<td><div class="clock-name" data-bind="text: name"></div></td></tr>
    </table>
	<table>
		<tr>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert1: value() === 1,  alert2: value() === 2,  alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert2: value() === 2,  alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock wide" data-bind="css: { alert3: value() === 3,  alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert4: value() === 4,  alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert5: value() === 5,  alert6: value() === 6}"></div></td>
			<td>&nbsp;</td><td><div class="clock short" data-bind="css: { alert6: value() === 6}"></div></td>
		</tr>
		<tr class="legend">
			<td>&nbsp;</td><td><span class="legend">15:00</span></td>
			<td>&nbsp;</td><td><span class="legend">18:00</span></td>
			<td>&nbsp;</td><td><span class="legend">21:00</span></td>
			<td>&nbsp;</td><td><span class="legend">22:00</span></td>
			<td>&nbsp;</td><td><span class="legend">23:00</span></td>
			<td>&nbsp;</td><td><span class="legend">00:00</span></td>
		</tr>
	</table>
    </div>
    `
	});


