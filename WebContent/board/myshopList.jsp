<%@page import="myShop.mvc.user.biard.MyShopDTO"%>
<%@page import="myShop.mvc.user.biard.MyShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>

<%!
   int pageSize = 10; //상품메인에 보여지는 상품개수
%>

<%
   String pageNum = request.getParameter("pageNum"); 
   if(pageNum == null){
      pageNum = "1";
   }
   
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize +1;
   int endRow = currentPage * pageSize;
   int count = 0;
   int number = 0;
   
   List albumList = null; //상품게시글목록
   MyShopDAO dao = new MyShopDAO(); 
   count = dao.getAlbumCount(); //1.메소드
   System.out.println(startRow);
   System.out.println(endRow);
   System.out.println(count);
   if(count > 0){
	   albumList = dao.getAlbums(startRow,endRow); //2.메소드 
   }
   number = count-(currentPage-1)*pageSize;   
%>

<html>
<head>
<title>상품메인</title>
</head>


<table width="700">
<tr>
	<td align = "right">
	<a href="writeForm.jsp"> 상품등록 </a> 
</table>



<%
	if(count == 0){ //등록된 상품이 없을때
%>

<table width="700" border="1" cellpadding="0" cellespacing="0" align="center">
	<tr height="90">
		<td align = "center">
		등로된 상품이 없습니다.
		</td>
	</tr>
</table>

<% }else { %> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">		
	<tr>
		<td align="center" width="100" > 번호 </td>
		<td align="center" width="500" > 상품사진  </td>
		<td align="center" width="100" > 상품이름 </td>
		<td align="center" width="100" > 상품가격 </td>
		
	</tr>
<%
		for(int i = 0; i < albumList.size() ; i++){
			MyShopDTO dto = (MyShopDTO)albumList.get(i); 
%>	
	<tr>
		<a href = "myshopContent.jsp?num=<%=dto.getGoods_code() %>&pageNum=<%=currentPage %>">
			<%=dto.getGoods_name() %></a>  
		<td align="center" width="100"><%=dto.getGoods_code() %></td>
		<td align="center" width="500"><%=dto.getGoods_img() %></td>
		<td align="center" width="100"><%=dto.getGoods_name() %></td>
		<td align="center" width="100"><%=dto.getGoods_price()%></td>
		 
	</tr>
		<%} %>

</table>
<%} %>

<%
	if(count > 0){ 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); 
		
		
		int startPage = (int)(currentPage/10)*10+1; 
		int pageBlock=10;
		int endPage = startPage + pageBlock-1; 
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10){ %> 
		<a href="list.jsp?pageNum=<%=startPage - 10 %>">[이전]</a> 
<% 		}
		for(int i = startPage ; i <= endPage ; i++) { %>
		<a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<% 		
		}
		if(endPage < pageCount){ %>
		<a href="list.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
<% 
		}
	}
%>


</body>
</html>
