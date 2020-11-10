<%@page import="myshop.opboard.OpBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역상세</title>
</head>
<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
//    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   try{
      OpBoardDAO dao = OpBoardDAO.getInstance();
      OpBoardDTO notice =  dao.getNotice(num);
%>
<body>
	<table width="500" border="1" align="center">
		<tr>
			<td width="50%">글번호</td>
			<td></td>
		</tr>
		<tr>
		<tr>
			<td>작성자</td>
			<td></td>
		</tr>
		<tr>
			<td>글제목</td>
			<td></td>
		</tr>
		<tr>
			<td height="200">글내용</td>
			<td>
		</tr>
	</table>
</body>
</html>