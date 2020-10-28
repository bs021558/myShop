package myshop.user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import myshop.alldb.DBCon;

public class UserDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public ArrayList selectAll() {
		ArrayList list = new ArrayList();	
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select * from myShopUser");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				dto.setJoin(rs.getString("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public void insert(UserDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "insert into myShopUser values(?,?,?,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getJoin());
			pstmt.setString(2, dto.getRating());
			pstmt.setString(3, dto.getUser_id());
			pstmt.setString(4, dto.getUser_pw());
			pstmt.setString(5, dto.getUser_name());
			pstmt.setString(6, dto.getUser_phone());
			pstmt.setString(7, dto.getUser_address());
			pstmt.setString(8, dto.getUser_cash());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean loginCheck(UserDTO dto) {
		boolean result = false;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from myShopUser where user_id=? and user_pw=? and join=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return result;
	}
	
			
	public UserDTO myInfo(String session_id) {
		UserDTO dto = new UserDTO();
		try {
			conn = DBCon.getConnection();
			String sql = "select * from myShopUser where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, session_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setJoin(rs.getString("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return dto;
	}
	
	public boolean userselId(String user_id) {
		boolean result = false;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from myShopUser where user_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return result;
	}
	

	public void userUpdate(UserDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "update myShopUser set user_pw=? , user_name=? , user_phone=? , user_address=? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_pw());
			pstmt.setString(2, dto.getUser_name());
			pstmt.setString(3, dto.getUser_phone());
			pstmt.setString(4, dto.getUser_address());
			pstmt.setString(5, dto.getUser_id());
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
				
	public void userDelete(String user_id) {
		try {
			conn = DBCon.getConnection();
			String sql = "update myShopUser set join=0 where user_id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {}}
		if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
		if(conn != null) {try {conn.close();}catch(SQLException s) {}}
	}
	
	public void cashUpdate(UserDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "update myShopUser set user_cash=? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_cash());
			pstmt.setString(2, dto.getUser_id());
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
}

