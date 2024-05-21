package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Pagination;

public class PdsListCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pagSize = request.getParameter("pagSize")==null ? 5 : Integer.parseInt(request.getParameter("pagSize"));
		String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		
		//PdsDAO dao = new PdsDAO();
	
		Pagination.pageChange(request, pag, pagSize, "", "pds", part);
	}

}
