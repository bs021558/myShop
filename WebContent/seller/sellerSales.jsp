<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.goods.GoodsDAO" %>
<%@ page import="myshop.goods.GoodsDTO" %>
<%@ page import="myshop.shoporder.OrderDAO"%>
<%@ page import="java.util.List" %>
<h1>sellerSales페이지입니다.</h1>
<!-- 판매자 매출페이지 -->
<%
//세션 획득
    String user_id = (String)session.getAttribute("sessionId");
    //로그인되어 있지 않으면 loginForm.jsp파일로 리디렉트합니다.
    if(user_id==null)
  	{
		response.sendRedirect("/login/loginForm.jsp");
	}
    
  	//거래DB 접근 클래스
    OrderDAO odao = OrderDAO.getInstance();
  	
    //상품DB 접근 클래스
    GoodsDAO gdao = GoodsDAO.getInstance();
    
    //한 판매자의 상품 리스트
    int count = gdao.myGoodsCount(user_id);
    List goodsArray = gdao.myGoods(user_id);
%>
<table border="1">
	<tr>
		<td align="center">
			상품번호
		</td>
		<td align="center">
			상품이름
		</td>
		<td align="center">
			판매수량
		</td>
		<td align="center">
			매출
		</td>
		<td align="center">
			재고
		</td>
<%
	int goods_code = 0;
	int totalPrice = 0;
	try{
		//리스트 개수만큼 반복
		for(int i=0; i < goodsArray.size(); i++){
			//상품정보를 담을 dto객체 생성
			GoodsDTO gdto = new GoodsDTO();
			//GoodsDTO의 객체를 생성한 뒤 goodsList에서 i번째 goods_code를 꺼냅니다.
			goods_code = (int)goodsArray.get(i);
			//꺼낸 goods_code를 이용해 상품정보를 검색해서 gdto에 저장합니다.
			gdto = gdao.goodsDetail(goods_code);
%>
	<tr>
		<td align="center" width="100">
			<%=goods_code%>
		</td>
		<td align="center" width="250">
			<%=gdto.getGoods_name() %>
		</td>
		<td align="center" width="100">
		<!-- shoporder테이블을 통해서 해당 상품이 얼마나 팔렸는지 알 수 있습니다. -->
			<%=odao.sumAmount(goods_code) %>
		</td>
		<td align="center" width="100">
		<!-- shoporder테이블을 통해서 해당 상품이 얼마나 팔렸는지 알 수 있습니다. -->
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
		<td align="center">합계</td><td></td><td></td><td>
			<%=totalPrice%>
		</td><td></td>
		</tr>
</table>
<<jsp:include page="/contact/contactList.jsp"></jsp:include>
