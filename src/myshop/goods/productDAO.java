package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import myShop.conn.DBCon;

public class ProductDAO {

	private static ProductDAO instance = new ProductDAO();

	private ProductDAO() {
	}

	public static ProductDAO getInstance() {
		return instance;
	}

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public void insertProduct(ProductDTO product) {//»óÇ°µî·Ï
		try {
			conn = DBCon.getConnection();

			String sql = "insert into MyShopGoods values(Goods.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getGoods_brand());
			pstmt.setString(2, product.getGoods_name());
			pstmt.setInt(3, product.getGoods_price());
			pstmt.setString(4, product.getGoods_delivery());
			pstmt.setInt(5, product.getGoods_state());
			pstmt.setString(6, product.getGoods_img());
			pstmt.setString(7, product.getGoods_msg());
			pstmt.setInt(8, product.getGoods_count());

			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}

	}
	public String getCode2Name(int code) throws Exception
    	{
       		String getStr = null;
       		try
       		{
         		String sql = "select goods_name from MyShopGoods where goods_code = ?";
         		conn = DBCon.getConnection();
         		pstmt = conn.prepareStatement(sql);
         		pstmt.setInt(1, code);
         		rs = pstmt.executeQuery();
         		getStr = rs.getString(1);
       		}
       		catch (Exception ex) 
       		{
         		ex.printStackTrace();
       		}
       		finally
       		{
          		closeAll();
       		}
       
       		return getStr;
	}
	private void closeAll() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException s) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException s) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException s) {
			}
		}
	}
}