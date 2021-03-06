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

public class Delete extends HttpServlet {

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
				int noticeid = Integer.parseInt( request.getParameter("noticeId") );	
				String user = (String) request.getSession().getAttribute("user"); 

				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String query =  "update notices set is_delete = true where noticeid = ? and created_by = ? ";
				PreparedStatement stmt = conn.prepareStatement( query );
				try{
					stmt.setInt(1, noticeid);
					stmt.setString(2, user);
					System.err.println("Query: "+stmt);

					int count = stmt.executeUpdate();
					if( count > 0 ){
						out.print("{\"Create\" : \"Successful\" }");
					}else{
						out.print("{\"Create\" : \"Unauthorised action\" }");
					}
				}catch(Exception e){
					out.print("{\"Create\" : \"Failed: Error\" }");
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
