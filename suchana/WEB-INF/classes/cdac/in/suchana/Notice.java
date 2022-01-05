package cdac.in.suchana;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.Date;
import java.text.SimpleDateFormat; 

import cdac.in.suchana.DbConnect;

public class Notice extends HttpServlet {

	public void init() throws ServletException {
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
				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();

				Timestamp ct = getCurrentTimeStamp(); 
				String query =  "SELECT notice from notices where ? >= start_date and ? <= end_date order by creation_timestamp  DESC";
				PreparedStatement stmt = conn.prepareStatement( query );
				try{
					stmt.setTimestamp(1, ct );
					stmt.setTimestamp(2, ct );

					//System.out.println( stmt );

					ResultSet rs = stmt.executeQuery();
					PrintWriter out = response.getWriter();
					String message = "{ \"notice\":[\n";
					boolean first =  true;

					while( rs.next() ){
						if( first )
							message	+= "{\"message\":\""+rs.getString(1)+"\"}";
						else
							message	+= ",\n {\"message\":\""+rs.getString(1)+"\"}";
						first = false;
					}
					message	+= "\n]\n  }";

					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");

					out.print(message);
					out.flush();

				}catch(Exception e){
					e.printStackTrace();
				}finally{
					try{
						dbc.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
				}

			}catch(Exception e){
				e.printStackTrace();

			}
	}

	public void destroy() {
		System.out.println("Servlet Distroying..");
	}
}
