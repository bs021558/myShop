<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<% 	String num = request.getParameter("num"); %>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>방명록</title>
</head>
<body>
<form method="post" action="goodsCmtDelPro.jsp">
    <input type='hidden' name="num" value="<%= num%>">
    <table>
        <tr>
            <td>비밀번호</td>
            <td><input type="password" name="passwd"></td>
            <td><input type="submit" value="확인"></td>
        </tr>
    </table>
</form>
<a href="goodsDetail.jsp">돌아가기</a>
</body>
</html>