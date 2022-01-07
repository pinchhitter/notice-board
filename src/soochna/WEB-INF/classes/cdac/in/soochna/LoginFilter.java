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

public class LoginFilter implements Filter {

	

	public void init(FilterConfig arg0) throws ServletException {

	}  

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    


		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession( true );

		String loginURI = request.getContextPath() + "/login";

		boolean loggedIn = session != null && session.getAttribute("user") != null;

		boolean loginRequest = request.getRequestURI().equals(loginURI);

		if ( loggedIn || loginRequest || request.getRequestURI().equals("/center") || request.getRequestURI().equals("/soochna/center") || request.getRequestURI().equals("/soochna/notice") ||  request.getRequestURI().equals("/soochna/notice.jsp") ) {
			chain.doFilter( request, response );
		} else {
			response.sendRedirect(loginURI);
		}
	}
}
