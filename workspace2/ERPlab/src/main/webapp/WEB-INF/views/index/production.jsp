<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<br><br>
<!-- 각각의 버튼 누르면 페이지 이동 -->
<h2>생산팀</h2>
<br>
	<input type="button" value="자체 생산/제조" onclick="location.href='${pageContext.request.contextPath}/d/d1/d11/inputProduct?comcode_code=${comcode_code}'">
	<input type="button" value="생산의뢰" onclick="location.href='${pageContext.request.contextPath}/d/d1/d12/inputRequestProduct?comcode_code=${comcode_code}'">
	<input type="button" value="작업지시서" onclick="location.href='${pageContext.request.contextPath}/d/d1/d13/inputPed?comcode_code=${comcode_code}'">
	<input type="button" value="생산실적관리" onclick="#">
	<input type="button" value="작업실적관리" onclick="#">
	<input type="button" value="불량분석" onclick="#">
	<input type="button" value="공정재고관리" onclick="#">
	<input type="button" value="발주관리" onclick="#">
	<input type="button" value="매입관리" onclick="#">
	<input type="button" value="재고관리" onclick="#">
	<input type="button" value="재고평가" onclick="#">
</div>
</body>
</html>