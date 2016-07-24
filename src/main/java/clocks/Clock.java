package clocks;

public class Clock {
	
	String name;
	String privateName;
	String descriptiion;
	int rating;
	
	public Clock(){
		name = "name";
		privateName = name;
		descriptiion = "";
		rating = 0;
	}
	
	public Clock(String name, String privateName, String descriptiion,
			int rating) {
		super();
		this.name = name;
		this.privateName = privateName;
		this.descriptiion = descriptiion;
		this.rating = rating;
	}
	
	public Clock(String name, String descriptiion,
			int rating) {
		super();
		this.name = name;
		this.privateName = name;
		this.descriptiion = descriptiion;
		this.rating = rating;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrivateName() {
		return privateName;
	}
	public void setPrivateName(String privateName) {
		this.privateName = privateName;
	}
	public String getDescriptiion() {
		return descriptiion;
	}
	public void setDescriptiion(String descriptiion) {
		this.descriptiion = descriptiion;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	public void increment() {
		if (getRating() == 6 )
			return;
		else
			setRating(getRating() + 1);
	}

	public void descrement() {
		if (getRating() == 0 )
			return;
		else
			setRating(getRating() - 1);
	}

	@Override
	public String toString() {
		return "Clock [name=" + getName() + ", privateName=" + getPrivateName() + ", descriptiion=" + getDescriptiion() + ", rating="
				+ getRating() + "]";
	}
}
