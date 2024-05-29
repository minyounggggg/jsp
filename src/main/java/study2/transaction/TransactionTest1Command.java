package study2.transaction;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyDAO;
import study2.StudyInterface;

public class TransactionTest1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String bankFlag = request.getParameter("bankFlag")==null ? "" : request.getParameter("bankFlag");
		int money = (request.getParameter("money")==null || request.getParameter("money").equals("")) ? 0 : Integer.parseInt(request.getParameter("money"));
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		if(bankFlag.equals("출금")) money *= (-1);
		
		try {
			StudyDAO dao = new StudyDAO();
			
			// mid를 bankBook테이블에서 검색하여 해당항목의 idx를 구해온다
			BankBookVO bVo = dao.getBankBookMidSearch(mid);
			
			BankBookVO vo = new BankBookVO();
			vo.setIdx(bVo.getIdx());
			vo.setMid(mid);
			vo.setBalance(money);
			vo.setContent(content);
			
			// 입/출금 내역에 기록하기
			dao.setBankBookHistoryInput(vo);
			
			// 실제 잔고에 적용하기
			dao.setBankBookInput(vo);
			
			if(request.getParameter("error")!=null){
		        throw new Exception("ㅂ진행 오류 발생 !!");
		    }
			else {
				request.setAttribute("message", "BankBookInputOk");
			}
			request.setAttribute("url", "BankBookInputNo.st");
			} catch (Exception e) {
				System.out.println("예외오류발생 : " + e.getMessage());
		}
	}

}
