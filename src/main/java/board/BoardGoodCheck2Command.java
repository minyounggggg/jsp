package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardGoodCheck2Command implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요 수 증가처리 (중복 불허)
		String sw = "0";
		HttpSession session = request.getSession(); //게시글을 보는순간 세션이 생긴다.
		ArrayList<String> contentGood = (ArrayList<String>)session.getAttribute("sContentGood");
		if(contentGood == null) contentGood = new ArrayList<String>();
		String imsiContentGood = "boardGood" + idx;
		if(!contentGood.contains(imsiContentGood)) {  //"contains"= 포함하고있냐는 명령 / (imsiContentReadNum를 포함하고있니?)
			dao.setBoardGoodCheck(idx);
			contentGood.add(imsiContentGood);
			sw = "1";
		}
		session.setAttribute("sContentGood", contentGood);
		
		response.getWriter().write(sw);
	}

}
