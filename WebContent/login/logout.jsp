
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>logout페이지</h1>
    
    <%
		session.invalidate(); 
		String id = null, pw = null, auto = null;
		Cookie [] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie c : cookies){
				if(c.getName().equals("cid")){
					c.setMaxAge(0);
					response.addCookie(c);
				}
				if(c.getName().equals("cpw")){
					c.setMaxAge(0);
					response.addCookie(c);
				}
				if(c.getName().equals("cauto")){
					c.setMaxAge(0);
					response.addCookie(c);			
				}
			}
		}
		response.sendRedirect("/myShop/index.jsp");
    %>