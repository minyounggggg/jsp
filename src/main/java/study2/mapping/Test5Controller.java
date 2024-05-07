package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("*.do5")
public class Test5Controller extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Test5Interface command = null;
		
		String viewPage = "/WEB-INF/study2/mapping/";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if(com.equals("test5")) {
			viewPage += "test5.jsp";
		}
		else if(com.equals("t5Input")){
			viewPage += "t5Input.jsp";
		}
		else if(com.equals("t5InputOk")){
			command = new Test5InputCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/common/message.jsp";
		}
		else if(com.equals("t5Update")){
			viewPage += "t5Update.jsp";
		}
		else if(com.equals("t5UpdateOk")){
			command = new TestUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/common/message.jsp";
		}
		else if(com.equals("t5Delete")){
			viewPage += "t5Delete.jsp";
		}
		else if(com.equals("t5DeleteOk")){
			command = new Test5DeleteOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/common/message.jsp";
		}
		else if(com.equals("t5Search")){
			viewPage += "t5Search.jsp";
		}
		else if(com.equals("t5SearchOk")){
			command = new Test5SearchOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/common/message.jsp";
		}
		else if(com.equals("t5List")){
			viewPage += "t5List.jsp";
		}
		else if(com.equals("t5ListOk")){
			command = new Test5ListOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/common/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
