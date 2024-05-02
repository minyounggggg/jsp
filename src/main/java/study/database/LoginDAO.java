package study.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LoginDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	LoginVO vo = null;
	
	public LoginDAO() {
		String url = "jdbc:mysql://localhost:3306/javaclass";
		String user = "root";
		String password = "1234";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");  //예외처리하기 
			conn = DriverManager.getConnection(url, user, password);
				System.out.println("연결성공입니다. 잘했습니다~");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패슨~~ : "+ e.getMessage());
		} catch (SQLException e) {
			System.out.println("데이터베이스 연동 실패슨~~ : "+ e.getMessage());
		}
	}
	
	// 사용한 객체의 반납(conn반납)
	public void connClose() {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {}
			
		}
	}
	
	// 사용한 객체의 반납(pstmt반납)
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
			
		}
	}
	
	//rs 객체의 사용반납
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {}
			
		}
	}

	//아이디 체크
	public LoginVO getLoginIdCheck(String mid, String pwd) {
		LoginVO vo = new LoginVO();
		try {
			sql = "select * from hoewon where mid=? and pwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getNString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setGender(rs.getString("gender"));
				vo.setAddress(rs.getString("address"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();     //select쓰면 rsClose
		}
		return vo;
	}

	//전체회원 정보 검색
	public ArrayList<LoginVO> getLoginList() {
		ArrayList<LoginVO> vos = new ArrayList<LoginVO>();
		try {
			sql = "select * from hoewon order by name";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new LoginVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getNString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setGender(rs.getString("gender"));
				vo.setAddress(rs.getString("address"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose(); 
		}
		return vos;
	}

	
	//회원가입처리
	public int setLoginInput(LoginVO vo) {
		int res = 0;
		try {
			sql = "insert into hoewon values (default, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setInt(4, vo.getAge());
			pstmt.setString(5, vo.getGender());
			pstmt.setString(6, vo.getAddress());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
}
