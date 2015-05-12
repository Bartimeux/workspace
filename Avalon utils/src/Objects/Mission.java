package Objects;
import java.util.ArrayList;


public class Mission {

	private ArrayList<Character> players;
	private int numRed = 0;
	private int maxRed = 1;
	private int numPlayers;
	
	public Mission(ArrayList<Character> players, int numRed) {
		this.players = players;
		this.numRed = numRed;
		this.numPlayers = players.size();
	}
	
	public Mission(ArrayList<Character> players, int maxRed, int numRed) {
		this.players = players;
		this.numRed = numRed;
		this.numPlayers = players.size();
		this.maxRed = maxRed;
	}
	
	public boolean isRed() {
		return this.numRed < this.maxRed;
	}
	
	public ArrayList<Character> getPlayers() {
		return this.players;
	}
	
	public int getNumPlayers() {
		return this.numPlayers;
	}
	
}
