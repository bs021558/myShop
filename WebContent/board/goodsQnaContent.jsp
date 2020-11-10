<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="myshop.board.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
	String goods_code = request.getParameter("goods_code");

	
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
      QnaDAO dao = QnaDAO.getInstance();
      QnaDTO dto = dao.getQna(num);
  
	  int ref=dto.getRef();
	  int re_step=dto.getRe_step();
	  int re_level=dto.getRe_level();
%>

<body bgcolor="eaeaea">
<center><b>글내용 보기</b></br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0"  bgcolor="eaeaea" align="center">  
  <tr height="30">
    <td align="center" width="125" bgcolor="eaeaea">글번호</td>
    <td align="center" width="125" align="center">
	     <%=dto.getNum()%></td>
    <td align="center" width="125" bgcolor="eaeaea">조회수</td>
    <td align="center" width="125" align="center">
	     <%=dto.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="eaeaea">작성자</td>
    <td align="center" width="125" align="center">
	     <%=dto.getWriter()%></td>
    <td align="center" width="125" bgcolor="eaeaea" >작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(dto.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="eaeaea">글제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=dto.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125" bgcolor="eaeaea">글내용</td>
    <td align="left" width="375" colspan="3"><pre><%=dto.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" bgcolor="eaeaea" align="right" > 
	  <input type="button" value="글수정" 
       onclick="document.location.href='goodsQnaUpdate.jsp?goods_code=<%=goods_code%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="글삭제" 
       onclick="document.location.href='goodsQnaDelete.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="답글쓰기" 
       onclick="document.location.href='goodsQnaWrite.jsp?goods_code=<%=goods_code%>&num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" value="글목록" 
       onclick="document.location.href='goodsDetail.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>
</form>
</center>
	<%
	 }catch(Exception e){} 
	%>


