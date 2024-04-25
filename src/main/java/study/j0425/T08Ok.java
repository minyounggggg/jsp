package study.j0425;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet ("/j0425/T08Ok")
public class T08Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("uft-8");
		response.setContentType("text/html; charset=utf-8");
		
		String[] img2 = request.getParameterValues("img2");
		
		System.out.println("img2 : " + img2);
		
		
	}
}
