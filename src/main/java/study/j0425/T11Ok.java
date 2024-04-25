package study.j0425;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet ("/j0425/T11Ok")
public class T11Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		//front에서 넘어온 값들을 변수에 담아서 처리한다.
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		//db에서 mid와 같은 자료가 있는지 검색후 돌아온다.
		String loginOk = "";
		if(!mid.equals("admin") || !pwd.equals("1234")){
			//jsp로 보내서 다시 로그인하라는 메세지를 띄워라
			response.sendRedirect(request.getContextPath()+"/study/0428/t11_Login.jsp?msgFlag=no");
			return;
		}
		
		//정상회원들 처리부분
		System.out.println("정상로그인 처리됨");
//		response.sendRedirect(request.getContextPath()+"/study/0425/t11_Login.jsp?msgFlag=ok&min="+mid);
		
		String viewPage = "/study/0425/t11Main.jsp?msgFlag=ok&min="+mid;
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);  //직렬, 앞에서 가져온 값을 그대로
	}
}
