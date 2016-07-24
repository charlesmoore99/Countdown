package clocks;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Campaign {

	String id;
	String viewId;
	Date lastUpdated;
	
//	@OneToMany(orphanRemoval = true)
	List<Clock> clocks;

	public Campaign() {
		super();
		setId("");
		setViewId("");
		setClocks(new ArrayList<Clock>());
		setLastUpdated();
	}

	public Campaign(String id, String viewId, List<Clock> clocks) {
		super();
		setId(id);
		setViewId(viewId);
		setClocks(clocks);
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

	public void setClocks(List<Clock> clocks) {
		this.clocks = clocks;
		setLastUpdated();
	}

	public void addClock(Clock c) {
		this.clocks.add(c);
	}
	
	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated() {
		this.lastUpdated = new Date();
	}

	@Override
	public String toString() {
		return "Campaign [id=" + getId() + ", viewId=" + getViewId() + ", clocks="	+ getClocks() + "]";
	}
	

	@SuppressWarnings("unchecked")
	public String clocksJson(){
		JSONArray list = new JSONArray();
		for (Clock c : getClocks()) {
			JSONObject obj = new JSONObject();
			obj.put("name", c.getName());
			obj.put("level", c.getRating());
			list.add(obj);
		}

		return list.toJSONString();
	}
}
