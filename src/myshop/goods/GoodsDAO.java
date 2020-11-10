package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class GoodsDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private static final GoodsDAO instance = new GoodsDAO();

	public static GoodsDAO getInstance() {
		return instance;
	}

	private GoodsDAO() {}

	public int getGoodsCount() {
		int goodscount = 0;

		try {
			conn = DBCon.getConnection();

			String sql = "select count(*) from goods";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next())
				goodscount = rs.getInt(1);

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return goodscount;
	}

	public void insertGoods(GoodsDTO dto) {
		try {
			conn =DBCon.getConnection();

			String sql = "insert into goods values(goods_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getGoods_brand());
			pstmt.setString(2, dto.getGoods_name());
			pstmt.setInt(3, dto.getGoods_price());
			pstmt.setString(4, dto.getGoods_delivery());
			pstmt.setInt(5, dto.getGoods_state());
			pstmt.setString(6, dto.getGoods_option());
			pstmt.setString(7, dto.getGoods_img());
			pstmt.setString(8, dto.getGoods_msg());
			pstmt.setInt(9, dto.getGoods_count());

			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
	}


	public List getGoodsList(int start, int end) {
		List goodsList=null;
		try {
			conn = DBCon.getConnection();

			String sql = "select goods_code, goods_img, goods_name, goods_price, rownum ";
			sql+= "from (select * from MyShopGoods order by goods_code desc) ";
			sql+= "where rownum >= ? and rownum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				goodsList = new ArrayList(end);
				do {
					GoodsDTO dto = new GoodsDTO();

					dto.setGoods_code(rs.getInt("goods_code"));
					dto.setGoods_img(rs.getString("goods_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_price(rs.getInt("goods_price"));

					goodsList.add(dto);

				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}	
		return goodsList;
	}

	public GoodsDTO goodsDetail(int code) { //
		GoodsDTO dto = null;
		try {
			conn = DBCon.getConnection();

			String sql = "select * from goods where goods_code = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new GoodsDTO();
				dto.setGoods_code(rs.getInt("goods_code"));
				dto.setGoods_brand(rs.getString("goods_brand"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_delivery(rs.getString("goods_delivery"));
				dto.setGoods_state(rs.getInt("goods_state"));
				dto.setGoods_option(rs.getString("goods_option"));
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

	public String code2name(int code) throws Exception {
		String goods_name = null;
		try
		{
			String sql = "select goods_name from goods where goods_code = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			goods_name = rs.getString(1);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return goods_name;
	}

	public String code2brand(int code) throws Exception {
		String goods_brand = null;
		try
		{
			String sql = "select goods_brand from goods where goods_code = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			goods_brand = rs.getString(1);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return goods_brand;
	}

	public ArrayList myGoods(String goods_brand) {
		ArrayList goodsList = null;
		try
		{
			String sql = "select goods_code from goods where goods_brand = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_brand);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					goodsList.add(rs.getInt("goods_code"));

				}while(rs.next());
			}
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return goodsList;
	}

	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {} }
		if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
		if(conn != null) {try{conn.close();}catch(SQLException s) {} }
	}

}
