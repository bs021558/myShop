package myshop.shoporder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;
import myshop.shoporder.OrderDTO;

public class OrderDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private static OrderDAO instance = new OrderDAO();

	private OrderDAO() {}

	public static OrderDAO getInstance() {
		return instance;
	}

	public boolean contactCheck(int order_number, String user_id) throws Exception{
		//입력받은 order_number, userId와 일치하는 정보가 있으면 true를 리턴합니다.
		String sql = "select * from shoporder where order_number = ? user_id = ?";
	
		boolean result = false;
		
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			pstmt.setString(2, user_id);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = true;
			} 		
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
		return result;
	}
	
	public ArrayList getOrderList(String user_id, int preMonths, int nextMonths, int start, int end) throws Exception {
		//입력받은 개월 수 동안의 주문만 가져옵니다.
		//order_number의 중복을 제거하기 위해 order_number로 그룹을 묶어 각 그룹의 첫번째 행만 검색합니다.
		String sql = "select * from";
			   sql+= 	"(select order_number, goods_code, total_price, track, order_date, rownum r  from";
			   sql+= 		"(select * from ";
			   sql+=        	"(select a.*, row_number() over (partition by a.order_number order by order_date) as num from ";
			   sql+=            	"shoporder a)"; 
			   sql+=        "where num = 1)";
			   sql+=    "where user_id = ? and order_date >= add_months(sysdate,-?) and order_date <= add_months(sysdate,-?))";
			   sql+= "where r>=? and r<=?";

		ArrayList myOrderList = null;
		myOrderList = new ArrayList();
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, preMonths);
			pstmt.setInt(3, nextMonths);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					OrderDTO odto = new OrderDTO();
					odto.setOrder_pk(rs.getInt("order_pk"));
					odto.setOrder_number(rs.getInt("order_number"));
					odto.setGoods_code(rs.getInt("goods_code"));
					odto.setRe_name(rs.getString("re_name"));
					odto.setRe_phone(rs.getString("re_phone"));
					odto.setRe_address(rs.getString("re_address"));
					odto.setAmount(rs.getInt("amount"));
					odto.setTotalPrice(rs.getInt("total_price"));
					odto.setTrack(rs.getString("track"));
					odto.setOrderDate(rs.getTimestamp("order_date"));
					myOrderList.add(odto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
		return myOrderList;
	}

	public String getUser_id(int order_number) throws Exception{//order_number를 입력해서 user_id를 검색해 반환합니다.
		String sql="select user_id from shoporder where order_number =?";		
		String user_id=null;
		try{
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			rs = pstmt.executeQuery();
			user_id=rs.getString(1);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			closeAll();
		}
		return user_id;
	}
	
	public Timestamp getOrder_date(int order_number) throws Exception{//order_number를 입력해서 user_id를 검색해 반환합니다.
		String sql="select order_date from shoporder where order_number =?";		
		Timestamp order_date = null;
		try{
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			rs = pstmt.executeQuery();
			order_date=rs.getTimestamp(1);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			closeAll();
		}
		return order_date;
	}
	
	public int getNewOrderNumber(String user_id) throws Exception{
		//주문번호를 결정하기 위해 이전 주문번호의 최대값을 검색합니다.	
		String sql1="select max(order_number) from shoporder where user_id =?";	 
		int new_order_number = 0;
		try{
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
					
			if (rs.next()) {//마지막 주문번호+1을 주문번호로 설정첫 주문이면 1
				new_order_number=rs.getInt(1)+1;
			}else{
				new_order_number=1;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			closeAll();
		}
		return new_order_number;
	}
	
	public void insertOrder(OrderDTO dto, int order_number) throws Exception{
		//주문을 입력합니다. 여러 상품이 같은 주문번호로 저장됩니다.
		String sql = "insert into shoporder";
			   sql+="(order_pk, order_number, goods_code, user_id, re_name, re_phone, re_address, amount, total_price, track, order_date) ";
			   sql+="values(order_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
			
		try{
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			pstmt.setInt(2, dto.getGoods_code());
			pstmt.setString(3, dto.getUser_id());
			pstmt.setString(4, dto.getRe_name());
			pstmt.setString(5, dto.getRe_phone());
			pstmt.setString(6, dto.getRe_address());
			pstmt.setInt(7, dto.getAmount());
			pstmt.setInt(8, dto.getTotal_price());
			pstmt.setString(9, dto.getTrack());
			pstmt.setTimestamp(10, dto.getOrder_date());
			pstmt.executeUpdate();
	     }catch(Exception ex) {
	    	 ex.printStackTrace();
	     }finally {
	    	 closeAll();
	     }
	}
	
	public int getCountGoodsInOrder(int order_number) throws Exception{
		String sql = "select count(*) from shoporder where order_number=?";
		int count = 0;
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			rs = pstmt.executeQuery();
			count = rs.getInt(1);
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			closeAll();
		}
		return count;
	}
	
	public ArrayList getOrderDetail(int order_number) throws Exception{
		ArrayList orderDetail = null;
		String sql = "select * from shoporder where order_number=?";
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
                orderDetail = new ArrayList();
                do{
                	OrderDTO odto = new OrderDTO();
                	odto.setOrder_pk(rs.getInt("order_pk"));
                	odto.setOrder_number(rs.getInt("order_number"));
                	odto.setGoods_code(rs.getInt("goods_code"));
                	odto.setRe_name(rs.getString("re_name"));
                	odto.setRe_phone(rs.getString("re_phone"));
                	odto.setRe_address(rs.getString("re_address"));
                	odto.setAmount(rs.getInt("amount"));
                	odto.setTotalPrice(rs.getInt("total_price"));
                	odto.setTrack(rs.getString("track"));
                	odto.setOrderDate(rs.getTimestamp("order_date"));
                	orderDetail.add(odto);
                }while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			closeAll();
		}
		return orderDetail;
	}
	
	public int getOrderCount(String user_id) throws Exception {
		int x=0;
		try {
			conn = DBCon.getConnection();
		    pstmt = conn.prepareStatement("select count(*) from shoporder");
		    rs = pstmt.executeQuery();
		    if (rs.next()) {
		        x= rs.getInt(1);
			}
		} catch(Exception ex) {
		     ex.printStackTrace();
		} finally {
			 closeAll();
		}
		return x;
	}
	
	public int sumAmount(int goods_code) {
		int x=0;
		try {
			conn = DBCon.getConnection();
		    pstmt = conn.prepareStatement("select sum(amount) from shoporder where goods_code=?");
		    pstmt.setInt(1, goods_code);
		    rs = pstmt.executeQuery();
		    if (rs.next()) {
		        x= rs.getInt(1);
			}
		} catch(Exception ex) {
		     ex.printStackTrace();
		} finally {
			 closeAll();
		}
		return x;
	}
	
	public int sumTotal_price(int goods_code) {
		int x=0;
		try {
			conn = DBCon.getConnection();
		    pstmt = conn.prepareStatement("select sum(total_price) from shoporder where goods_code=?");
		    pstmt.setInt(1, goods_code);
		    rs = pstmt.executeQuery();
		    if (rs.next()) {
		        x= rs.getInt(1);
			}
		} catch(Exception ex) {
		     ex.printStackTrace();
		} finally {
			 closeAll();
		}
		return x;
	}
	
	public void closeAll() {

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
