package Objects;

public class Character {
	
	private String name;
	private boolean rouge = false;
	private float probaR = 0;
	private float probaB = 0;
	
	public Character(String name) {
		this.name = name;
	}
	
	public boolean isRouge() {
		return rouge;
	}
	
	public float getProbaR() {
		return probaR;
	}
	
	public float getProbaB() {
		return probaB;
	}
	
	public String getName() {
		return name;
	}
	
	public boolean belongsTo(Mission m) {
		return m.getPlayers().contains(this);
	}

}
