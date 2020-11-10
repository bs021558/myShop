<%@page import="myshop.board.MyShopDAO"%>
<%@page import="myshop.cart.CartDAO"%>
<%@page import="myshop.cart.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.util.List" %>
<script>

</script>
<%
	String sessionId = (String)session.getAttribute("sessionId");
    if(sessionId==null)
  	{
%>
	<script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/board/login.jsp';
     </script>

<%
	}
%>
<%
	int pageSize=10;
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0; //담긴 상품 개수
    int goods_code=0; 
	int number=0;
	int cartTotalPrice = 0; //장바구니 총액
	
	List cartList = null;
	CartDTO dto = new CartDTO();
    CartDAO c_dao = CartDAO.getInstance();
    MyShopDAO dao = MyShopDAO.getInstance();
	count = c_dao.getCartCount(sessionId);
	goods_code = dto.getGoods_code(); 
// 		DecimalFormat df = new DecimalFormat("###,###");
	if (count > 0){
		cartList = c_dao.getCartList(sessionId, startRow, endRow);
	}
%>
	
<html>
<head>
<title>장바구니</title>
</head>

<body bgcolor="white">
<center><b>[<%=sessionId%>]님의 장바구니</b>

<table width=100% border=1 align=center>

<%
	if(count == 0){ 
%>
<table width="700" border="1" cellpadding="0" cellspacing="0"> 
<tr>
	<td align="center">
	장바구니에 저장된 상품이 없습니다.
	</td>
</tr>
<tr>
	<td align="center"><input type="button" value="담으러 가기" onclick="document.location.href='/myShop/board/goodsList.jsp'"></td>
</tr>
</table>
<%	}else{
%>
	
<form method="POST" name="delForm" action="cartDel.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()">
	<tr>
		<td align="center" width="10%">선택</td>
		<td align="center" width="250">상품</td>
		<td align="center" width="100">수량</td>
		<td align="center" width="100">금액</td>
		<td align="center" width="10%">삭제</td>
	</tr>
	<%
		for (int i = 0; i < cartList.size(); i++) {
			CartDTO cart = (CartDTO)cartList.get(i);		
	%>
	<tr height="30">
		<td align="center"><input  type="checkbox" name="checkedUserId" value="selected" /></td>
		<td align="center" width="250" ><%=cart.getGoods_code()%>(수정) </td>
		<td align="center" width="100"> <%=cart.getAmount()%>(수정)</td>
		<td align="center" width="100" ><%=cartTotalPrice%>(수정)</td>
		<td align="center"><input type="button" value="삭제" onclick="document.location.href='deletePro.jsp?user_id=<%=sessionId%>&goods_code=<%=cart.getGoods_code()%>&pageNum=<%=pageNum%>'"></td>
 	 </tr>
     <%}%>
      <tr>
 	 	<td align="right" colspan="5"> 총 금액: <%=cartTotalPrice %> 원<br/>
 	 	
 	 	<input type="button" name="order" value="선택상품 주문"></td><br />
 	 </tr>
</table>
	
<%}%>

</center>
</body>
</html>

	