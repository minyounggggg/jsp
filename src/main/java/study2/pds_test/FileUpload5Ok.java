package study2.pds_test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
	// location = "/경로명",
	fileSizeThreshold = 1024 * 1024, 		//업로드시에 메모리에 저장되는 임시 파일 크기 설정(int) 
	maxFileSize = 1024 * 1024 * 5, 			//업로드시 1개 파일의 최대용량은 5MByte
	maxRequestSize = 1024 * 124 * 5 * 10 	// 한번에 request 시에 전송할 파일의 최대크기(long)
)
@SuppressWarnings("serial")
@WebServlet("/FileUpload5Ok")
public class FileUpload5Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest requset, HttpServletResponse response) throws ServletException, IOException {
		String realPath = requset.getServletContext().getRealPath("/images/pds_test/");
		
		// request 객체 내부 getPart() 메소드를 사용하여 업로드되는 1개 파일의 정보를 받는다.
		
		Part filePart = requset.getPart("fName");  //form태그의 file속성의 name명을 적는다ㅣ.
		String fileName = filePart.getSubmittedFileName();  //클라이언트에서 전송한 파일이름
		//자바는 뮤조건 올리는곳 받는곳 있어야함 인풋, 아웃풋
		InputStream fis = filePart.getInputStream();  // 파일 입력스트림생성
		
		// 파일명 중복 방지를 위한 처리 (atom.jpg --> atom_5djwi83y.jpg)
		String uid = UUID.randomUUID().toString().substring(0, 8);  //0번째부터 8번쨰까지
		fileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));
		
		FileOutputStream fos = new FileOutputStream(realPath + uid + fileName);  // 파일 출력 스트림 생성
		
		// 전송괴는 파일을 2048Byte단위로 버퍼에 읽어서 서버파일 시스템에 저장한다.
		byte[] buffer = new byte[2048];
		int size = 0;
		//-1이 아닐때까지 돌아라 (자료가 없을떄까지)
		while((size = fis.read(buffer)) != -1) {
			fos.write(buffer, 0, size);
		}
		fos.close();
		fis.close();
		
		requset.setAttribute("message", "파일이 업로드 되었씁니다.");
		requset.setAttribute("url", "FileUpload5.st");
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = requset.getRequestDispatcher(viewPage);
		dispatcher.forward(requset, response);
	}
}
