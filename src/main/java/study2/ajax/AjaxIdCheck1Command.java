package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyDAO;
import study2.StudyInterface;

public class AjaxIdCheck1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		StudyDAO dao = new StudyDAO();
		
		String name = dao.getIdSearch(mid);
		
		if(name.equals("")) {
			name = "찾는 자료가 없습니다.";
		}
		else {
//			PrintWriter out = response.getWriter();
//			out.println(name);  브라우저에출력
//			out.write(name);  // 헤더에 담아서 출력
			response.getWriter().write(name);  //헤더에 실려서 넘어감
		}
	}

}
