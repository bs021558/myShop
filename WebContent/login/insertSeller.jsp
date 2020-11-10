<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

	<% request.setCharacterEncoding("UTF-8"); %>

    <h1>판매자 회원가입</h1>
    
    <script language="JavaScript">
    
    function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.user_id.value) {
            alert("ID를 입력하세요");
            return false;
        }
        
        if(!userinput.user_pw.value ) {
            alert("비밀번호를 입력하세요");
            return false;
        }
        if(userinput.user_pw.value != userinput.user_pw2.value)
        {
            alert("비밀번호를 동일하게 입력하세요");
            return false;
        }
       
        if(!userinput.user_name.value) {
            alert("사용자 이름을 입력하세요");
            return false;
            
        }
        if(!userinput.user_phone.value) {
            alert("핸드폰번호를 입력하세요");
            return false;
        }
        
        if(!userinput.user_address.value) {
            alert("주소를 입력하세요");
            return false;
        }
        if(!userinput.business_num.value) {
            alert("주소를 입력하세요");
            return false;
        }
        if(!userinput.bank_num.value) {
            alert("주소를 입력하세요");
            return false;
        }
    }
    
    </script>
    
    <form action="insertPro.jsp" method="post" name="userinput" onSubmit="return checkIt()">
    	<input type = "hidden" name = "join" value = "1" />
    	<input type = "hidden" name = "rating" value = "2" />
    	<input type = "hidden" name = "user_cash" value = "0" />
    	업체명 :   <input type = "text" name= "user_id" />    			<br />
    	pw :   <input type = "text" name= "user_pw" /> 				<br />
    	pw확인 :   <input type = "text" name= "user_pw2" /> 			<br />
    	이름 : <input type = "text" name= "user_name" />   			<br />
    	휴대폰번호 :  <input type = "text" name= "user_phone" />    		<br />
    	주소 :   <input type = "text" name= "user_address" />    <br />
    	사업자 번호 :   <input type = "text" name= "business_num" />    <br />
    	계좌 번호 :   <input type = "text" name= "bank_num" />    <br />
    	<input type = "submit" value= "가입" /> 						<br />
    </form>
    
    <button onclick="window.location='/myShop/login/loginForm.jsp'">로그인</button>
    
    
    
    
   
    