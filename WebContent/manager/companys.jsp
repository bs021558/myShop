<%@page import="java.util.List"%>
<%@page import="myshop.user.UserDAO"%>
<%@page import="myshop.user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	  String pageNum = request.getParameter("pageNum");
	  if(pageNum == null){
	      pageNum = "1";
	   }
	 int pageSize = 10; //게시판 개수
	 int currentPage = Integer.parseInt(pageNum); //현재페이지
	 int startRow = (currentPage - 1) * pageSize +1;//글첫번째
	 int endRow = currentPage * pageSize;//마지막행
	 int number = 0;
	   
		String sessionId = (String) session.getAttribute("sessionId");
		if (sessionId == null) {
			response.sendRedirect("/myShop/login/loginForm.jsp");
		}else{
		UserDTO dto = new UserDTO();
		UserDAO dao = new UserDAO();
		int count = dao.getcompany(); //회사수;
		List articleList=null;
		if(count > 0){
			articleList = dao.selectcompany();
		}
		
		
		
		
		
	%>
	<center>
	<h1>등록한 회사 정보</h1>
</head>
<b>등록 회사 수: <%=count%></b>
<%
	if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">게시판에 저장된 글이 없습니다.</td>
</table>

<%
	} else {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30">
		<td align="center" width="200">회사 이름</td>
		<td align="center" width="200">회사 번호</td>
		<td align="center" width="200">회사 자산</td>
		<td align="center" width="200">가입 날자</td>
	</tr>
	<%
		for (int i = 0; i < articleList.size(); i++) {
				UserDTO article = (UserDTO) articleList.get(i);
	%>
	<tr height="30">
		<td align="center" width="200"><%=article.getUser_id() %></td>
		<td align="center" width="200"><%=article.getUser_phone() %></td>
		<td align="center" width="200"><%=article.getUser_cash() %></td>
		<td align="center" width="200"><%=article.getUser_date() %></td>
	</tr>
	<%
		}
	%>
</table>
<%
	}
%>

<%
	if (count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

		int startPage = (int) (currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount)
			endPage = pageCount;

		if (startPage > 10) {
%>
<a href="companys.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%
	}
		for (int i = startPage; i <= endPage; i++) {
%>
<a href="companys.jsp?pageNum=<%=i%>">[<%=i%>]
</a>
<%
	}
		if (endPage < pageCount) {
%>
<a href="companys.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%
	}
	}
%>
	</center>
</body>
<%} %>
</html>