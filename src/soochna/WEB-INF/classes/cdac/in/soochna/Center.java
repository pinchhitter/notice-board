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

public class Center extends HttpServlet {

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

	public void doPost(HttpServletRequest request, HttpServletResponse response){

		try{
			DbConnect dbc = new DbConnect();
			Connection conn = dbc.getConnection();
			String message = "{\n";
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
			System.err.println( message );
			out.flush();

		}catch(Exception e){
			e.printStackTrace();

		}
	}

	public void destroy() {
		System.out.println("Servlet Distroying..");
	}
}
