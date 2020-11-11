<%@page import="myshop.user.UserDTO"%>
<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="myshop.user.UserDTO"/>
<%
	UserDAO udao = UserDAO.getInstance();
	String sessionId = (String)session.getAttribute("sessionId");
	dto = udao.myInfo(sessionId);
	String rating = dto.getRating();
%>
<link rel="stylesheet" type="text/css" href="/myShop/css/index.css">
<br />
<br />
<br />
<br />
<br />
<div id="mainframe" style="border-color: red;">
	<div id="top">
		<div id="header_brandform"></div>
		<ul>
			<li>&nbsp;</li>
			<li>&nbsp;</li>
		</ul>
		<div id="header_member">
<%
	if(rating==null){
%>
			<ul>
				<li><a href="/myShop/login/intac.jsp">회원가입</a></li>
				<li>|</li>
				<li><a href="/myShop/login/loginForm.jsp">로그인</a></li>
			</ul>
<%
	}else{
			if(rating.equals("1")){
%>
			<ul>
				<li><%=sessionId%>님</li>
				<li>|</li>
				<li><a href="/myShop/member/myPage.jsp">내 정보</a></li>
				<li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><button style="border: 0px;"  type="button"><img src="/myShop/dev_img/out.png" width="30"></button></a></li>
			</ul>
<%
		}else if(rating.equals("2")){
%>
			<ul>
				<li><%=sessionId%>님</li>
				<li>|</li>
				<li><a href="/myShop/seller/sellerStore.jsp">가게 정보</a></li>
				<li style="font-size: 5;"><a href="/myShop/login/logout.jsp"><button style="border: 0px;"  type="button"><img src="/myShop/dev_img/out.png" width="30"></button></a></li>
			</ul>
<%
		} 
	}
%>
		</div>
	</div>

	<div id="mainmenu">
		<div id="logo">
			<a href="/myShop/index.jsp">myShop</a>
		</div>
		<div id="menu">
			<ul>
				<li><a href="/myShop/board/goodsList.jsp">스토어</a></li>
				<li><a href="/myShop/community/commuList.jsp">커뮤니티</a></li>
				<li><a href="/myShop/community/opBoard.jsp">문의하기</a></li>
			</ul>
		</div>
	</div>
</div>
