<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지 운영자 문의</title>
</head>
<body>
<%@ include file="/include/top.jsp"%>

<div style="align: center;">
	<form action="opBoardPro.jsp" method="post" style="width:300px; left:40%; right:45%;position: absolute; background-color: yellow;">
			<input type="hidden" value="1" name="op_answer">
			<input type="hidden" value="<%= InetAddress.getLocalHost() %>" name="op_ip">
			
		<table>
			<tr>
				<td style="text-align: right;">사용자 / 업체 명</td>
				<td><input type="text" name="op_id"></td>
			</tr>
			<tr>
				<td style="text-align: right;">전화번호</td>
				<td><input type="text" name="op_phone"></td>
			</tr>
			<tr>
				<td style="text-align: right;">제목</td>
				<td><input type="text" name="op_title"><br /></td>
			</tr>
			<tr>
				<td style="text-align: right;">내용</td>
				<td><input type="text" style="height: 200px;" name="op_content"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" 	value="문의하기"style="width: 100%"></td>
				<td></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>