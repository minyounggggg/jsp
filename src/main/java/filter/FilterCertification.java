package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.group.Response;

// @WebFilter("/*")   //경로 (모든 경로 필터로 검사)
public class FilterCertification implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("1. 필터 수행전..");
		
		String admin = request.getParameter("admin")==null ? "" : request.getParameter("admin");
		String u = request.getParameter("u")==null ? "" : request.getParameter("u");
		System.out.println("admin : " + admin + ", user : " + u);
		
		PrintWriter out = response.getWriter();
		
		
		// 필터에서는 session객체의 사용불가, 하지만 application 객체 사용가능
		ServletContext application = request.getServletContext();
		String aCertification = application.getAttribute("aCertification")==null ? "" : (String)application.getAttribute("aCertification");
		System.out.println("현재 발급된 인증번호 : " + aCertification);
		
		// 주소창에 ?admin=admin 으로 들어왔을경우에만 아래 조건을 통과시키도록한다.
		
		if(!admin.equals("admin")) {
			// 일반 유저이면서, 인증코드가 발급되지 않았다면, '발급 대기' 메세지를 띄우고 돌려보낸다.
			if(aCertification.equals("")) {
				out.println("<script>");
				out.println("alert('아직 인증코드가 발급되지 않았습니다. \\n 잠시 후 다시 접속해주세요.');");   // 이렇게 script쓸떄는 역슬러쉬 쓸때는 하나 더 써야함
				out.println("history.back();");
				out.println("</script>");
				return;
			}
			
			// 일반유저가 인증코드 발급시 처리
			String aUesrCertification = application.getAttribute("aUesrCertification")==null ? "" : (String)application.getAttribute("aUesrCertification");
			if(!aUesrCertification.equals(aCertification)) {  //내가 저장한인증번호가 일치하지않으면 돌아감
				if(!u.equals(aCertification)) {
					out.println("<script>");
					out.println("alert('인증코드를 확인하세요 (?c=인증코드)');");  
					out.println("history.back();");  //뒤로
					out.println("</script>");
					return;
				}
				else {
					out.println("<script>");
					out.println("alert('인증되었습니다. 서비스 이용이 가능합니다.');");  
					out.println("</script>");
					application.setAttribute("aUesrCertification", u);
				}
			}
		}// 인증번호 맞으면 탈출
		
		chain.doFilter(request, response);
		
		if(admin.equals("admin") && aCertification.equals("")) {
			out.println("<script>");
			out.println("alert('관리자님, 인증 코드를 발급해주세요.');");  
//			out.println("location.href=''");   --> 필터안에서는 location.href 사용 불가
			out.println("</script>");
		}
		
		System.out.println("2. 필터 수행후..");
	}
	
}
