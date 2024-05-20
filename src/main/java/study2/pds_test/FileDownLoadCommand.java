package study2.pds_test;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class FileDownLoadCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/pds_test");
		
		String[] files = new File(realPath).list();
		
		for(String file : files) {
			System.out.println("file : " + file);
		}
		
		request.setAttribute("files", files);
	}

}
