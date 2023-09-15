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
<h2>구매팀</h2>
<br>
	<input type="button" value="발주관리" onclick="location.href='${pageContext.request.contextPath}/d/d3/d31/inputOrder?comcode_code=${comcode_code}'">
	<input type="button" value="매입관리" onclick="location.href='${pageContext.request.contextPath}/d/d3/d32/inputPurchase?comcode_code=${comcode_code}'">
	<input type="button" value="재고관리" onclick="location.href='${pageContext.request.contextPath}/d/d3/d33/inputInventory?comcode_code=${comcode_code}'">
	<input type="button" value="재고평가" onclick="location.href='${pageContext.request.contextPath}/d/d3/d34/inputProductTest?comcode_code=${comcode_code}'">
</div>
</body>
</html>