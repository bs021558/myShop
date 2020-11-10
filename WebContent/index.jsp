<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.user.UserDAO" %>
    
<%
	if(session.getAttribute("sessionId") == null){
		String id = null , pw = null , auto=null;
		Cookie [] cookies = request.getCookies();
		if(cookies != null){//쿠키가 있을 때만 실행
%>
<jsp:useBean id="dto" class="myshop.user.UserDTO" />
<jsp:setProperty property="*" name="dto"/>
<%	
			for(Cookie c : cookies){
				if(c.getName().equals("cid")){ id = c.getValue();dto.setUser_id(id);}
				if(c.getName().equals("cpw")){ pw = c.getValue();dto.setUser_pw(pw);}
				if(c.getName().equals("cauto")){ auto = c.getValue();dto.setAuto(auto);}
			}
			UserDAO udao = UserDAO.getInstance();
			boolean result = udao.loginCheck(dto);
			if(result){
				session.setAttribute("id", dto.getUser_id()); // 세션 생성
				if(dto.getAuto() != null && dto.getAuto().equals("1")){
					Cookie cid = new Cookie("cid", dto.getUser_id());
					Cookie cpw = new Cookie("cpw", dto.getUser_pw());
					Cookie cauto = new Cookie("cauto", dto.getAuto());
					cid.setMaxAge(60*60*24);
					cpw.setMaxAge(60*60*24);
					cauto.setMaxAge(60*60*24);
					response.addCookie(cid);
					response.addCookie(cpw);
					response.addCookie(cauto);
				}
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
<%@ include file="/include/image.jsp" %> <!--age파일 -->
<div>
<%@ include file="/include/mainGoods.jsp" %> 
</div>
<div>
<%@ include file="/include/bottom.jsp" %> <!--하단 -->
</div>
</body>
</html>