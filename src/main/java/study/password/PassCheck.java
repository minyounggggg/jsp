package study.password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/study/password/PassCheck")
public class PassCheck extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") ==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") ==null ? "" : request.getParameter("pwd");
		int idx = request.getParameter("idx") ==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		System.out.println("원본자료 : ");
		System.out.println("idx : " + idx);
		System.out.println("mid : " + mid);
		System.out.println("pwd : " + pwd);
		
		if(idx==1) {
			// 숫자만을 암호화 하는 경우... 암호키(0x1234ABCD)
			int key = 0x1234ABCD;
			int encPwd, decPwd;
			encPwd = Integer.parseInt(pwd) ^ key;  //익스큐시브오아연산..?
			
			System.out.println("인코딩한 비밀번호 : " + "0x1234ABCD"+encPwd);
			System.out.println("앞에서 인코딩(암호화)된 pwd를 DB에 저장처리한다. : ");
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			System.out.println("DB에 저장된 pwd를 다시 불러와서 디코딩 처리한다.");
			
			decPwd = encPwd ^ key;
			
			System.out.println("디코딩(복호화)한 비밀번호 : " + decPwd);
			System.out.println("로그인 인증처리한다.");
			System.out.println("~~~~~~~~~~~~~ The End ~~~~~~~~~~~~~~");
		}
		else if (idx == 2) {
			// 숫자 또는 문자 또는 조합으로 암호화 하는 방법
			// 예) 문자 A로 전송되면 A의 아스키코드를 변형처리해서 암호화한다.
			long intPwd;
			String strPwd = "";
			
			//입력받은 암호를 한문자씩 꺼내어서 아스키코드로 변형한 뒤, 문자로 누적처리해서 만들어준다.
			for(int i=0; i<pwd.length(); i++) {
				intPwd = (long)pwd.charAt(i);
				strPwd += intPwd;
			}
			System.out.println("strPwd(아스키코드문자로 변환된 비밀번호 : " + strPwd);
			
			intPwd = Long.parseLong(strPwd);  //레퍼클래스?
			
			// 암호화 시킬 salt키를 선정...
			long key = 0x1234ABCD;
			String soltKey = "1234ABCD";
			long encPwd;
			
			encPwd = intPwd ^ key;
			
			strPwd = String.valueOf(encPwd);
			
			// 암호화된 코드와 salt키를 합쳐서 DB에 저장처리한다.
			System.out.println("인코딩(암호화)된 비밀번호(DB에 저장될 비밀번호) : " + strPwd);
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			
			// 다시 로그인 할때 DB의 비밀번호를 가져와서 복호화 시켜준다.
			long decPwd;
			intPwd = Long.parseLong(strPwd);
			decPwd = intPwd ^ key;
			System.out.println("디코딩(복호화)된 비밀번호 : " + decPwd);
			
			// 복호화된 비밀번호는 숫자이기에 문자로 변환 후 2개씩 문자 처리한다.
			strPwd = String.valueOf(decPwd);
			
			String result = "";
			char ch;
			
			//문자로 변형된 복호화 코드를 각각 2자리씩 잘라서 문자로 변환후 누적처리... 처음 비밀번호화 비교한다.
			for(int i=0; i<strPwd.length(); i+=2){
				ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
				result += ch;
			}
			System.out.println();
			System.out.println("최종 변환된 비밀번호(원본 비번과 비교하시오) : " + result);
		}
	}
}
