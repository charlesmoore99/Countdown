<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="javax.websocket.server.ServerEndpointConfig"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="clocks.Clock"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.net.URI"%>
<%@page import="clocks.Campaign"%>
<%@page import="clocks.Sprawl"%>
<%
	String id = request.getParameter("id");
	if (id == null || id.isEmpty()) {
		return;
	}
	
	String db = getServletContext().getInitParameter("dbConnection");
	Sprawl s = new Sprawl(db);
	Campaign camp = s.getCampaignById(id);

	String ws = getServletContext().getInitParameter("websocketHttpPort");
	String wss = getServletContext().getInitParameter("websocketHttpsPort");

	String b = request.getRequestURI();

	String url = request.getRequestURL().toString();
	String viewURL = url.substring(0, url.lastIndexOf('/') + 1) + "analog-crew.jsp?id=" + camp.getViewId();
	String editURL = request.getRequestURL().toString() + "?" + request.getQueryString();
	
	String name = StringEscapeUtils.escapeJson(camp.getName());
	String clockJson = StringEscapeUtils.escapeJson(camp.clocksJson()); 
%>
<html>
<head>
<link href="css/Inconsolata.css" rel="stylesheet">
<link href="css/sprawl.css" rel="stylesheet">
<link href="css/alertify.css" rel="stylesheet">
<link id="page_favicon" href="data:image/x-icon;base64,R0lGODlhEAAQAPAAAAAAAAAAACH5BAkKAAEAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCAUAgEAgAAoFAABAABAIBQCAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgQAgEAgAAoFAABAABAKBACAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAAAAIBACBQAAACAQCAQAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAQAAABAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAQAgEBAAABAQEAAQEBAQEBAQAAAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEBAQABAQABAAEBAQEAAQEBAQEAAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEBAAEBAQABAAEBAQEAAQEBAQABAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEAAQEBAQABAAEBAQEAAQEBAAEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAEAgEBAAABAQEAAQEAAAEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAAAAEAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgAAIFAIBAIBACBQAAACAQCAEAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgEAgEAgAAoFAABAABAKAQCAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAA7" rel="icon" type="image/x-icon">
<title>Countdown Tracker</title>

<style>
#loading {
   width: 100%;
   height: 100%;
   top: 0px;
   left: 0px;
   position: fixed;
   opacity: 0.7;
   background-color: #000000;
   z-index: 99;
   text-align: center;
}

#loading-content {
  position: absolute;
  top: 50%;
  left: 50%;
  text-align: center;
  z-index: 100;
}

.hide{
  display: none;
}

.Crm {
	width:1280px; 
	height:720px;
    padding: .8em 1em 0;
    border-radius: 3px;
	border-style:solid; 
	border-color:white; 
	overflow:hidden;     
}


.Aligner {
  display: flex;
  align-items: center;
  min-height: 720px;
  justify-content: center;
}

.Aligner-item {
  flex: 1;
}

.Aligner-item--top {
  align-self: flex-start;
}

.Aligner-item--bottom {
  align-self: flex-end;
}

.Aligner-item--fixed {
  flex: none;
  max-width: 50%;
}

#casticonactive {
  float:right;
  margin:10px 17px 14px 0px;
  width: 64px;
  height: 64px;
  display:none; 
  background-image:url('images/ic_media_route_on_custom_64.png');
}

#casticonidle {
  float:right;
  width: 64px;
  height: 64px;
  margin:10px 17px 14px 0px;
  display:none; 
  background-image:url('images/ic_media_route_off_custom_64.png');
}


</style>


</head>
<body>
<script>
//set the chromcast application ID
var DIGITAL_ID = 'A28B2CFD';
var ANALOG_ID = 'C6993C03';
var TEST_ID = 'D1B47EAC';

var applicationID = ANALOG_ID;
</script>

<script type='text/javascript' src='script/jquery-3.0.0.min.js'></script>
<script type='text/javascript' src='script/funcs.js'></script>
<script type='text/javascript' src='script/knockout-3.4.0.js'></script>
<script type='text/javascript' src='script/analog-clock-ko-components.js'></script>
<script type='text/javascript' src='script/clock-mc-ko.js'></script>
<script type='text/javascript' src='script/alertify.min.js'></script>
<script type='text/javascript' src='script/WebSocket.js'></script>
<script type='text/javascript' src='script/chromecast.js'></script>
<script type="text/javascript" src="//www.gstatic.com/cv/js/sender/v1/cast_sender.js"></script>


<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-1395087-7', 'auto');
ga('send', 'pageview');
</script>


<script>

var sprawl = new SprawlVM("<%=id%>", "<%=camp.getViewId()%>", "<%=name%>");
var websocket = new Chat(sprawl);

var j = 0;
var delay = 2000; //millisecond delay between cycles

var hideChromecast = function() {
    document.getElementById("casticonactive").style.display = 'none';
    document.getElementById("casticonidle").style.display = 'none';	
};

var showIdleChromecast = function() {
    document.getElementById("casticonactive").style.display = 'none';
    document.getElementById("casticonidle").style.display = 'block';
};

var showActiveChromecast = function() {
    document.getElementById("casticonactive").style.display = 'block';
    document.getElementById("casticonidle").style.display = 'none';	
};

$().ready(function(){

	document.title = "<%=name%>";
	var clocks = $.parseJSON("<%=clockJson%>");
	$.each(clocks, function(i, v){
	 	var c = new Clock();
	 	c.name(v.name);
	 	c.level(v.level);
	 	sprawl.clocks().push(c);
	});
	
	ko.applyBindings(sprawl);
	document.getElementById("casticonidle").addEventListener('click', function(){
		var clockStruct = new ViewData(sprawl.name, sprawl.clocks);
		var clockString =  ko.toJSON(clockStruct);
		startSession(clockString);
	
	});
	
	document.getElementById("casticonactive").addEventListener('click', function(){
		stopApp();
	});

   	var uri = ""
     if (window.location.protocol == 'http:') {
         uri = 'ws://' + window.location.hostname + ':<%=ws%>/clocks/commChanel/' + sprawl.viewId;
     } else {
         uri = 'wss://' + window.location.hostname + ':<%=wss%>/clocks/commChanel/' + sprawl.viewId;
     }
	
	websocket.connect(uri);
});
</script>
<div style="float:left;">
<div id="casticonactive"></div>
<div id="casticonidle"></div>
</div>
<div style="float:left;">
<h1>Countdown Controller</h1>
<h2> MC's Eyes Only</h2>
</div>
<p  style="clear:both;">
<fieldset style="float:left;">
	<legend><span data-bind="text: name"></span><button class="small-button" data-bind="click: setName">*</button></legend>	
	<div data-bind="foreach: clocks">
		<mc-clock-widget params="sprawl:sprawl, name: name, value: level"></mc-clock-widget>
	</div>
	<p  style="clear:both;">
	<br>
	<hr style="width:50em; border-color:black">
	<button class="button" data-bind="click: add">Add Clock</button>
	<button class="button" data-bind="click: clear">Clear All</button>
</fieldset>
<p  style="clear:both;">
<br>
<p style="clear:both;padding-top: 1em;">The Big Board: <a href="<%=viewURL%>"><%=viewURL%></a>
<div id="loading" class="hide">
	<div id="loading-content">Syncing...</div>
</div>
</body>
</html>