package study.j0430;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/j0430/T03_init")
public class T03_init extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 T03_init 서블릿입니다.");
		
		String logoName = getServletContext().getInitParameter("logoName");
		String homeAddress = getServletContext().getInitParameter("homeAddress");
		
		HttpSession session = request.getSession();
		
		session.setAttribute("slogoName", logoName);
		session.setAttribute("shomeAddress", homeAddress);
		
		String viewPage = "/study/0430_web_xml/init/t03_init.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
