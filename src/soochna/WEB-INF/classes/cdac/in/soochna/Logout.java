package cdac.in.soochna;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Logout extends HttpServlet {  

	protected void doGet(HttpServletRequest request, HttpServletResponse response)  

			throws ServletException, IOException {  
			response.setContentType("text/html");  
			PrintWriter out=response.getWriter();  
			HttpSession session = request.getSession();  

			if( session != null ){
				session.invalidate();  
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} 		
			out.close();  
	}  
}  
