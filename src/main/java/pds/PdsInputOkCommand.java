package pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class PdsInputOkCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/pds");
		int maxSize = 1024* 1024 * 30;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 업로드된 파일의 정보를 추출
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String file = "";
		String oFileName = "";
		String fSName = "";
		
		// hasMoreElements-> 이 안에 필요한 정보가잇느냐
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			
			if(multipartRequest.getFilesystemName(file) != null) {
				oFileName += multipartRequest.getOriginalFileName(file) + "/";		// 실제파일 원본 이름을 oFileName에 저장
				fSName += multipartRequest.getFilesystemName(file) + "/";			// 저장된 이름을 fsName에 저장
			}
		}
		oFileName = oFileName.substring(0, oFileName.lastIndexOf("/"));
		fSName = fSName.substring(0, fSName.lastIndexOf("/"));
		
		//업로드시킨 파일을 DB에 저장 시키기 위해서 전송된 폼의 내용들을 모듀 변수에 담아준다.
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		int fSize = multipartRequest.getParameter("fSize")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("fSize"));
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String part = multipartRequest.getParameter("part")==null ? "" : multipartRequest.getParameter("part");
		String openSw = multipartRequest.getParameter("openSw")==null ? "" : multipartRequest.getParameter("openSw");
		String pwd = multipartRequest.getParameter("pwd")==null ? "" : multipartRequest.getParameter("pwd");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		
		
		// 비밀번호 암호화(SHA256) - salt 적용처리하지않음
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 가공처리된 모든 자료들을 VO에 담아서 DB에 저장하낟.
		PdsVO vo = new PdsVO();
		
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setfName(oFileName);
		vo.setfSName(fSName);
		vo.setfSize(fSize);
		vo.setTitle(title);
		vo.setPart(part);
		vo.setOpenSw(openSw);
		vo.setPwd(pwd);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		PdsDAO dao = new PdsDAO();
		int res = dao.setPdsInputOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "자료실에 자료가 업로드 되었습니다.");
			request.setAttribute("url", "PdsList.pds");
		}
		else {
			request.setAttribute("message", "자료실에 자료가 업로드 실패.");
			request.setAttribute("url", "PdsInput.pds");
		}
		
	}

}
