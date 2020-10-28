<%@page import="myshop.user.UserDTO"%>
<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <h1>정보수정</h1>
    
    <%
		String sessionId = (String)session.getAttribute("user_id");
		if(sessionId == null){
			response.sendRedirect("/myShop/user/loginForm.jsp");
  		}
		UserDAO dao = new UserDAO();
		UserDTO dto = dao.myInfo(sessionId);
        %>
	<form action="myInfoPro.jsp" method="post">
		rating : <%=dto.getRating() %><br />
			<input type = "hidden" name ="rating" value ="<%=dto.getRating()%>" />
		id : <%=dto.getUser_id() %> <br />
			 <input type = "hidden" name ="user_id" value ="<%=dto.getUser_id()%>" />
		현재잔액 : <%=dto.getUser_cash() %> <br />
			 <input type = "hidden" name ="user_cash" value ="<%=dto.getUser_cash()%>" />
		pw : <input type = "text" name="user_pw" value="<%=dto.getUser_pw()%>" /><br />
		name : <input type = "text" name="user_name" value="<%=dto.getUser_name()%>" /><br />
		phone : <input type = "text" name="user_phone" value="<%=dto.getUser_phone()%>" /><br />
		address : <input type = "text" name="user_address" value="<%=dto.getUser_address()%>" /><br />
		
		가입날짜 : <%=dto.getUser_date()%> <br />
		
		<input type= "submit" value="정보수정" />
	</form>
	
	