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

public class NoticeList extends HttpServlet {

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
			response.setContentType("text/html");
			try{
				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String message = "{\n";
				try{
					Timestamp ct = getCurrentTimeStamp();
                                	String query =  "SELECT  noticeid, notice, start_date, end_date, center from notices where is_delete = false order by creation_timestamp ";
					PreparedStatement stmt = conn.prepareStatement( query );
					ResultSet rs = stmt.executeQuery();
					boolean first =  true;
					int count = 0;

					//System.err.println( stmt );

					while( rs.next() ){
						if( first ){
							message += "\"notice\": [\n";
							message	+= "\t{\"noticeid\":\""+rs.getString(1)+"\", \"notice\":\""+rs.getString(2)+"\", \"start_date\":\""+rs.getString(3)+"\",\"end_date\":\""+rs.getString(4)+"\",\"center\":\""+rs.getString(5)+"\"}";
						}else{
							message	+= ",\n\t{\"noticeid\":\""+rs.getString(1)+"\", \"notice\":\""+rs.getString(2)+"\", \"start_date\":\""+rs.getString(3)+"\",\"end_date\":\""+rs.getString(4)+"\", \"center\":\""+rs.getString(5)+"\"}";
						}	
						count++;
						first = false;
					}
					if( message.indexOf("notice") >= 0){
						message	+= "\n\t]\n";
					}	

				}catch(Exception e){
					e.printStackTrace();
				}finally{
					try{
						dbc.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
				}

				conn = dbc.getConnection();
				try{
					String query =  "SELECT * from center";
					PreparedStatement stmt = conn.prepareStatement( query );
					ResultSet rs = stmt.executeQuery();
					boolean first =  true;
					int count = 0;

					while( rs.next() ){
						if( first ){
							if( message.indexOf("notice") >= 0){
								message += ",\"centers\": [\n";
							}else{
								message += "\"centers\": [\n";
							}	

							message	+= "\t{\"centerId\":\""+rs.getString(1)+"\", \"centerName\":\""+rs.getString(2)+"\"}";
						}else{
							message	+= ",\n\t{\"centerId\":\""+rs.getString(1)+"\", \"centerName\":\""+rs.getString(2)+"\"}";
						}	
						count++;
						first = false;
					}

					if( message.indexOf("centers") >= 0){
						message	+= "\n\t]\n";
					}	



				}catch(Exception e){
					e.printStackTrace();
				}finally{
					try{
						dbc.close();
					}catch(Exception e){
						e.printStackTrace();
					}		
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
		System.out.println("Servlet Distroying..");
	}
}
