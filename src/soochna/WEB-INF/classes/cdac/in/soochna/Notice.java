package cdac.in.soochna;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.Date;
import java.text.SimpleDateFormat; 

import cdac.in.soochna.DbConnect;

public class Notice extends HttpServlet {

	static String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

	static DbConnect dbc = null;

	public void init() throws ServletException {
		dbc = new DbConnect();
		System.out.println("Servlet initialsizing..");
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
			doPost( request, response);		
		}

	private static java.sql.Timestamp getCurrentTimeStamp() {

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

			response.setContentType("text/html");

			try{

				String message = "{\n";

				try{
					Connection conn = dbc.getConnection();

					Timestamp ct = getCurrentTimeStamp(); 
					String center = request.getParameter("center");
					String query =  "SELECT notice from notices where center = 'ALL' and is_delete = false and (? >= start_date and ? <= end_date) order by creation_timestamp  DESC";

					PreparedStatement stmt = conn.prepareStatement( query );

					if( center != null ){
						query =  "SELECT notice from notices where (center = 'ALL' OR center = ?) and is_delete = false and (? >= start_date and ? <= end_date) order by creation_timestamp DESC";
						stmt = conn.prepareStatement( query );
						stmt.setString(1, center );
						stmt.setTimestamp(2, ct );
						stmt.setTimestamp(3, ct );
					}else{
						stmt.setTimestamp(1, ct );
						stmt.setTimestamp(2, ct );
					}


					System.out.println( request.getRemoteAddr()+": "+ stmt );

					ResultSet rs = stmt.executeQuery();
					PrintWriter out = response.getWriter();
					boolean first =  true;

					while( rs.next() ){
						if( first ){
							message += "\"notice\":[\n";
							message	+= "{\"message\":\""+rs.getString(1)+"\"}";
						}else{
							message	+= ",\n {\"message\":\""+rs.getString(1)+"\"}";
						}
						first = false;
					}
					if( message.indexOf("message") >= 0)
						message	+= "\n]\n";

					try{
						stmt.close();
					}catch(Exception e){
						e.printStackTrace();
					}		

				}catch(Exception e){
					e.printStackTrace();
				}

				try{
					Connection conn = dbc.getConnection();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String date = formatter.format(new Date());
					String[] tt = date.split("/");
					String dob = tt[0].trim()+"-"+months[ Integer.parseInt( tt[1].trim() ) - 1 ];

					String query =  "SELECT employee_name, gender, groupid from birthday where data_of_birth = ?";
					PreparedStatement stmt = conn.prepareStatement( query );
					stmt.setString(1, dob );

					if( stmt != null ){

						ResultSet rs = stmt.executeQuery();

						boolean first =  true;

						while( rs.next() ){
							if( first ){
								if( message.indexOf("message") >= 0 ){
									message += ",\"birthday\":[\n";
								}else{
									message += "\"birthday\":[\n";
								}
								message	+= "{\"name\":\""+rs.getString(1)+"\",\"group\": \""+rs.getString(3)+"\", \"gender\":\""+rs.getString(2)+"\"}";
							}else{
								message	+= ",\n{\"name\":\""+rs.getString(1)+"\",\"group\": \""+rs.getString(3)+"\", \"gender\":\""+rs.getString(2)+"\"}";
							}		
							first = false;
						}

						if( message.indexOf("birthday") >= 0)
							message	+= "\n]\n";
					}

					try{
						stmt.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
					


				}catch(Exception e){
					e.printStackTrace();
				}

				message	+= "\n}";

				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");

				out.print(message);
				out.flush();

			}catch(Exception e){
				e.printStackTrace();

			}
		}

	public void destroy() {

		try{
			dbc.close();
		}catch(Exception e){
			e.printStackTrace();
		}		
		System.out.println("Servlet Distroying..");
	}
}
