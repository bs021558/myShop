<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "myshop.goods.*" %>
<%@ page import = "myshop.shopuser.*" %>


<h1><center> 상품 상세 게시판</h1>

<script language="JavaScript">
<!--
function check(no){
   if (no == 1){
      document.form.action = "/myShop/member/cartInsertPro.jsp";
    }else if (no == 2){
         document.form.action = "buyForm.jsp";
    }else{
      return;
    }document.form.submit();
}


  function onChange(count){
  var amount = document.getElementsByName("amount"); 
         if (parseInt(amount[0].value) > count) 
         {
            amount[0].value = count;
            alert("재고가 부족합니다.");
         }
         else if (parseInt(amount[0].value) <= 0) 
         {
            amount[0].value = 1;
              alert("1개 이상 구매해야 합니다.");
          }
  }
-->
</script>

<%
     String cmtPageNum = request.getParameter("cmtPageNum");
     if(cmtPageNum == null) {
     cmtPageNum = "1";  
     }
   
    
     
    String goods_brand = (String)session.getAttribute("sessionId");
    
    
    UserDAO udao = UserDAO.getInstance();
    UserDTO udto = new UserDTO();
    udto = udao.myInfo(goods_brand);
    String Rating= udto.getRating();
    if(Rating == null){
       Rating = "1";   
    }
    
    
    String goods_code = request.getParameter("goods_code");
    int code =0;
    code = Integer.parseInt(goods_code);
   
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null) {
        pageNum = "1";
      
    }
    MyShopDAO dao = MyShopDAO.getInstance();
    MyShopDTO dto = dao.detailGoods(code);
      
%>

<center>
<%@ include file="/include/top.jsp"%> <!-- 상단 -->
   <table border="1" align="center">
   <form name="form" action="/myShop/member/cartInsertPro.jsp" method="post">
   <col style="width:px;">
   <tbody>
      <tr>
      <th><%=dto.getGoods_name()%></th>
      <input type="hidden" size="50"  name="user_id" value="<%=goods_brand%>">
      <input type="hidden" size="50"  name="goods_name" value="<%=dto.getGoods_name()%>">
      <td><img src="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>"></td>
      <input type="hidden" name="goods_img" value="/myShop/imgsave/sellerimg/<%=dto.getGoods_img()%>">
      
      <tr>
         <th>판매가</th>
         <td><%=dto.getGoods_price()%>
         <input type="hidden" size="50"  name="goods_price" value="<%=dto.getGoods_price()%>">
         </td>
         </tr>
      <tr>
         <th>상품코드</th>
         <td><%=dto.getGoods_code()%></td>
         <input type="hidden" size="50"  name="goods_code" value= "<%=dto.getGoods_code()%>">
      </tr>
      <tr>
         <th>판매자</th>
         <td><%=dto.getGoods_brand()%></td>
         <input type="hidden" name="goods_brand" value="<%=dto.getGoods_brand()%>">
      </tr>
      <tr>  
         <th>남은수량</th>
         <td><%=dto.getGoods_count()%></td>
         </td>
      </tr>
      <tr>
         <th>배송비</th>
         <td><%=dto.getGoods_delivery() %></td>
         <input type="hidden" name="goods_delivery" value="<%=dto.getGoods_delivery()%>">
      </tr>
      </tbody>
      </table>
      
<body onload="init();">
<script language="JavaScript">
<!--
var sell_price = document.getElementsByName("sell_price")

function init () {
   sell_price = document.form.sell_price.value;
   amount = document.form.amount.value;
   document.form.sum.value = sell_price;
   change();
}

function add () {
   am = document.form.amount;
   sum = document.form.sum;
   am.value ++ ;

   sum.value = parseInt(am.value) * sell_price;
}

function del () {
   am = document.form.amount;
   sum = document.form.sum;
      if (am.value > 1) {
         am.value -- ;
         sum.value = parseInt(am.value) * sell_price;
      }
}

function change () {
   am = document.form.amount;
   sum = document.form.sum;

      if (am.value < 0) {
         am.value = 0;
      }
   sum.value = parseInt(am.value) * sell_price;
}  
-->
</script>
<form name="all" method="post">
<th>구매수량</th>
<input type="hidden" name="sell_price" value="<%=dto.getGoods_price()%>"  readonly>
<input type="number" name="amount" value="1" readonly onChange="onChange('<%=dto.getGoods_count()%>');">
<input type="button" value=" + " onClick="add();">
<input type="button" value=" - " onClick="del();"><br>

<th>금액</th>
<input type="text" name="sum" size="11" readonly >원
      </form>
  
<%  
   
    if(Rating.equals("2")){ %>
    <h3>판매자 전용</h3>
   
    <input type ="hidden" name="goods_code" value="<%=dto.getGoods_code()%>">
    
    <button onclick="window.location='/myShop/seller/updateDetail.jsp?goods_code=<%=dto.getGoods_code()%>'">수정하기</button>
    <button onclick="window.location='/myShop/seller/sellerStore.jsp?goods_code=<%=dto.getGoods_code()%>'">내 상점 목록</button>
    
    <%}else{

      int count = dto.getGoods_count();
      if(count <= 0 ){ %>
      <script>
      alert("판매중인 상품이 아닙니다.");
      </script>
       <%} else {%>
       <input type="button" value="장바구니" onclick="check(1)">
       <input type="button" value="구매하기" onclick="check(2)"/>
       
       </form>
       <button onclick="window.location='goodsList.jsp'">목록</button><br />
      <%}
    }
    %>
    
            
      <h2>제품설명</h2>
   <br>
   <div style="border: 1px solid; width: 65%">
   <br/>   <%=dto.getGoods_msg() %><br/>  <br/>   </div>
    </center>
<center><h2>상품댓글 :)</h2></center>
<jsp:include page="goodsCmt.jsp">
    <jsp:param name = "cmtpageNum" value = "<%=cmtPageNum %>" />
</jsp:include>

<center><h2>상품 Q&A</h2></center> 
   
<jsp:include page="goodsQnaList.jsp">
    <jsp:param name = "pageNum" value = "<%=pageNum %>" />
</jsp:include>

<br/><br/><br/><br/><br/><br/><br/>
<%@ include file="/include/bottom.jsp" %> <!--하단 -->