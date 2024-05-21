package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/member");		// 저장소, 서버에저장될 파일의 경로
		int maxSize = 1024 * 1024 * 5;			//서버에 저장시킬 파일의 최대용량 : 5MByte로 제한(1회저장용량)
		String encoding = "UTF-8";				//코드변환방식
		
		// 파일 업로드 처리...(객체 생성시 파일이 자동으로 업로드 된다.)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String mid = multipartRequest.getParameter("mid")==null? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd")==null? "" : multipartRequest.getParameter("pwd");
		String nickName = multipartRequest.getParameter("nickName")==null? "" : multipartRequest.getParameter("nickName");
		String name = multipartRequest.getParameter("name")==null? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender")==null? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday")==null? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel")==null? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address")==null? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email")==null? "" : multipartRequest.getParameter("email");
		String homePage = multipartRequest.getParameter("homePage")==null? "" : multipartRequest.getParameter("homePage");
		String job = multipartRequest.getParameter("job")==null? "" : multipartRequest.getParameter("job");
		//String hobby = request.getParameter("hobby")==null? "" : request.getParameter("hobby");
		// 서버에 저장된 파일 이름으로 저장해야하기 때문에 getFilesystemName으로 받아서 넘기기 getParmeter는 안됨
		String photo = multipartRequest.getFilesystemName("photo")==null? "" : multipartRequest.getFilesystemName("photo");
		String content = multipartRequest.getParameter("content")==null? "" : multipartRequest.getParameter("content");
		String userInfor = multipartRequest.getParameter("userInfor")==null? "" : multipartRequest.getParameter("userInfor");
		
		String[] hobbys = multipartRequest.getParameterValues("hobby");
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
		//UUID를 통한 salt키 만들기(앞에서 8자리를 가져왔다.)
		String salt = UUID.randomUUID().toString().substring(0,8);    //UUID를 변수에 담아서 비번에 더하기
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		pwd = salt + pwd;
		
		// 업로드된 파일의 정보 추출
		//String originalFileName = multipartRequest.getOriginalFileName("fName");  //업로드한 파일의 name
		//String filesystemName = multipartRequest.getFilesystemName("fName");
		// 백앤드 파일체크
//		if(originalFileName == null && originalFileName.equals("")) {
//			request.setAttribute("message", "파일을 선택해주세요");
//			request.setAttribute("url", "MemberJoin.mem");
//			return;
//		}
		
		
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
