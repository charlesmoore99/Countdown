<%@ page contentType="application/json; charset=UTF-8" %> 
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="clocks.Clock"%>
<%@page import="clocks.Campaign"%>
<%@page import="clocks.Sprawl"%>
<%
String data = request.getParameter("data");
if (data == null){
	data = "{}";
}

JSONParser parser = new JSONParser();

List<Clock> newClocks = new ArrayList<>();
String id = "";

try {
	Object d = parser.parse(data);
	
	JSONObject jsonO = (JSONObject) d;
	
	id = (String) jsonO.get("id");
	JSONArray clocksArray = (JSONArray) jsonO.get("clocks");
	for (Iterator<JSONObject> iterator = clocksArray.iterator(); iterator.hasNext(); ) {
		JSONObject clockO = iterator.next();
		String name = (String) clockO.get("name");
		Long level =  (Long)clockO.get("level");
		
		Clock c = new Clock();
		c.setName(name);
		c.setRating(level.intValue());
		
		newClocks.add(c);
	}

} catch (ParseException e) {
	e.printStackTrace();
}

String db = getServletContext().getInitParameter("dbConnection");
Sprawl sprawl = new Sprawl(db);
Campaign camp = sprawl.getCampaignById(id);

if (camp == null) {
%>
{success: false, message: "Campaign does not exist"}
<%	
} else {
	sprawl.updateCampaign(id, newClocks);
}
%>
{success:true}