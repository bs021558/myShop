<%@page import="myshop.qnaboard.QnaDTO"%>
<%@page import="myshop.qnaboard.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf =
			new SimpleDateFormat("yyyy-MM-DD HH:mm");
			
	try{
		QnaDAO dao = QnaDAO.getInstance();
		QnaDTO dto = dao.getQna(num);
			
		int ref=dto.getRef();
		int re_step=dto.getRe_step();
		int re_level=dto.getRe_level();	
%>
<center><b>글내용 보기</b>
<br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr heigth="30">
	<td align="center" width="125">글번호</td>
	<td align="center" width="125" align="center">
		<%=dto.getNum()%></td>
	<td align="center" width="125">조회수</td>
	<td align="center" width="125" align="center">
		<%=dto.getReadcount()%></td>
	</tr>
	<tr heigth="30">
	<td align="center" width="125">작성자</td>
	<td align="center" width="125" align="center">
		<%=dto.getWriter() %></td>
	<td align="center" width="125">작성일</td>
	<td align="center" width="125" align="center">
		<%= sdf.format(dto.getReg_date()) %></td>
	</tr>
	<tr heigth="30">
	 <td align="center" width="125">글제목</td>
	 <td align="center" width="375" align="center" colspan="3">
	 	<%=dto.getSubject()%></td>
	</tr>
	<tr>
	<td align="center" width="125">글내용</td>
	<td align="center" width="375" colspan="3"><pre><%=dto.getContent() %></pre></td>
	</tr>
	<tr height="30">
	 <td colspan="4"align="right">
	 
	 <%
	 String memId = (String)session.getAttribute("id");
	 if(memId !=null) {
		 if(memId.equals(dto.getWriter())) {
	 
	 %>
	 <input type="button" value="글수정"
	 onclick="document.location.href='goodsQnaUpdate.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
	 &nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button" value="글삭제"
	 onclick="document.location.href='goodsQnaDel.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">		
	 &nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button" value="답글쓰기" 
     onclick="document.location.href='goodsQnaWrite.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	 &nbsp;&nbsp;&nbsp;&nbsp;
	 <%}%>
	 <input type="button" value="글목록"
	 onclick="document.location.href='goodsQnaList.jsp?pageNum=<%=pageNum%>'">
	 </td>
	</tr>
</table>
<%
 }
 }catch(Exception e){}
%>
</form>
</body>
</html>