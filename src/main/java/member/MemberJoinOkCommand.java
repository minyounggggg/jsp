package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null? "" : request.getParameter("pwd");
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
		if(hobbys.length != 0) {
			for(String h : hobbys) {
				hobby += h + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// DB에 저장 시킬 자료중 not null 데이터는 Back End 체크시켜준다
		
		// 아이디, 닉네임 중복체크,,
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("message", "이미 사용중인 아이디입니다.");
			request.setAttribute("url", "MemberJoin.mem");
			return;
		}
		
		dao = new MemberDAO();
		vo = dao.MemberNickNameCheck(nickName);
		if(vo.getNickName() != null) {
			request.setAttribute("message", "이미 사용중인 닉네임입니다.");
			request.setAttribute("url", "MemberJoin.mem");
			return;
		}
		
		//비밀번호 암호화(SHA256) - salt키를 만든 후 암호화 시켜준다.(uuid코드중 앞자리 8자리 같이 병행처리 후 암호화시킨다.)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장 처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
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
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원가입 되었습니다. \\n다시 로그인해주세요.");
			request.setAttribute("url", "MemberLoin.mem");
		}
		else {
			request.setAttribute("message", "회원 가입 실패 !!");
			request.setAttribute("url", "MemberJoin.mem");
		}
	}
}
