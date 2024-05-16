package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Pagination;
// 첫번쨰연습
public class BoardListCommand3 implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		
		// 페이징처리 시작
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag")); 
		int pageSize = request.getParameter("pageSize")== null ? 10 : Integer.parseInt(request.getParameter("pageSize"));  //가운데 5는 기본페이지 표시
		String part = request.getParameter("part")== null ? "전체" : request.getParameter("part");
		int totRecCnt = dao.getTotRecCnt();  //게시판의 전체 레코드 수 구하기
		
		int startIndexNo = (pag - 1) * pageSize;
		ArrayList<BoardVO> vos = dao.getBoardList(startIndexNo, pageSize);  // 게시판의 전체 자료가져오기
		request.setAttribute("vos", vos);
		
		//Pagination.pageChange(request, pag, pageSize, totRecCnt, startIndexNo, part);
		
	}

}
