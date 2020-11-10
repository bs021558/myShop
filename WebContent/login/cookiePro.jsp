<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h1>cookiePro</h1>

<jsp:useBean id="dto" class="myshop.user.UserDTO" />
<jsp:setProperty property="*" name="dto" />

 
<%
	String user_id = null, user_pw = null, auto = null ;
		Cookie [] cookies = request.getCookies();
		if(cookies != null){
		for(Cookie c : cookies){
		if(c.getName().equals("cid")){
			user_id = c.getValue();
			dto.setUser_id(user_id);
		}
		if(c.getName().equals("cpw")){
			user_pw = c.getValue();
			dto.setUser_pw(user_pw);
		}
		if(c.getName().equals("cauto")){
			auto = c.getValue();				
			dto.setAuto(auto);
		}
		}
		}
    	
    	UserDAO dao = new UserDAO();
    	boolean result = dao.loginCheck(dto);
    
    	if(result){
    		session.setAttribute("sessionId", dto.getUser_id()); 
    		session.setAttribute("rating", dto.getRating());
    		
    		if(dto.getAuto() != null){ //&& dto.getAuto().equals("1"))
    			Cookie cid = new Cookie("cid" , dto.getUser_id());
    			Cookie cpw = new Cookie("cpw" , dto.getUser_pw());
    			Cookie cauto = new Cookie("cauto" , dto.getAuto());
    			cid.setMaxAge(60*60*24);
    			cpw.setMaxAge(60*60*24);
    			cauto.setMaxAge(60*60*24);
    			response.addCookie(cid);
    			response.addCookie(cpw);
    			response.addCookie(cauto);
    		}
    		response.sendRedirect("/myShop/index.jsp");
%>
		  <%}else {%>
			<script>
				alert("로그인 / 패스워드를 다시 입력해주십시오.");
				location.href = "/myShop/login/loginForm.jsp";
			</script>
		  
<%} %>		  
		  