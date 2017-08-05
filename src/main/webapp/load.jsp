<%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="application/json; charset=UTF-8" %> <%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

String dbHost = getServletContext().getInitParameter("dbHost");
String dbPort = getServletContext().getInitParameter("dbPort");
Sprawl sprawl = new Sprawl(dbHost, dbPort);
Campaign camp = sprawl.getCampaignById(id);

if (camp == null) {
	%>{success: false, message: "Campaign not found"}<%
	return;
} 

%>{"success": true, "message": "", "data": <%=camp.toJsonString()%>}
