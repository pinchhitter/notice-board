import java.util.*;

class Insert{


	static String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
	
	public static void main(String[] args){
		Scanner  scn = new Scanner(System.in);
		while( scn.hasNext() ){
			String line = scn.nextLine().trim();
			System.err.println( line );
			String[] t = line.split(",");
			String[] tt = t[10].split("/");
			String dob = tt[0].trim()+"-"+months[ Integer.parseInt( tt[1].trim() ) - 1 ];
			System.out.println("INSERT into birthday( emp_id, employee_name, email, data_of_birth, gender, groupid ) values  ('"+t[4]+"','"+t[6]+"','"+t[9]+"', '"+dob+"','"+t[3]+"', '"+t[8]+"');");
		}
	}
}
