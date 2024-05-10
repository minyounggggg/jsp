package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null? "" : request.getParameter("name");
		String gender = request.getParameter("gender")==null? "" : request.getParameter("gender");
		String birthday = request.getParameter("birthday")==null? "" : request.getParameter("birthday");
		String tel = request.getParameter("tel")==null? "" : request.getParameter("tel");
		String address = request.getParameter("address")==null? "" : request.getParameter("address");
		String email = request.getParameter("email")==null? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage")==null? "" : request.getParameter("homePage");
		String job = request.getParameter("job")==null? "" : request.getParameter("job");
		//String hobby = request.getParameter("hobby")==null? "" : request.getParameter("hobby");
		String photo = request.getParameter("photo")==null? "noimage.jpg" : request.getParameter("photo");
		String content = request.getParameter("content")==null? "" : request.getParameter("content");
		String userInfor = request.getParameter("userInfor")==null? "" : request.getParameter("userInfor");
		
		String[] hobbys = request.getParameterValues("hobby");
		
		String hobby = "";
		if(hobbys != null && hobbys.length != 0) {
			for(String h : hobbys) {
				hobby += h + "/";
			}
			hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		}
		
		// DB에 저장 시킬 자료중 not null 데이터는 Back End 체크시켜준다
		
		// 닉네임 중복 체크
		HttpSession session = request.getSession();
		String sNickName = (String) session.getAttribute("sNickName");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.MemberNickNameCheck(nickName);
		if(!sNickName.equals(nickName)) {
			if(vo.getNickName() != null) {
				request.setAttribute("message", "이미 사용중인 닉네임입니다.");
				request.setAttribute("url", "MemberUpdate.mem");
				return;
			}
		}
		
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장 처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setPhoto(photo);
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원정보가 수정되었습니다.");
			request.setAttribute("url", "MemberUpdate.mem");
		}
		else {
			request.setAttribute("message", "회원정보 수정 실패 !!");
			request.setAttribute("url", "MemberUpdate.mem");
		}
	}

}
