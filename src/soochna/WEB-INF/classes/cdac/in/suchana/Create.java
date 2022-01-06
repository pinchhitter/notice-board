package cdac.in.suchana;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.text.SimpleDateFormat; 

import cdac.in.suchana.DbConnect;

public class Create extends HttpServlet {

	private String message;

	public void init() throws ServletException {

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

			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			try{
				System.out.println( request.getParameter("notice")+" <> "+request.getParameter("startdatetime")+" <> "+request.getParameter("enddatetime"));	
				String notice = request.getParameter("notice");	
				String stime = request.getParameter("startdatetime").replaceAll("T", " ");	
				String etime = request.getParameter("enddatetime").replaceAll("T", " ");	


				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
				Date sDateTime = dateFormat.parse(stime);
				Date eDateTime = dateFormat.parse(etime);

				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String query =  "insert into notices( notice , start_date, end_date, creation_timestamp) values ( ?, ?, ?, ?)";
				PreparedStatement stmt = conn.prepareStatement( query );


				try{
					stmt.setString(1, notice);
					stmt.setTimestamp(2, new Timestamp( sDateTime.getTime() ) );
					stmt.setTimestamp(3, new Timestamp( eDateTime.getTime() ) );
					stmt.setTimestamp(4, getCurrentTimeStamp() );

					System.out.println( stmt );

					stmt.executeUpdate();

					out.print("{\"Create\" : \"Successful\" }");

				}catch(Exception e){
					out.print("{\"Create\" : \"Failed\" }");
					e.printStackTrace();
				}finally{
					try{
						dbc.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
				}

			}catch(Exception e){
				out.print("{\"Create\" : \"Failed\" }");
				e.printStackTrace();

			}
			out.flush();
	}


	public void destroy() {
		System.out.println("Servlet Distroying..");
	}
}
