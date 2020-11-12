<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<% UserDAO userdao = UserDAO.getInstance();

String user_id=request.getParameter("user_id");
UserDTO userdto = userdao.usersselect("2",user_id);
%>

<h1><%=userdto.getUser_name() %></h1>
회사 주소 : 주소 <br/>
사업자번호 : 번호<br/>
전화번호  : 전화번호<br/>
이메일 : 이메일<br/>
가입날자 : 가입날자<br/>
회사 물품 : 총 수량 :"몇개"<br/>
<br/>
물건 번호
상품 이름
개수
상품 총 판매내역
물건 번호
상품 이름
개수
상품 총 판매내역
</body>
</html>