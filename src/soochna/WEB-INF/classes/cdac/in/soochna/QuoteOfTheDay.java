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

public class QuoteOfTheDay extends HttpServlet {

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
				int quoteid = Integer.parseInt( request.getParameter("quoteid") );	
				String user = (String) request.getSession().getAttribute("user"); 

				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();

				String query1 =  "update quotes set quoteofday = false";
				String query2 =  "update quotes set quoteofday = true where quoteid = ?";

				PreparedStatement stmt1 = conn.prepareStatement( query1 );
				PreparedStatement stmt2 = conn.prepareStatement( query2 );

				try{
					stmt2.setInt(1, quoteid);
					int count = stmt1.executeUpdate();
					count += stmt2.executeUpdate();

					if( count > 0 ){
						out.print("{\"Update\" : \"Successful\" }");
					}else{
						out.print("{\"Update\" : \"Unauthorised action\" }");
					}

				}catch(Exception e){
					out.print("{\"Update\" : \"Failed: Error\" }");
					e.printStackTrace();
				}finally{
					try{
						stmt1.close();
						stmt2.close();
						dbc.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
				}
			}catch(Exception e){
				out.print("{\"Update\" : \"Failed\" }");
				e.printStackTrace();
			}
			out.flush();
	}


	public void destroy() {
		System.out.println("Servlet Distroying..");
	}
}
