<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<h1><center> 상품 상세 게시판</h1>
<h1> goodsDetail.jsp</h1>

<%
	/*String strCode = request.getParameter("code");
	int code = 0;
	if(strCode != null)
		code = Integer.parseInt(strCode);
	*/
	
	int goods_code = Integer.parseInt(request.getParameter("goods_code"));
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
		
		}
		MyShopDAO dao = MyShopDAO.getInstance();
		MyShopDTO dto = dao.detailGoods(goods_code);
		
%>

	<form method="post" enctype="multipart/form-data">
	<table border="1" align="center">
	
	<col style="width:px;">
	<tbody>
		<tr>
		<th><%=dto.getGoods_name()%></th>
		<td><img src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>"></td>
		
		<tr>
			<th>판매가</th>
			<td><%=dto.getGoods_price()%></td>
			</tr>
		<tr>
			<th>상품코드</th>
			<td><%=dto.getGoods_code()%></td>
		</tr>
		<tr>
			<th>제조사/공급사</th>
			<td><%=dto.getGoods_brand() %></td>
		</tr>
		<tr>	
			<th>남은수량</th>
			<td><%=dto.getGoods_count() %></td>
			</td>
		</tr>
		<tr>	
			<th>구매수량</th>
			<td>
				<input type="number">
			</td>
		</tr>
		<tr>
			<th>옵션선택</th>
			<td><%=dto.getGoods_option() %><td>	
		</tr>
		<tr>
			<th>배송비</th>
			<td><%=dto.getGoods_delivery() %></td>
		</tr>
		</tbody>
		</table>
		
		<center>
		<button onclick="window.location='cartList.jsp'">장바구니</button>
		<button onclick="window.location='buyForm.jsp'">구매하기</button>  
		
		<% String goods_brand = (String)session.getAttribute("user_id");
		
		UserDTO udto = new UserDTO();
		UserDAO udao = new UserDAO();
		UserDTO infodto = udao.myInfo(goods_brand);
		String rating = infodto.getRating();
		
		if(rating.equals("2")){ %>  
		<input type="button" value="수정하기" onclick="window.location='/myShop/seller/updateDetail.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>'"><%} %> 	
		
		
		<h2>제품설명</h2>
	<br>
	
	<img src="<%=dto.getGoods_msg() %>"></br>
	
	 <%} %>
	 </center>


<center><h2>상품댓글 :)</h2></center>
<jsp:include page="goodsCmt.jsp">
 	<jsp:param name = "cmtpageNum" value = "<%=cmtPageNum %>" />
</jsp:include>

<center><h2>상품 Q&A</h2></center> 
	
<jsp:include page="goodsQnaList.jsp">
 	<jsp:param name = "pageNum" value = "<%=pageNum %>" />
</jsp:include>