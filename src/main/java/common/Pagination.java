package common;

import javax.servlet.http.HttpServletRequest;

import board.BoardDAO;
import guest.GuestDAO;

public class Pagination {
	
	public static void pageChange(HttpServletRequest request, int pag, int pageSize, String part) {
//		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag")); 
//		int pageSize = request.getParameter("pageSize")== null ? 10 : Integer.parseInt(request.getParameter("pageSize"));  //가운데 5는 기본페이지 표시
		
		int totRecCnt = 0;
		if(part.equals("board")) {
			BoardDAO dao = new BoardDAO();
		    totRecCnt = dao.getTotRecCnt();
		}
		else {
			GuestDAO dao = new GuestDAO();
			totRecCnt = dao.getTotRecCnt();
		}
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) +1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStarNO = (totRecCnt - startIndexNo);
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage -1) / blockSize;
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStarNO", curScrStarNO);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
	}
}
