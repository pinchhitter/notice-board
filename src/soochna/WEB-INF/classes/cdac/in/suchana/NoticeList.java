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

public class NoticeList extends HttpServlet {

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
				String query =  "SELECT * from notices order by creation_timestamp";
				PreparedStatement stmt = conn.prepareStatement( query );
				try{

					ResultSet rs = stmt.executeQuery();
					PrintWriter out = response.getWriter();
					String message = "{\n \"notice\":[\n";
					boolean first =  true;
					int count = 0;
					while( rs.next() ){
						if( first )
							message	+= "{\"noticeid\":\""+rs.getString(1)+"\", \"notice\":\""+rs.getString(2)+"\", \"start_date\":\""+rs.getString(3)+"\",\"end_date\":\""+rs.getString(4)+"\"}";
						else
							message	+= ",\n{\"noticeid\":\""+rs.getString(1)+"\", \"notice\":\""+rs.getString(2)+"\", \"start_date\":\""+rs.getString(3)+"\",\"end_date\":\""+rs.getString(4)+"\"}";
						count++;
						first = false;
					}
					message	+= "\n]\n }";

					System.out.println("count "+count +" Message: "+message);	

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
