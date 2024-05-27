package webMessage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.wm")
public class WebMessageController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WebMessageInterface command = null;
		String viewPage = "/WEB-INF/webMessage";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		//인증처리
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(level > 4) {
			request.setAttribute("message", "로그인 후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WebMessage")) {
			command = new WebMessageCommand();
			command.execute(request, response);
			viewPage += "/webMessage.jsp";
		}
		else if(com.equals("/WmInputOk")) {
			command = new WnInputCommandOk();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WmDeleteCheck")) {
			command = new WmDeleteCheckCommandOk();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/WmDeleteOne")) {
			command = new WmDeleteOneCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/WmDeleteAll")) {
			command = new WmDeleteAllCommand();
			command.execute(request, response);
			return;
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
