package cdac.in.soochna;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.text.SimpleDateFormat; 

import cdac.in.soochna.DbConnect;

public class CreateQuote extends HttpServlet {

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
				//System.out.println( request.getParameter("notice")+" <> "+request.getParameter("startdatetime")+" <> "+request.getParameter("enddatetime"));	
				String quote = request.getParameter("quote");	
				String author = request.getParameter("author");	
				String user = (String) request.getSession().getAttribute("user");

				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String query =  "insert into quotes( quote, author, created_by, creation_timestamp) values ( ?, ?, ?, ?)";
				PreparedStatement stmt = conn.prepareStatement( query );


				try{
					stmt.setString(1, quote);
					stmt.setString(2, author);
					stmt.setString(3, user);
					stmt.setTimestamp(4, getCurrentTimeStamp() );

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
