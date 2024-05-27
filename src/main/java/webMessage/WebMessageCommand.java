package webMessage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WebMessageCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		int idx = request.getParameter("idx")==null ? 0 :Integer.parseInt(request.getParameter("idx"));
		int mSw = request.getParameter("mSw")==null ? 1 :Integer.parseInt(request.getParameter("mSw"));
		int mFlag = request.getParameter("mFlag")==null ? 0 :Integer.parseInt(request.getParameter("mFlag"));
		
		WebMessageDAO dao = new WebMessageDAO();
		WebMessageVO vo = null;
		
		if(mSw == 6) {
			vo = dao.getWebMessageContent(idx, mFlag);
			request.setAttribute("vo", vo);
		}
		else  {
			// 페이징처리하기
			
			ArrayList<WebMessageVO> vos = dao.getMessageList(mid, mSw);
			request.setAttribute("vos", vos);
		}
		request.setAttribute("mSw", mSw);
		request.setAttribute("mFlag", mFlag);
	}

}
