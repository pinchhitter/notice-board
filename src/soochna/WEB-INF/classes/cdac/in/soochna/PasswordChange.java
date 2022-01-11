package cdac.in.soochna;

import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.text.SimpleDateFormat; 

import cdac.in.soochna.DbConnect;

public class PasswordChange extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(  request, response );
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user = (String) request.getSession().getAttribute("user"); 
		System.out.println(" 1  I am here");

		if( user != null ){
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;	
		}	

		String username = request.getParameter("uname");

		if( username != null )
			username = username.toLowerCase();

		String password = request.getParameter("cpword");
		String newpassword = request.getParameter("npword");
		String newrpassword = request.getParameter("rnpword");

		Map<String, String> messages = new HashMap<String, String>();

		if (username == null || username.isEmpty()) {
			messages.put("username", "Please enter username");
		}

		if (password == null || password.isEmpty()) {
			messages.put("password", "Please enter current password");
		}

		if (newpassword == null || newpassword.isEmpty()) {
			messages.put("newpassword", "Please enter new password");
		}

		if ( newrpassword  == null || ! newrpassword.equals( newpassword ) ) {
			messages.put("newpassword", "Re entered Password not matching");
		}

		if ( messages.isEmpty() ) {

			try{
				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String query =  "update users set password = ? where username = ? and password = ? "; 
				PreparedStatement stmt = conn.prepareStatement( query );
				stmt.setString(1, newpassword );
				stmt.setString(2, username );
				stmt.setString(3, password);
				System.out.println( stmt );

				int rowcount = stmt.executeUpdate();

				if( rowcount == 0 ){
					messages.put("error", "Password update Failed!");
					request.setAttribute("messages", messages);
					request.getRequestDispatcher("/password.jsp").forward(request, response);
					return;
				}else{
					messages.put("success", "Password updated Successfully!!");
					request.setAttribute("messages", messages);
					request.getRequestDispatcher("/login.jsp").forward(request, response);
					return;
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}

		messages.put("error", "Password update Failed!");
		request.setAttribute("messages", messages);
		request.getRequestDispatcher("/password.jsp").forward(request, response);
	}
}
