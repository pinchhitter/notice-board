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

public class Login extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(  request, response );
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user = (String) request.getSession().getAttribute("user"); 

		if( user != null ){
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;	
		}	
	
		String username = request.getParameter("uname");
		if( username != null )
			username = username.toLowerCase();

		String password = request.getParameter("pword");

		Map<String, String> messages = new HashMap<String, String>();

		if (username == null || username.isEmpty()) {
			messages.put("username", "Please enter username");
		}

		if (password == null || password.isEmpty()) {
			messages.put("password", "Please enter password");
		}

		if (messages.isEmpty()) {

			try{
				DbConnect dbc = new DbConnect();
				Connection conn = dbc.getConnection();
				String query =  "select username from users where username = ? and password = ? "; 
				PreparedStatement stmt = conn.prepareStatement( query );
				stmt.setString(1, username);
				stmt.setString(2, password);
				ResultSet rs = stmt.executeQuery();
				while( rs.next() ){
					user = rs.getString(1);
				}

			}catch(Exception e){
				e.printStackTrace();
			}

			if (user != null) {
				request.getSession().setAttribute("user", user);
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;

			} else {
				messages.put("login", "Unknown login, please try again");
			}  
		}

		request.setAttribute("messages", messages);
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}
}
