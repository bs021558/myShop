<%@page import="myshop.cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <%request.setCharacterEncoding("UTF-8");
    String sessionId = (String)session.getAttribute("sessionId");%>
	<jsp:useBean id="dto" class="myshop.cart.CartDTO" />
    <jsp:setProperty property="*" name="dto"/> 
    
    <%
	CartDAO dao = CartDAO.getInstance();
    dao.insertCart(dto);
    %>

	<script>
		alert("장바구니에 담겼습니다.");
		window.location="cartList.jsp";
	</script>
	