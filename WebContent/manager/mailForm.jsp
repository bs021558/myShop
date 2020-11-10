<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
    <div>
        <form action="mailPro.jsp" method="post" >
            <table>
                <tr><th colspan="2">JSP 메일 보내기</th></tr>
                <tr><td> </td><td><input type="text" name="from" value="kimheec2000@naver.com"/></td></tr>
                <tr><td>받는사람</td><td><input type="text" name="to" /></td></tr>
                <tr><td>제목</td><td><input type="text" name="subject" /></td></tr>
                <tr><td>내용</td><td><textarea name="content" style="width:170px; height:200px;"></textarea></td></tr>
                <tr><td colspan="2" style="text-align:right;"><input type="submit" value="Transmission"/></td></tr>
            </table>
        </form>
    </div>
</body>
</html>