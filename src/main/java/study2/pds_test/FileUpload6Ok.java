package study2.pds_test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
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
@WebServlet("/FileUpload6Ok")
public class FileUpload6Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest requset, HttpServletResponse response) throws ServletException, IOException {
		String realPath = requset.getServletContext().getRealPath("/images/pds_test/");
		
		// request 객체 내부 getParts() 메소드를 사용하여 배열로 받는다.
		Collection<Part> fileParts = requset.getParts();
		
		for(Part filePart : fileParts) {
			if(!filePart.getName().equals("fName")) continue; // continue스킵 // 같은 파일이 있다면 스킵을 해버려서 null로들어가게하지않고 파일이 저장안되게함
			if(filePart.getSize() == 0) continue;
			
			String fileName = filePart.getSubmittedFileName();
			InputStream fis = filePart.getInputStream();
			
			String uid = UUID.randomUUID().toString().substring(0, 8);  //0번째부터 8번쨰까지
			fileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uid + fileName.substring(fileName.lastIndexOf("."));
			
			FileOutputStream fos = new FileOutputStream(realPath + uid + fileName);
			
			byte[] buffer = new byte[2048];
			int size = 0;
			//-1이 아닐때까지 돌아라 (자료가 없을떄까지)
			while((size = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, size);
			}
			fos.close();
			fis.close();
		}
		
		requset.setAttribute("message", "파일이 업로드 되었씁니다.");
		requset.setAttribute("url", "FileUpload6.st");
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = requset.getRequestDispatcher(viewPage);
		dispatcher.forward(requset, response);
	}
}
