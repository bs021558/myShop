<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String memId = (String)session.getAttribute("sessionId");
   if(memId == null) {
%>      <script>
      alert("로그인 후 글쓰기 가능합니다");
      window.loaction='/web/member/main.jsp';
      </script>
      
   <%}%>   
   
<title>상품등록</title>

<link href="style.css" rel="stylesheet" type="text/css">

</head>


<center>상품등록</center> 

   <center>
   <form action="productPro.jsp" method="post" enctype="multipart/form-data">
      <input type=file name='file1' style='display: none;'>
      <input type='hidden' name='file2' id='file2'> 
      <img src='image.jpg' border='0' onclick='document.all.file1.click(); document.all.file2.value=document.all.file1.value'></br>
      상품코드 <input type="text" size="50"  name="goods_code" readonly></br>
      제조사/브랜드 <input type="text" size="50" name="goods_brand"></br>
      상품이름 <input type="text" size="50"  name="goods_name"></br>
      가격 <input type="text" size="50"  name="goods_price"></br>
      배송비 <input type="text" size="50" name="goods_delivery"></br>
      상품 상태 <input type="text" size="50" name="goods_state"></br>	
      수량 <input type="text" size="50"  name="goods_count"></br>
      상품 설명<textarea name="goods_msg" rows="13" cols="40"></textarea></br>
      
      <input type="submit" value="등록하기">
      <input type="reset" value="다시작성">
 </center>     
 </form>
 