package study.database;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/database/LoginOk")
public class LoginOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") ==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") ==null ? "" : request.getParameter("pwd");
		
		LoginDAO dao = new LoginDAO();
		
//		LoginVO vo = new LoginVO();
		LoginVO vo = dao.getLoginIdCheck(mid, pwd);
		
//		System.out.println("vo : " + vo);  vo는 값이 없어도null로 들어오기떄문에 vo로 비교하지마라
		
		PrintWriter out = response.getWriter();
		
		// 아래로 회원 인증처리
		// 회원이 맞으면 vo.getMid 값이 null이 아니다.
		if(vo.getMid() != null) {
			// 회원일때 처리할 부분
			// 쿠키에 아이디를 저장/해제 처리한다.
			// 로그인시 아이디저장시킨다고 체크하면 쿠키에 아이디 저장하고, 그렇지 않으면 쿠키에서 아이디를 제거한다.
			String idSave = request.getParameter("idSave")==null ? "off" : "on";
			Cookie cookieMid = new Cookie("cMid", mid);
			cookieMid.setPath("/");
			if(idSave.equals("on")) {
				cookieMid.setMaxAge(60*60*24*7);	// 쿠키의 만료시간은 1주일로 한다.
			}
			else {
				cookieMid.setMaxAge(0);
			}
			response.addCookie(cookieMid);
			
			
			//필요한 정보를 session에 저장처리한다.
			HttpSession session = request.getSession();
			session.setAttribute("sMid", mid);
			//회원의 성명을 세션에 저장하기 위해 DB에서 가져온 name을 세연에 저장처리한다.
			session.setAttribute("sName", vo.getName());
			
			// 관리자의 아이디는 'cmy1234' 이라고 가정하고, 관리자인 경우는 관리자 세션(sAdmin)을 부여한다.
			if(mid.equals("cmy1234")) session.setAttribute("sAdmin", "OK");  //아이디가 cmy1234가 맞으면 관리자세션(sAdmin)에 'OK'로 저장한다.
			
			out.println("<script>");
			out.println("alert('"+mid+"님 로그인 되었습니다. ~')");
			out.println("location.href='"+request.getContextPath()+"/study/database/LoginList';");
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('로그인 실패 ~')");
			out.println("location.href='"+request.getContextPath()+"/study/database/login.jsp';");
			out.println("</script>");
		}
		
		
	}
}
