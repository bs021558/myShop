<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.user.UserDAO" %>
<%@ page import="myshop.user.UserDTO" %>

<%
	//세션이 있을 때만 동작
	if(session.getAttribute("sessionId")!=null){
		//세션 불러오기
		String sessionId = (String)session.getAttribute("sessionId");
		String sessionAuto = (String)session.getAttribute("sessionAuto");
	
		//세션ID로 회원정보 dto에 저장
		UserDAO udao = UserDAO.getInstance();
		UserDTO udto = new UserDTO();
		udto = udao.myInfo(sessionId);

		//로그인 체크
	    boolean result = udao.loginCheck(udto);
	  	
		//쿠키 생성
		if(result){ 
	    	if(sessionAuto.equals("1")){
	    		Cookie cid = new Cookie("cid" , sessionId);
	    		Cookie cpw = new Cookie("cpw" , udto.getUser_pw());
	    		Cookie cauto = new Cookie("cauto" , sessionAuto);
	    		cid.setMaxAge(60*60*24);
	    		cpw.setMaxAge(60*60*24);
	    		cauto.setMaxAge(60*60*24);
	    		response.addCookie(cid);
	    		response.addCookie(cpw);
	    		response.addCookie(cauto);
	    	}
		}
	}
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myShop</title>
</head>
<body>
<div>
<h1>로그인</h1>
<%@ include file="/include/top.jsp"%> <!-- 상단 -->
</div>
<%@ include file="/include/image.jsp" %> <!--image파일 -->
<div>
<%@ include file="/include/mainGoods.jsp" %> 
</div>
<div>
<%@ include file="/include/bottom.jsp" %> <!--하단 -->
</div>
</body>
</html>