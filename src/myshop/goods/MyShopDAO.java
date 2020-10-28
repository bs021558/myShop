package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class MyShopDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static MyShopDAO instance = new MyShopDAO();
    
    public static MyShopDAO getInstance() {
        return instance;
    }
    
    private MyShopDAO() {
    }
	
/// 1.�뜲�씠�꽣 �꽭湲�
	public int getAlbumCount() {
		int totalAlbumCount = 0;
		
		try {
			conn = DBCon.getConnection();
			
			String sql = "select count(*) from MyShopgoods";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				totalAlbumCount = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return totalAlbumCount;
	}
	

		
//2. �뙆�씪�뜲�씠�꽣 �쟾泥댁“�쉶
	public List getAlbums(int start, int end) {
		List albumList=null;
		try {
			conn = DBCon.getConnection();
			
			String sql;
			sql = "select goods_code, goods_img, goods_name, goods_price, rownum from (select * from MyShopGoods order by goods_code desc) where rownum>=? and rownum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				albumList = new ArrayList(end);
				do {
					MyShopDTO dto = new MyShopDTO();
					dto.setGoods_code(rs.getInt("goods_code"));
					dto.setGoods_img(rs.getString("goods_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_price(rs.getString("goods_price"));
					
					albumList.add(dto);
				
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}	
		return albumList;
	}

//�긽�뭹�긽�꽭�럹�씠吏�
	public MyShopDTO detailProduct(int code) {
		MyShopDTO dto = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from MyShopGoods where goods_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MyShopDTO();
				dto.setGoods_code(rs.getInt("goods_code"));
				dto.setGoods_brand(rs.getString("goods_brand"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getString("goods_price"));
				dto.setGoods_delivery(rs.getString("goods_delivery"));
				dto.setGoods_state(rs.getInt("goods_state"));
				//dto.setGoods_option(rs.getString("option"));
				dto.setGoods_img(rs.getString("goods_img"));
				dto.setGoods_msg(rs.getString("goods_msg"));
				dto.setGoods_count(rs.getInt("goods_count"));
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				closeAll();
			}
			return dto;
			}
		
	
	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {} }
		if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
		if(conn != null) {try{conn.close();}catch(SQLException s) {} }
	}

}
