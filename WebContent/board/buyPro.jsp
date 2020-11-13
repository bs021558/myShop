<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.shoporder.OrderDTO"%>
<%@ page import="myshop.shoporder.OrderDAO"%>
<%@ page import="myshop.cart.CartDAO"%>
<%@ page import="myshop.cart.CartDTO"%>
<%@ page import="java.util.List" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
    
   <%request.setCharacterEncoding("UTF-8");
    String sessionId = (String)session.getAttribute("sessionId");
    int remain = Integer.parseInt(request.getParameter("remain"));
    String goods_brand = request.getParameter("goods_brand");
    
    
	OrderDAO o_dao = OrderDAO.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Date date = new Date();
	String today = (String)sdf.format(date);

	
   %>
   <jsp:useBean id="order" class="myshop.shoporder.OrderDTO" />
   <jsp:setProperty name="order" property="*" />
      
   <% 
   int odn = o_dao.getNewOrderNumber(sessionId);
   String odrNum = "ms"+ today+odn;
   String track = "temp";
   
   order.setUser_id(sessionId);
   order.setTrack(track);
   order.setGoods_brand(goods_brand);
   o_dao.insertOrder(order,odn);
   o_dao.updateCash(remain, sessionId);
   o_dao.updateCash(order);
   %>       
	 <script>
		alert("주문이 완료되었습니다.\n주문번호: <%=order.getOrder_number()%>");
	</script>
	<meta http-equiv="Refresh" content="0;url=/myShop/board/goodsDetail.jsp?goods_code=<%=order.getGoods_code()%>">