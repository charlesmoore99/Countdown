package clocks;

public class Clock {
	
	String name;
	int level;
	
	public Clock(){
		name = "name";
		level = 0;
	}
	
	public Clock(String name, int l) {
		super();
		this.name = name;
		this.level = l;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getLevel() {
		return level;
	}
	
	public void setLevel(int l) {
		this.level = l;
	}
	
	public void increment() {
		if (getLevel() == 6 )
			return;
		else
			setLevel(getLevel() + 1);
	}

	public void decrement() {
		if (getLevel() == 0 )
			return;
		else
			setLevel(getLevel() - 1);
	}

	@Override
	public String toString() {
		return "Clock [name=" + name + ", level=" + level + "]";
	}
}
