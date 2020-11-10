<%@page import="myshop.user.UserDAO"%>
<%@page import="myshop.user.UserDTO"%>
<%@page import="myshop.board.MyShopDAO"%>
<%@page import="myshop.cart.CartDAO"%>
<%@page import="myshop.cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<html>
<head>
<title>구매하기</title>
</head>

<%
    String sessionId = (String)session.getAttribute("sessionId");
    if(sessionId==null)
     {
%>
   <script>
      alert("로그인 후 이용 가능합니다");
      window.location='/myShop/board/login.jsp';
    </script>

<%}else{ %>
<% 
   int count = 0; //담긴 상품 개수
   int goods_code=0; 
   int number=0;
   int cartTotalPrice = 0; //장바구니 총액
   int startRow=0;
   int endRow=5;
   
   List cartList = null;
   CartDTO dto = new CartDTO();
   CartDAO c_dao = CartDAO.getInstance();
  
   MyShopDAO dao = MyShopDAO.getInstance();
   count = c_dao.getCartCount(sessionId);
   goods_code = dto.getGoods_code(); 

   if (count > 0){
      cartList = c_dao.getCartList(sessionId, startRow, endRow);
   }
   
   UserDTO userdto = new UserDTO();
   UserDAO userdao = new UserDAO();
  
%>


<center><h3><b>구매목록</b></h3></center>


<table width="600" border=1 cellpadding="0" ceppspacing="0" align=center>
   <tr>
      <td align="center" width="50">번호</td>
      <td align="center" width="250">상품이름</td>
      <td align="center" width="100">판매가격</td>
      <td align="center" width="100">수량</td>
      <td align="center" width="100">금액</td>
   </tr>
   <%
      for(int i = 0; i < cartList.size(); i++){
         CartDTO cart = (CartDTO)cartList.get(i);
   %>
   <tr height="30">
      <td align="center"><%=++number %></td>
      <td align="center" width="250" ><%=cart.getGoods_code()%>(수정) </td>
      <td align="center" width="100"> <%=cart.getGoods_price()%>(수정)</td>
      <td align="center" width="100" ><%=cart.getAmount()%>(수정)</td>
      <td align="center" width="100" ><%=cart.getGoods_price()%>(수정)</td>
      <%cartTotalPrice += cart.getGoods_price(); %>
     <%}%>
      <tr>
        <td align="right" colspan="5"> 총 금액: <%=cartTotalPrice %> 원<br/>
           
     </tr>
</table>
	
   <br>
   <form method = "post" action="buyPro.jsp" >
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

   </form>

      
      <table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
      <tr>
         <td celspan="2" align="center"><b>배송지 정보</b></td>
      </tr>
      <tr>
         <td width="200">성명</td>
         <td width="400">
            <input type="text" name="re_name" ></td>
      </tr>
      <tr>
         <td width="200">전화번호</td>
         <td width="400">
            <input type="text" name="re_Tel" ></td>
      </tr>
      <tr>
         <td width="200">주소</td>
         <td width="400">
            <input type="text" name="re_address" ></td>
      </tr>
      <tr>
         <td clospan="2" align="center" >
            <input type="submit" value="확인">
            <input type="button" value="취소" onclick="//메인경로">
         </td>
      </tr>
      </table>
      
   </form>
<%} %>
</body>
</html>

   