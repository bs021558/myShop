package myshop.seller_board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import myshop.alldb.DBCon;

public class Seller_boardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static final Seller_boardDAO instance = new Seller_boardDAO();
	
    public static Seller_boardDAO getInstance() {
        return instance;
    }
    
    private Seller_boardDAO() {}
    
    public void insertContact(Seller_boardDTO sbdto) {
    	try {
			Connection conn = DBCon.getConnection();

			String sql = "insert into seller_board values(seller_board_seq.nextval, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sbdto.getOrder_number());
			pstmt.setString(2, sbdto.getUserId());
			pstmt.setString(3, sbdto.getSubject());
			pstmt.setString(4, sbdto.getEmail());
			pstmt.setString(5, sbdto.getContent());
			pstmt.setTimestamp(6, sbdto.getDate());
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
    }
    
	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {} }
		if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
		if(conn != null) {try{conn.close();}catch(SQLException s) {} }
	}

}
