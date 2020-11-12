<%@page import="myshop.goodscmt.CmtDTO"%>
<%@page import="myshop.goodscmt.CmtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%// request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("cmtPageNum");
  CmtDAO dao = CmtDAO.getInstance();
  CmtDTO dto = new CmtDTO();
  dao.deleteCmt(num);
  
%>
	<script>
		alert("삭제 되었습니다.");
	</script>
