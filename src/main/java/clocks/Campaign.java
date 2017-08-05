package clocks;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;

import com.google.gson.Gson;

public class Campaign {

	String id;
	String viewId;
	Date lastUpdated;

	String name;
	List<Clock> clocks = new ArrayList<>();

	public Campaign() {
		super();
		setId("");
		setViewId("");
		setName("");
		setLastUpdated();
	}

	public Campaign(String id, String viewId) {
		super();
		setId(id);
		setViewId(viewId);
		setName("");
		setLastUpdated();
	}

	public Campaign(String id, String viewId, String name) {
		super();
		setId(id);
		setViewId(viewId);
		setName(name);
		setLastUpdated();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
		setLastUpdated();		
	}

	public String getViewId() {
		return viewId;
	}

	public void setViewId(String viewId) {
		this.viewId = viewId;
		setLastUpdated();
	}

	public List<Clock> getClocks() {
		return clocks;
	}

	public String getClocksJson() {
		Gson g = new Gson();
		return g.toJson(getClocks());
	}

	public void setClocks(List<Clock> c) {
		this.clocks.clear();
		this.clocks.addAll(c);
		setLastUpdated();
	}

	public void addClocks(List<Clock> c) {
		this.clocks.addAll(c);
		setLastUpdated();
	}

	public void addClock(Clock c) {
		this.clocks.add(c);
	}
	
	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated() {
		setLastUpdated(new Date());
	}	
	
	public void setLastUpdated(Date d) {
		this.lastUpdated = d;
	}	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		Instant instant = Instant.ofEpochMilli(getLastUpdated().getTime());
		LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
		return "Campaign [id=" + getId() + ", viewId=" + getViewId() + ", lastupdated=" + DateTimeFormatter.ISO_DATE_TIME.format(localDateTime) + ", clocks="	+ clocksJson() + "]";
	}

	public String toJsonString() {
		return String.format("{ \"name\": \"%s\", \"clocks\" : %s }", StringEscapeUtils.escapeJson(getName()), getClocksJson());
	}

	public String clocksJson(){
		Gson g = new Gson();
		return g.toJson(getClocks());
	}

	public List<Clock> clocks(String json) {
		Gson g = new Gson();
		Clock[] ca = g.fromJson(json, Clock[].class);
		return Arrays.asList(ca);
	}
}
