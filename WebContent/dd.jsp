<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script type="text/javascript">
//prependTo()를 사용해서 더보기 
$('.more').on('click', function(){
	$('<li>추가내용</li>').prependTo('.last_li');	//여기다 데이터를 저장해서 불러오기(json)
});
</script>
<div>
  <ul>
    <li>
      내용
    </li>    
    <li>
      내용2
    </li>
    <li class="last_li">
      <a href="#none" class="more">더보기</a>
    </li>   
 </ul>
</div>


</body>
</html>
