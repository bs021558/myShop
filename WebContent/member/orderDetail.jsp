<%@page import="myshop.shoporder.OrderDTO"%>
<%@page import="myshop.shoporder.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="myshop.goods.GoodsDAO"%>
<%@ page import="myshop.goods.GoodsDTO"%>
<h1>myOrder 페이지입니다.</h1>

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
    
	int order_number = Integer.parseInt(request.getParameter("order_number"));
	boolean security = odao.contactCheck(order_number, user_id);
	//열람하려는 주문상세페이지의 주문번호와 ID가 대응하지 않으면 경고창을 통해 index.jsp로 리디렉트합니다.
	if(security == false){
%>
<script>
	alert("잘못된 접근입니다.");
	window.location="index.jsp";
</script>
<%	
	}
	
    //CJ대한통운주소
    String cjtrack = "https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=";
  
    //주문가져오기
  	ArrayList listInOrder = new ArrayList();
  	listInOrder = odao.getOrderDetail(order_number);
    
    //goods_code 보관 변수
    int goods_code = 0;
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	 <td align="center">
	  <br><br>
	      <h2>주문번호: <%=order_number%></h2><br>
	      <h2>주문날짜: <%=odao.getOrder_date(order_number)%></h2><br>
	  <br><br>
	 </td>
	<tr height="30" bgcolor="white">
	    <td align="center" width="100">상품이미지</td>
		<td align="center" width="250">상품</td>
		<td align="center" width="50">옵션</td>
		<td align="center" width="50">수량</td>
		<td align="center" width="100">금액</td>
		<td align="center" width="100">판매자</td>
		<td align="center" width="100">운송장번호</td>
	</tr>
<%  
		for (int i = 0 ; i < listInOrder.size() ; i++) 
		{
			//OrderDTO의 객체를 생성한 뒤 listInOrder에서 i번 째 데이터를  꺼내 보관합니다.
			OrderDTO odto = new OrderDTO();
			odto = (OrderDTO)listInOrder.get(i);
        	//GoodsDTO객체를 생성합니다.
        	GoodsDTO gdto = new GoodsDTO();
        	//orderList의 i번 째 데이터에서 외래키인 goods_code를 꺼냅니다.
        	goods_code = odto.getGoods_code();
        	//goods_code를 이용해서 해당 상품의 정보를 객체 gdto에 보관합니다.
        	gdto = gdao.goodsDetail(goods_code);
%>
	<tr height="30">
		<td align="center" width="150">
	  	 <a href="content.jsp?code=<%=gdto.getGoods_code()%>">
	  	 <img src="<%=gdto.getGoods_img()%>"/>
	  	 </a>
	 	</td>
		<td align="center" width="100">
		 <a href="orderDetail.jsp">
		  <%=odto.getOrder_number()%>
		 </a>
		</td>
		<td width="250">
		 <!-- 누르면 새창에서 제품상세페이지 열기  -->
		 <a href="content.jsp?code=<%=gdto.getGoods_name()%>" onclick="window.open('this.href')">
		  <%=gdto.getGoods_name() %>
		 </a> 
		</td>
		<td align="center" width="100">
		 <%=gdto.getGoods_option() %>
		</td>
		<td align="center" width="50">
		 <%= odto.getAmount()%>
		</td>
		<td align="center" width="50">
		 <%= odto.getTotal_price()%>
		</td>
		<td align="center" width="100">
		 <ul> 
		  <li>
		   <%=gdto.getGoods_brand() %>
		  </li> 
		  <li>
		   <form action="contactForm.jsp" method="post">
    		 <input type="hidden" name="order_number" value="<%=odto.getOrder_number() %>" />
    		 <input type="hidden" name="goods_code" value="<%=gdto.getGoods_code()%>" />
    		 <input type="submit" value="판매자문의"/>
    		</form>
		  </li>
		</td>
		<td align="center" width="100">
		 <%=odto.getOrder_date()%>
		</td>
		<td align="center" width="100">
		 <a href="<%=cjtrack %><%=odto.getTrack() %>" onclick="window.open('this.href')">
		  <%=odto.getTrack() %>
		 </a>
		</td>
	   </tr>
<%
		}
%>
<tr>
<td align="center" width="100">
<!-- order_number를 파라미터로 갖고 관리자문의 페이지로 이동 -->
<h2>
 <form action="op_board.jsp" method="post">
  <input type="hidden" name="order_number" value="<%=order_number%>" />
  <input type="hidden" name="user_id" value="<%=user_id%>"/>
  <input type="submit" value="관리자문의"/>
 </form>
 </h2>
</td>
 </table>
</body>
</html>