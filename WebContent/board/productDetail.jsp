<%@page import="myshop.goods.MyShopDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 
<%	
	String strCode = request.getParameter("code");
	int code = 0;
	if(strCode != null)
		code = Integer.parseInt(strCode);
	code = 46;
	
	MyShopDAO dao = MyShopDAO.getInstance();//new myshopDAO();
	MyShopDTO dto = dao.detailProduct(code);
	if(dto != null)
	{
%> 
	<form method="post" enctype="multipart/form-data/form-data">
	<center>
	<table border="1">
	<tr>
	<td width="400" ><img src="/myshop/save/<%=dto.getGoods_img() %>" width="400"></td>
	<td width="400"><%=dto.getGoods_brand() %></br>
	</br>
	<%=dto.getGoods_name() %></br>
	</br>
	<%=dto.getGoods_price() %>원</br>
	</br>
	배송비: <%=dto.getGoods_delivery() %></br>
	<%=dto.getGoods_state() %></br>
	<%=dto.getGoods_count() %></br>
	</br>
	</br>
	</br>
	<button onclick="window.location='cartList.jsp'">장바구니</button>
    <button onclick="window.location='purchase.jsp'">구매하기</button></td></tr>
	</table>
	</form>
	

	
	<h2>제품설명</h2>
	<br>
	
	<img src="<%=dto.getGoods_msg() %>"></br>


 <% } %>

 	<h5>구매후기</h5>
 	
 	<h5>Q&A 상품 문의</h5>