package study.j0430;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/j0430/T03_sessionOut")
public class T03_sessionOut extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		session.removeAttribute("slogoName");
		session.removeAttribute("shomeAddress");
		
		response.sendRedirect(request.getContextPath()+"/study/0430_web_xml/init/t03_init.jsp");
	}
}
