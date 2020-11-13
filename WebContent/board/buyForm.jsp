<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@page import="myshop.cart.CartDAO"%>
<%@page import="myshop.cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>

<html>
<head>
<title>구매정보 입력</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
    String sessionId = (String)session.getAttribute("sessionId");
	String[] chkbox = request.getParameterValues("cartCheck");
	
	String goods_name = request.getParameter("goods_name");
	String goods_brand = request.getParameter("goods_brand");
	String amount = request.getParameter("amount");
	String goods_price = request.getParameter("goods_price");
	int goods_code = Integer.parseInt(request.getParameter("goods_code"));

	
    if(sessionId==null)
     {
%>
   <script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/login/loginForm.jsp';
    </script>

<%}else{ %>
<% 
   int count = 0;
   int number=0;
   int total_price = 0;
   int startRow=0;
   int endRow=5;
   
   List cartList = null;
   CartDTO dto = new CartDTO();
   CartDAO c_dao = CartDAO.getInstance();
   DecimalFormat df = new DecimalFormat("###,###");
   MyShopDAO dao = MyShopDAO.getInstance();
   count = c_dao.getCartCount(sessionId);

   if (count > 0){
      cartList = c_dao.getCartList(sessionId, startRow, endRow);
   }
   
   UserDTO userdto = new UserDTO();
   UserDAO userdao = new UserDAO();
   userdto = userdao.myInfo(sessionId);
   int cash = Integer.parseInt(userdto.getUser_cash());
  
%>


<center><h3><b>구매목록</b></h3></center>


<form method = "post" action="buyPro.jsp" >
<table width="600" border=1 cellpadding="0" ceppspacing="0" align=center>
   <tr>
      <td align="center" width="50">번호</td>
      <td align="center" width="250">상품</td>
      <td align="center" width="100">수량</td>
      <td align="center" width="100">금액</td>
   </tr>
   <tr height="30">
      <td align="center"><%=++number %></td>
      <td align="center" width="250" ><%=goods_name%></td>
      <input type="hidden" name="goods_code" value=<%=goods_code%>>
      <td align="center" width="100" ><%=amount%></td>
      <input type="hidden" name="amount" value=<%=amount%>>
      <td align="center" width="100" ><%=goods_price%></td>
      <% total_price += (Integer.parseInt(amount) * Integer.parseInt(goods_price)); %>
      <tr>
        <td align="right" colspan="5"> 총 금액: <%=df.format(total_price)%> 원<br/>
           
     </tr>
</table>
	
   <br>

      <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>주문자 정보</b></td>
      </tr>
      <tr>
         <td width="200">성명</td>
         <td width="400"><%= userdto.getUser_name()%></td>
      </tr>
      <tr>
         <td width="200">전화번호</td>
         <td width="400"><%= userdto.getUser_phone()%></td>
      </tr>
      <tr>
         <td width="200">주소</td>
         <td width="400"><%= userdto.getUser_address() %></td>
      </tr>
      </table>
<br />
     
     <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>배송지 정보</b></td>
      </tr>
      <tr>
         <td width="200">성명</td>
         <td width="400">
            <input type="text" name="re_name" style="width:400px;"></td>
      </tr>
      <tr>
         <td width="200">전화번호</td>
         <td width="400">
            <input type="text" name="re_phone" style="width:400px;" ></td>
      </tr>
      <tr>
         <td width="200">주소</td>
         <td width="400">
            <input type="text" name="re_address" style="width:400px;"></td>
      </tr>
      </table>
<br />   
       <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td colspan="2" align="center"><b>결제 정보</b></td>
      </tr>
      <tr>
         <td width="200">보유 캐시</td>
         <td width="400"><%=df.format(cash)%></td>
      </tr>
      <tr>
         <td width="200">결제 금액</td>
         <td width="400"><%=df.format(total_price)%></td>
      </tr>
      <tr>
         <td width="200">남는 캐시</td>
         <% 
         int remain = Integer.parseInt(userdto.getUser_cash())-total_price;
         if(remain > 0){%>
         <td width="400"><%=df.format(remain)%></td>
            <%}else{ %>
         <td width="400">보유 캐시가 부족합니다.</td>
         <%} %>
      </tr>
      <tr>
         <td colspan="2" align="center" >
         <input type="hidden" name="total_price" value=<%=total_price%>>
         <input type="hidden" name="remain" value=<%=remain%>>
         <input type="hidden" name="goods_brand" value=<%=goods_brand%>>
            <%if(remain > 0){ %>
            <input type="submit" value="결제">
            <%}else{ %>
            <input type="button" value="충전하기" onclick="location.href='/myShop/member/cash.jsp'">
            <%} %>
            <input type="button" value="취소" onclick="location.href='/myShop/board/goodsList.jsp'">
         </td>
      </tr>
      </table>
   </form>
<%} %>
</body>
</html>
