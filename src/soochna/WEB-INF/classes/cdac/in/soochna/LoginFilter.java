package cdac.in.soochna;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.text.SimpleDateFormat; 

import cdac.in.soochna.DbConnect;

public class LoginFilter implements Filter {

	static List<String> relax;

	

	public void init(FilterConfig arg0) throws ServletException {

		relax = new ArrayList<String>();
		relax.add("/center"); 
		relax.add("/password"); 
		relax.add("/soochna/center"); 
		relax.add("/soochna/notice"); 
		relax.add("/soochna/notice.jsp"); 
		relax.add("/soochna/test.jsp"); 
		relax.add("/soochna/password.jsp"); 
		relax.add("/soochna/password"); 
	}  

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession( true );

		String loginURI = request.getContextPath() + "/login";

		boolean loggedIn = session != null && session.getAttribute("user") != null;

		boolean loginRequest = request.getRequestURI().equals(loginURI);

		if ( loggedIn || loginRequest || relax.contains( request.getRequestURI() ) || request.getRequestURI().indexOf("images") >= 0 ) {
			chain.doFilter( request, response );
		} else {
			response.sendRedirect(loginURI);
		}
	}
	public void destroy() {
		System.out.println("Servlet Distroying..");
	}
}
