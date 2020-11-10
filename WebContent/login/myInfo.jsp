<%@page import="myshop.user.UserDTO"%>
<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    
    <%
    	request.setCharacterEncoding("UTF-8");
		String sessionId = (String)session.getAttribute("sessionId");
		if(sessionId == null){
			response.sendRedirect("/myShop/login/loginForm.jsp");
  		}
		UserDAO dao = new UserDAO();
		UserDTO dto = dao.myInfo(sessionId);
 
    %>

	
	
	<%@ include file="/include/top.jsp"%> <!-- 상단 -->
<body style="text-align: center;">
	<div>
		<br />
		<form action="myInfoPro.jsp" method="post">
			<h1> 정보수정</h1>
			<br/>
			<div>
				rating : <%=dto.getRating() %><br />
				<input type = "hidden" name ="rating" value ="<%=dto.getRating()%>" />
			</div>
			<div>
				id : <%=dto.getUser_id() %> <br />
				<input type = "hidden" name ="user_id" value ="<%=dto.getUser_id()%>" />
			</div>
			<div>
				현재잔액 : <%=dto.getUser_cash() %> <br />
			 	<input type = "hidden" name ="user_cash" value ="<%=dto.getUser_cash()%>" />
			</div>
			<div>
				pw : <input type = "text" name="user_pw" value="<%=dto.getUser_pw()%>" /><br />
			</div>
			<div>
				name : <input type = "text" name="user_name" value="<%=dto.getUser_name()%>" /><br />
			</div>
			<div>
				phone : <input type = "text" name="user_phone" value="<%=dto.getUser_phone()%>" /><br />
			</div>
			<div>
				address : <input type = "text" name="user_address" value="<%=dto.getUser_address()%>" /><br />		
			</div>
			<div>
				가입날짜 : <%=dto.getUser_date()%> <br />
			</div>
			
			<input type="submit" value="정보수정" style="width: 180px; height: 40px;margin-bottom: 10px;">
		</form>
	</div>
	
    
   <button onclick="window.location='/myShop/member/myPage.jsp'" style="width: 90px;">메인</button>
	
	
	
	