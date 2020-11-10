<%@page import="myshop.user.UserDTO"%>
<%@page import="myshop.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/myShop/css/index.css">
<br />
<br />
<br />
<br />
<br />
<%!
	String sessionId;
	String rating=null;
%>
<div id="mainframe" style="border-color: red;">
	<div id="top">
		<div id="header_brandform"></div>
		<ul>
			<li>&nbsp;</li>
			<li>&nbsp;</li>
		</ul>
		<div id="header_member">
		
<jsp:useBean id="dto" class="myshop.user.UserDTO"/>
<%
	UserDAO udao = UserDAO.getInstance();
	
	//세션이 없을 경우
	if(session.getAttribute("sessionId") == null){
		String id = null , pw = null , auto=null;
		Cookie [] cookies = request.getCookies();
		
		//쿠키 있을 경우 쿠키정보 가져옴
		if(cookies != null){
			for(Cookie c : cookies){
				if(c.getName().equals("cid")){ id = c.getValue();dto.setUser_id(id);}
				if(c.getName().equals("cpw")){ pw = c.getValue();dto.setUser_pw(pw);}
				if(c.getName().equals("cauto")){ auto = c.getValue();dto.setAuto(auto);}
			}
			session.setAttribute("sessionId",id);
			session.setAttribute("sessionAuto",auto);
		}
	//세션 있을 경우
	}else{
		
		//로그인 체크
	    boolean result = udao.loginCheck(dto);
	  	
		//쿠키 생성
		if(result){ 
	    	if(dto.getAuto().equals("1")){
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
		}
	}
	
	sessionId = (String)session.getAttribute("sessionId");
	dto=udao.myInfo(sessionId);
	rating = dto.getRating();
		if(rating!=null){
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
		}else{
%>
			<ul>
				<li><a href="/myShop/login/intac.jsp">회원가입</a></li>
				<li>|</li>
				<li><a href="/myShop/login/loginForm.jsp">로그인</a></li>
			</ul>
<%
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
