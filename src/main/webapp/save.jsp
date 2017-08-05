<%@ page contentType="application/json; charset=UTF-8" %> 
<%@page import="java.sql.SQLException"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

Campaign c = new Gson().fromJson(data, Campaign.class);

String dbHost = getServletContext().getInitParameter("dbHost");
String dbPort = getServletContext().getInitParameter("dbPort");
Sprawl sprawl = new Sprawl(dbHost, dbPort);
Campaign camp = sprawl.getCampaignById(c.getId());

if (camp == null) {
%>
{success: false, message: "Campaign does not exist"}
<%	
} else {
	try {
		sprawl.updateCampaign(c.getId(), c.getName(), c.getClocks());
		out.println("{success:true}");
	} catch (SQLException e) {
		out.println("{success:false, message: \"SQL error\"}");		
	}
}
%>