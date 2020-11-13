<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>공지사항</title>
<script language="JavaScript">
    
    function checkIt() {
        var writeform = eval("document.writeform");
        if(!writeform.subject.value) {
            alert("제목을 입력하세요");
            return false;
        }
        
        if(!writeform.content.value ) {
            alert("내용을 입력하세요");
            return false;
        }
    }
    </script>

<script language="JavaScript" src="script.js"></script>
</head>

<%
	String sessionId = (String) session.getAttribute("sessionId");
	if (sessionId == null) { 
//로그인 경로 수정하기%>
<script>
	alert("회원만 글쓰기가 가능합니다.");
	window.location = '/myShop/board/login.jsp';
</script>
<%
	}

	int num = 0;
	try {
		if (request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
		}
%>

<body>
	<center>
		<b>글쓰기</b> <br>
		<form method="post" name="writeform" action="commuWritePro.jsp" 
			onSubmit="return checkIt()">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="state" value=1>
			
			<table width="400" border="1" cellspacing="0" cellpadding="0"
				align="center">
				<tr>
					<td align="right" colspan="2"><a href="noticeList.jsp"> 글목록</a></td>
				</tr>
				<tr>
					<td width="70" align="center">이 름</td>
					<td width="330"><%=sessionId%><input type="hidden" name="writer" value="<%=sessionId%>"></td>
				</tr>
				<tr>
					<td width="70" align="center">제 목</td>
					<td width="330"><input type="text" size="40" maxlength="50"
						name="subject"></td>
				</tr>
				<tr>
					<td width="70" align="center">내 용</td>
					<td width="330"><textarea name="content" rows="13" cols="40"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center"><input type="submit" value="글쓰기">
						<input type="reset" value="다시작성"> <input type="button"
						value="목록보기" OnClick="window.location='commuList.jsp'"></td>
				</tr>
			</table>
			<%
				} catch (Exception e) {
				}
			%>
		</form>
</body>
</html>
