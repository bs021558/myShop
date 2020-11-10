<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.order.OrderDAO" %>
<%@ page import="myshop.order.OrderDTO" %>
<%@ page import="myshop.goods.GoodsDAO" %>
<%@ page import="myshop.goods.GoodsDTO" %>
<%@ page import="java.util.ArrayList" %>
<h1>sellerSales페이지입니다.</h1>
<!-- 판매자 매출페이지 -->
<%
//세션 획득
    String user_id = (String)session.getAttribute("sessionId");
    //로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(user_id==null)
  	{
		response.sendRedirect("loginForm.jsp");
	}
    
  	//거래DB 접근 클래스
    OrderDAO odao = OrderDAO.getInstance();
  	
    //상품DB 접근 클래스
    GoodsDAO gdao = GoodsDAO.getInstance();
    
    //한 판매자의 상품 리스트
    ArrayList goodsList = new ArrayList();
    goodsList = gdao.myGoods(user_id);
%>
<table>
	<tr>
		<td>
			상품번호
		</td>
		<td>
			상품이름
		</td>
		<td>
			수량
		</td>
		<td>
			매출
		</td>
		<td>
			재고
		</td>
<%
	int goods_code = 0;
	int totalPrice = 0;
	try{
		for(int i=0; i<goodsList.size();i++){
			GoodsDTO gdto = new GoodsDTO();
			//GoodsDTO의 객체를 생성한 뒤 goodsList에서 i번째 데이터를 꺼내 보관합니다.
			gdto = (GoodsDTO)goodsList.get(i);
			goods_code = gdto.getGoods_code();
%>
	<tr>
		<td align="center" width="100">
			<%=goods_code%>
		</td>
		<td align="center" width="250">
			<%=gdto.getGoods_name() %>
		</td>
		<td align="center" width="100">
			<%=odao.sumAmount(goods_code) %>
		</td>
		<td align="center" width="100">
			<%=odao.sumTotal_price(goods_code) %>
		</td>
		<td align="center" width="100">
			<%=gdto.getGoods_count() %>
		</td>
	</tr>
<%
	//상품별 매출 누산
		totalPrice +=odao.sumTotal_price(goods_code);
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}
%>
	<tr>
		<td></td><td></td><td></td><td></td><td>
		<%=totalPrice%>
		</td>
</table>
