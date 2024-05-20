package study2.pds_test;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("fileName")==null? "" : request.getParameter("fileName");
		
		String realPath = request.getServletContext().getRealPath("/images/pds_test/");
		
		File file = new File(realPath + fileName);
		
		String res = "0";
		if(file.exists()) {		//파일이 존재하니? 존재하면 지워라ㅣ
			file.delete();
			res = "1";
		}
		
		response.getWriter().write(res);
		
	}

}
