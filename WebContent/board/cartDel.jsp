<%@page import="myshop.cart.CartDAO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
	String sessionId = (String)session.getAttribute("id");
	int goods_code = Integer.parseInt(request.getParameter("goods_code"));
	String pageNum = request.getParameter("pageNum");

  CartDAO dao = CartDAO.getInstance();
  dao.deleteCart(sessionId,goods_code);

%>
	  <meta http-equiv="Refresh" content="0;url=cartList.jsp?pageNum=<%=pageNum%>" >
       <script language="JavaScript">      
       <!--      
         alert("삭제되었습니다.");
       -->
      </script>
