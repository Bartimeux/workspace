package Main;
import java.util.Scanner;
import Objects.*;
import Objects.Character;

public class Main {
	
	public static void main(String[] args) {
		Game g = new Game();
		
		welcomeUser();
		firstMenu(g);
		secondMenu(g);
	}
	
	private static void secondMenu(Game g) {
		Scanner s = new Scanner(System.in);
		int m = 0;
		while(m!=3) {
			System.out.println("******************************************************************************************");
			System.out.println("                                       GAME MENU                                          ");
			System.out.println("******************************************************************************************");
			System.out.println("\nWhat do you wanna do ?\n");
			System.out.println("1 - Add a mission");
			System.out.println("2 - Remove last mission");
			System.out.println("3 - End the game");
			System.out.println("\n Current players with blue probability");
			printPlayersAndProba(g);
			System.out.println("\nYour choice");
			
			m = s.nextInt();
			switch(m) {
			case 1:
				System.out.println("\nType the name of the player :");
				g.addPlayer(s.nextLine());
				break;
			case 2:
				System.out.println("\nType the name of the player :");
				g.removePlayer(s.nextLine());
				break;
			case 3:
				System.out.println("\nThanks for playing with us !\n\nBye !");
				break;
			default :
				System.out.println("\nIncorrect choice\n");
			}
		}
		s.close();
	}

	private static void printPlayersAndProba(Game g) {
		if(g.getPlayers()!=null) for(Character c : g.getPlayers()) System.out.println(c.getName() + "\t - \t" + c.getProbaB() * 100 + " %");
	}

	private static void firstMenu(Game g) {
		Scanner s = new Scanner(System.in);
		int m = 0;
		while(m!=3) {
			System.out.println("******************************************************************************************");
			System.out.println("                                       MAIN MENU                                          ");
			System.out.println("******************************************************************************************");
			System.out.println("\nWhat do you wanna do ?\n");
			System.out.println("1 - Add a player");
			System.out.println("2 - Remove a player");
			System.out.println("3 - Start the game");
			System.out.println("\nExisting users :");
			printPlayers(g);
			System.out.println("\nYour choice");
			
			m = s.nextInt();
			String name = "";
			
			switch(m) {
			case 1:
				System.out.println("\nType the name of the player :");
				name = s.nextLine();
				if(name.equals("")) name = s.nextLine();
				g.addPlayer(name);
				break;
			case 2:
				System.out.println("\nType the name of the player :");
				name = s.nextLine();
				if(name.equals("")) name = s.nextLine();
				g.removePlayer(name);
				break;
			case 3:
				System.out.println("\nHow many bad guys are there ?");
				int num = s.nextInt();
				g.setRedPlayersNumber(num);
				break;
			default :
				System.out.println("\nIncorrect choice\n");
			}
		}
		s.close();
	}

	public static void printPlayers(Game g) {
		if(g.getPlayers()!=null) for(Character c : g.getPlayers()) System.out.println(c.getName());
	}

	public static void welcomeUser() {
		System.out.println("*************************************** AVALON UTILS *************************************");
		System.out.println("\nHello buddy !\n\nWelcome to Avalon utils !\nWanna use some proba' ? Here we go !\n\n");
	}
	
}
