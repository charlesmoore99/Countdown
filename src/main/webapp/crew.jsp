<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="clocks.Clock"%>
<%@page import="java.net.URI"%>
<%@page import="clocks.Campaign"%>
<%@page import="clocks.Sprawl"%>
<%
	String id = request.getParameter("id");
	if (id == null || id.isEmpty()) {
		return;
	}

	String dbHost = getServletContext().getInitParameter("dbHost");
	String dbPort = getServletContext().getInitParameter("dbPort");
	Sprawl s = new Sprawl(dbHost, dbPort);
	Campaign camp = s.getCampaignByViewId(id);

	String ws = getServletContext().getInitParameter("websocketHttpPort");
	String wss = getServletContext().getInitParameter("websocketHttpsPort");

	String b = request.getRequestURI();

	String url = request.getRequestURL().toString();
// 	String viewURL = url.substring(0, url.lastIndexOf('/') + 1) + "/crew.jsp?id=" + camp.getViewId();
// 	String editURL = request.getRequestURL().toString() + "?" + request.getQueryString();

	String name = StringEscapeUtils.escapeJson(camp.getName());
	String clockJson = StringEscapeUtils.escapeJson(camp.clocksJson());   
%>

<html>
<head>
<!-- <link href="https://fonts.googleapis.com/css?family=Inconsolata" rel="stylesheet"> -->
<link href="css/Inconsolata.css" rel="stylesheet">
<link href="css/sprawl.css" rel="stylesheet">
<link href="css/alertify.css" rel="stylesheet">
<link id="page_favicon" href="data:image/x-icon;base64,R0lGODlhEAAQAPAAAAAAAAAAACH5BAkKAAEAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCAUAgEAgAAoFAABAABAIBQCAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgQAgEAgAAoFAABAABAKBACAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAAAAIBACBQAAACAQCAQAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAQAAABAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAQAgEBAAABAQEAAQEBAQEBAQAAAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEBAQABAQABAAEBAQEAAQEBAQEAAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEBAAEBAQABAAEBAQEAAQEBAQABAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEAAQEBAQEAAQEBAAEAAQEAAQEBAQABAAEBAQEAAQEBAAEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAQCAEAgEBAAABAQEAAQEAAAEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgEAoFAIBAIBACBQAAACAAAAEAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgUAgEAgAAoFAABAABAKBQCAQAAQAgUAAEAgAAIFAIBAIBACBQAAACAQCAEAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAAh+QQJCgABACwAAAAAEAAQAAAC50wSEREREUIIIYQQQgAAABAEQRAEQRAAQBAAQQAAQRAEQQAEARAEARAIAAKBQCAACAQCgEAgEAgAAoFAABAABAKAQCAQAAQAgUAAEAgEAgFAIBAIBACBQAAACAQCAUAgEBAAABAQEAAQEBAQEBAQEBAQEAAQEBAAEAAQEBAQEBAQABAAEBAQEAAQEBAQEBAQEBAAEBAQEBAAEBAAEBAQABAQABAQEBAQEAAAEBAAEBAAABAQEBAQEBAQEAAAAAAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQIECAAAEKAAA7" rel="icon" type="image/x-icon">
<title>Countdown Tracker</title>
</head>
<body>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
<script type='text/javascript' src='script/jquery-3.0.0.min.js'></script>
<script type='text/javascript' src='script/knockout-3.4.0.js'></script>
<script type='text/javascript' src='script/clock-ko-components.js'></script>
<script type='text/javascript' src='script/clock-crew-ko.js'></script>
<script type='text/javascript' src='script/alertify.min.js'></script>
<script type='text/javascript' src='script/WebSocket.js'></script>

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-1395087-7', 'auto');
ga('send', 'pageview');

</script>

<script>

document.title = "<%=name%>";
var sprawl = new SprawlCrewVM("<%=id%>", "<%=id%>", "<%=name%>");
var websocket = new Chat(sprawl);

$().ready(function(){
	var clocks = $.parseJSON("<%=clockJson%>");

	$.each(clocks, function(i, v) {
		var c = new Clock();
		c.name(v.name);
		c.level(v.level);
		sprawl.clocks().push(c);
	});
	
	ko.applyBindings(sprawl);

   	var uri = ""
        if (window.location.protocol == 'http:') {
            uri = 'ws://' + window.location.hostname + ':<%=ws%>/clocks/commChanel/' + sprawl.viewId;
        } else {
            uri = 'wss://' + window.location.hostname + ':<%=wss%>/clocks/commChanel/' + sprawl.viewId;
        }

   	
   	websocket.connect(uri);
});
</script>

<h1 data-bind="text:name"></h1>
<div data-bind="foreach: clocks">
	<crew-clock-widget params="name: name, value: level">
	</mc-clock-widget>
</div>
<p  style="clear:both;">
<br>
</body>
</html>