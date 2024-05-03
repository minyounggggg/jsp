package study.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import guest.GuestVO;

@SuppressWarnings("serial")
@WebServlet("/study/database/LoginList")
public class LoginList extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginDAO dao = new LoginDAO();
		
		String sortKey = request.getParameter("sortKey")==null ? "name" : request.getParameter("sortKey");
		
		
		
//		ArrayList<LoginVO> vos = dao.getLoginList(sortKey);
////		System.out.println("vos : " + vos);
//		
//		request.setAttribute("sortKey ", sortKey );
//		request.setAttribute("vos", vos);
		
		
		// 1. 현재 페이지 번호를 구해온다.
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag")); 
		
		// 2. 현재 페이지의 분량을 구한다.
		int pageSize = request.getParameter("pageSize")== null ? 5 : Integer.parseInt(request.getParameter("pageSize"));  //가운데 5는 기본페이지 표시
		if(pageSize > 5) pag = 1;
		
		// 3. 총 레코드 건수를 구한다. (sql 명령어 중 count 함수 이용)
		int totRecCnt = dao.getTotRecCnt();
		
		// 4. 총 페이지 건수를 구한다.
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) +1;
		
		// 5. 현재 페이지에서 출력할 '시작 인덱스번호'를 구한다.
		int startIndexNo = (pag-1) * pageSize;
		
		// 6. 현재 화면에 표시될 시작 실제 번호를 구한다.
		int curScrStarNO = (totRecCnt - startIndexNo);
		
		
		//블록페이징 처리
		int blockSize = 3;
		int curBlock = (pag-1) / blockSize;
		int lastBlock = (totPage-1) / blockSize;
		
		
		
		// 한페이지에 표시할 건수만(pageSize수 만큼)을 DAO에서 가져온다. (page
		ArrayList<LoginVO> vos = dao.getLoginList(sortKey, startIndexNo, pageSize);
		
		// 설정(지정) 된 페이지의 모든 자료(변수)들을 viewPage로 넘겨줄 준비를 한다.
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStarNO", curScrStarNO);
		
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		request.setAttribute("vos", vos);
		request.setAttribute("sortKey ", sortKey );
		
		
		String viewPage = "/study/database/loginMain.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
