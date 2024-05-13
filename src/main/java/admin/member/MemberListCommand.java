package admin.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;
import member.MemberDAO;
import member.MemberVO;

public class MemberListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int level = request.getParameter("level")==null? 999 : Integer.parseInt(request.getParameter("level"));
		
		AdminDAO dao = new AdminDAO();
		
		ArrayList<MemberVO> vos = dao.getMemberList(level);
		
		// 등급레벨별 등급명칭을 저장한다.
//		String strLevel = "";
//		if(level == 0) strLevel = "관리자";
//		else if(level == 1) strLevel = "준회원";
//		else if(level == 2) strLevel = "정회원";
//		else if(level == 3) strLevel = "우수회원";
//		else strLevel = "전체회원";
		
		request.setAttribute("vos", vos);
		request.setAttribute("level", level);
//		request.setAttribute("strLevel", strLevel);
	}

}
