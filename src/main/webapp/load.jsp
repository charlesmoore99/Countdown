<%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="application/json; charset=UTF-8" %> <%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="clocks.Clock"%>
<%@page import="clocks.Campaign"%>
<%@page import="clocks.Sprawl"%>
<%
String id = request.getParameter("id");
if (id == null){
	%>{success: false, message: "Campaign does not exist"}<%
	return;
}

String db = getServletContext().getInitParameter("dbConnection");

Sprawl sprawl = new Sprawl(db);
Campaign camp = sprawl.getCampaignById(id);

if (camp == null) {
	%>{success: false, message: "Campaign not found"}<%
	return;
} 

JSONObject top = new JSONObject();
String name = camp.getName();
if (name == null | name.isEmpty()) {
	name = "The Big Board";
}
top.put("name", name);

JSONArray list = new JSONArray();
for (Clock cur : camp.getClocks()) {
	JSONObject obj = new JSONObject();
	obj.put("name", cur.getName());
	obj.put("level", cur.getRating());
	list.add(obj);
}
top.put("clocks", list);
%>{"success": true, "message": "", "data": <%=top.toJSONString()%>}
