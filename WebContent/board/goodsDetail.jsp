<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "myshop.board.*" %>
<%@ page import = "myshop.goods.*" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<h1><center> 상품 상세 게시판</h1>

<%
   String sessionId = (String)session.getAttribute("sessionId");
   String goods_code = request.getParameter("goods_code");
   int code =0;
   code = Integer.parseInt(goods_code);
   
   
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null) {
      pageNum = "1";
      
      }
      MyShopDAO dao = MyShopDAO.getInstance();
      MyShopDTO dto = dao.detailGoods(code);
      if(dto != null)
      {
%>

   <table border="1" align="center">
   <form name="form" action="cartInsertPro.jsp" method="post">
   <col style="width:px;">
   <tbody>
      <tr>
      <th><%=dto.getGoods_name() %></th>
      <input type="hidden" size="50"  name="user_id" value="<%=sessionId%>">
      <input type="hidden" size="50"  name="goods_name" value="<%=dto.getGoods_name() %>">
      <td><img src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img ()%>"></td>
      
      <tr>
         <th>판매가</th>
         <td><%=dto.getGoods_price() %></td>
         <input type="hidden" size="50"  name="goods_price" value="<%=dto.getGoods_price() %>">
         </tr>
      <tr>
         <th>상품코드</th>
         <td><%=dto.getGoods_code() %></td>
         <input type="hidden" size="50"  name="goods_code" value= "<%=dto.getGoods_code() %>">
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
            <input type="number" name="amount">

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
      <input type="submit" value="장바구니" />
      <input type="button" value="구매하기" onclick="window.location='buyForm.jsp'" />
      </form>
		<button onclick="window.location='goodsList.jsp'">뒤로</button>   
				
		<h2>제품설명</h2>
	<br>
	
	<img src="<%=dto.getGoods_msg() %>"></br>
	
	 <%// } %>
	 </center>

	 
	<h2><center>상품댓글 :)</h2>
	
<%   
   	CmtDAO cmt = CmtDAO.getInstance();
    List<CmtDTO> list = cmt.getList(code);
%>	
	

	<%--goodsCmt 추가--%>

<form method="post" action="goodsCmtPro.jsp">
    <table align="center" border="1" width="500">
        <tr>
            <td>이름</td><td><input type="text" name="writer"></td>
           	<input type="hidden" name="goods_code" value = "<%= code %>"/>
        </tr>
        <tr>
            <td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
        </tr>
        <tr>
            <td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
        </tr>
    </table>  
</form>
<br>

	<%----%>
	
    <% if(list != null){
        for(CmtDTO cmtt : list){ %>
        <table align="center" width="750" border="1">
            <tr>
                <td><%= cmtt.getNum() %></td>
                <td><%= cmtt.getReg_date() %></td>
            </tr>
            <tr>
            	<td><%= cmtt.getWriter() %></td>
                <th><%= cmtt.getContent() %></th>
                <td><a href="goodsCmtDel.jsp?num=<%= cmtt.getNum() %>">삭제</a></td>
            </tr>
        </table>
        <br>
        <% }
        }
        }%>

	<center><h2>상품 Q&A</h2></center> 
	
 <jsp:include page="goodsQnaList.jsp">
 	<jsp:param name = "goods_code" value = "<%= dto.getGoods_code() %>" />
 	<jsp:param name = "pageNum" value = "<%= pageNum %>" />
 </jsp:include>