package myshop.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class OrderDAO {
	private static OrderDAO instance = new OrderDAO();

	public static OrderDAO getInstance() {
		return instance;
	}
	private OrderDAO() {}
	
	public static Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context j = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)j.lookup("jdbc/orcl");
		Connection conn = ds.getConnection();
		return conn;
	}

	public List getOrderList(String user_id, int start, int end) throws Exception {
		String sql = "select * "
				+ "from (select order_number, goods_code, buyer, seller, amount, total_price, track, order_date, rownum r "
				+ "from (select * from order order by order_date desc where buyer=?) order by orderDate desc) "
				+ "where r >= ? and r <= ?";
		List myOrderList = null;
		myOrderList = new ArrayList();
		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					OrderDTO order = new OrderDTO();
					order.setOrderNumber(rs.getInt("order_number"));
					order.setGoods_code(rs.getInt("goods_code"));
					order.setSeller(rs.getString("seller"));
					order.setBuyer(rs.getString("buyer"));
					order.setAmount(rs.getInt("amount"));
					order.setTotalPrice(rs.getInt("total_price"));
					order.setTrack(rs.getString("track"));
					order.setOrderDate(rs.getTimestamp("order_date"));
					myOrderList.add(order);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
		return myOrderList;
	}

	public int getOrderCount(String userId) throws Exception {
		String sql = "select count(*) from board where buyer=?";

		int x = 0;

		try {
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
		return x;
	}

	public void closeAll() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException ex) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException ex) {
			}
		}
	}
}
