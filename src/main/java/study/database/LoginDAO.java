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
	
	// 사용한 객체의 반납(conn반납))
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

	//전체회원 정보 검색   //이름순, 나이순, 번호순 정렬 버튼 만들어보기 (onChange)
	public ArrayList<LoginVO> getLoginList(String sortKey, int startIndexNo, int pageSize) {
		ArrayList<LoginVO> vos = new ArrayList<LoginVO>();
		try {
			sql = "select * from hoewon order by " + sortKey + " limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
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

	
	// 최근가입 3명회원 검색하기
	public ArrayList<LoginVO> getRecentFiveMember() {
		ArrayList<LoginVO> vos = new ArrayList<LoginVO>();
		try {
			sql = "select * from hoewon order by idx desc limit 3";
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

	
	//개별조회
	public ArrayList<LoginVO> getLoginSearch(String name) {
		ArrayList<LoginVO> vos = new ArrayList<LoginVO>();
		try {
			sql = "select * from hoewon where name like ? order by name";  //like 연산자 ->  한글자입력처리를 위한.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+name+"%");  // 요러케 한글자처리
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

	
	//idx로 검색처리
	public LoginVO getLoginIdxSearch(int idx) {
		LoginVO vo = new LoginVO();
		try {
			sql = "select * from hoewon where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
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

	
	//회원 정보 수정처리
	public int setLoginUpdate(LoginVO vo) {
		int res = 0;
		try {
			sql = "update hoewon set pwd=?, name=?, age=?, gender=?, address=? where idx=?";  //where idx 꼭 쓰기 안그럼 전부 수정됨!!!!
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPwd());
			pstmt.setString(2, vo.getName());
			pstmt.setInt(3, vo.getAge());
			pstmt.setString(4, vo.getGender());
			pstmt.setString(5, vo.getAddress());
			pstmt.setInt(6, vo.getIdx());             //매치, 순서 잘 되었는지 확인하기
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	
	//회원정보삭제
	public void setLoginDelete(String mid) {
		try {
			sql = "delete from hoewon where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	
	//전체 회원 건수를 구한다.
	public int getTotRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from hoewon";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}
}
