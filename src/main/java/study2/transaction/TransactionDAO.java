package study2.transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TransactionDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	
	public TransactionDAO() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/javaclass";
		String user = "root";
		String password = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 연동 실패 ~ " + e.getMessage());
		} catch (SQLException e) {
			System.out.println("DB연동실패 ~ " + e.getMessage());
		}
	}
	
	public void connClose() {
		try {
			if(conn != null) conn.close();
		} catch (Exception e) {}
	}
	
	public void pstmtClose() {
		try {
			if(pstmt != null) pstmt.close();
		} catch (Exception e) {}
	}
	
	public void rsClose() {
		try {
			if(rs != null) rs.close();
			pstmtClose();
		} catch (Exception e) {}
	}

	
	//heowonㅌㅔ이블에서 아이디 검색후 성명 반환하기
	public String getIdSearch(String mid) {
		String name = "";
		try {
			sql = "select name from hoewon where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL오류 : " + e.getMessage());
		}finally {
			rsClose();
		}
		return name;
	}

	
	// bankBook의 정보 가져오기
	public ArrayList<BankBookVO> getBankBookList(String mid) {
		ArrayList<BankBookVO> vos = new ArrayList<>();
		try {
			sql = "select * from bankBook where mid=? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BankBookVO vo = new BankBookVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setBalance(rs.getInt("balance"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}
	
	
	// mid를 bankBook테이블에서 검색하여 해당항목의 idx를 구해온다
	public BankBookVO getBankBookMidSearch(String mid) {
		BankBookVO vo = new BankBookVO();
		try {
			sql = "select * from bankBook where mid = ? order by idx desc imit 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(mid);
				vo.setBalance(rs.getInt("balance"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	
	// BankBookHistory에 사용내역 저장하기
	public void setBankBookHistoryInput(BankBookVO vo) {
		try {
			// 트렌젝션 설정 : false를 인자값으로 설정하여 수동커밋으로 지정한다.
			conn.setAutoCommit(false);
			
			sql = "insert into bankBookHistory values (default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getIdx());
			pstmt.setString(2, vo.getContent());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
			try {
				if(conn != null) conn.rollback();  // 예외오류 발생시는 기존에 작업된 sql문이 모두 rollback된다.
			} catch (Exception e2) {}
		} finally {
			pstmtClose();
		}
	}

	// 실제잔고에 적용하기
	public void setBankBookInput(BankBookVO vo) {
		try {
			sql = "insert into bankBook values (default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setInt(2, vo.getBalance());
			pstmt.executeUpdate();
			
			// 정상적으로 트렌젝션 작업단위가 종료된후에 트랜젝션 커밋시칸다.
			conn.commit();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
			try {
				if(conn != null) conn.rollback();  // 예외오류 발생시는 기존에 작업된 sql문이 모두 rollback된다.
			} catch (Exception e2) {}
		} finally {
			pstmtClose();
		}
	}
}
