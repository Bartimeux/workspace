package Objects;
import java.util.ArrayList;


public class Game {
	
	private ArrayList<Character> players;
	private ArrayList<String> playerNames;
	private int numPlayers;
	private Mission[] steps;
	private int currentStep = 0;
	private int numRedPlayers;
	
	public Game() {
		steps = new Mission[5];
		this.players = new ArrayList<Character>();
		this.playerNames = new ArrayList<String>();
		this.numPlayers = 0;
		this.numRedPlayers = 0;
	}
	
	public void addPlayer(String name) {
		if(!this.playerNames.contains(name)) players.add(new Character(name));
		numPlayers = players.size();
	}
	
	public void removePlayer(String name) {
		Character tmp=null;
		for(Character c: players) if(c.getName().equals(name)) tmp = c;
		if(tmp!=null) players.remove(tmp);
		numPlayers = players.size();
	}
	
	public void updateProba() {
		float probaMission = 1;
		float probaColor = 1;
		for(Character c: players) for(int i=0; i < this.currentStep; i++) {
			Mission m = steps[i];
			if(c.belongsTo(m)) {
				probaMission = probaMission * m.getNumPlayers()/this.numPlayers;
			} else {
				probaMission = probaMission * ( 1 - ( m.getNumPlayers()/this.numPlayers));
			}
			if(m.isRed()) {
				probaColor = probaColor * this.numRedPlayers/this.numPlayers;
			} else {
				probaColor = probaColor * ( 1 - (this.numRedPlayers/this.numPlayers));
			}
		}
	}
	
	public ArrayList<Character> getPlayers() {
		return this.players;
	}
	
	public void setRedPlayersNumber(int nr) {
		this.numRedPlayers = nr;
	}

	
}
