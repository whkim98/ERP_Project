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
	<input type="button" value="생산실적관리" onclick="location.href='${pageContext.request.contextPath}/d/d1/d14/inputEvaluation?comcode_code=${comcode_code}'">
	<input type="button" value="작업실적관리" onclick="location.href='${pageContext.request.contextPath}/d/d1/d15/inputEvaluemng?comcode_code=${comcode_code}'">
	<input type="button" value="공정재고관리" onclick="location.href='${pageContext.request.contextPath}/d/d1/d17/inputProinventory?comcode_code=${comcode_code}'">
	<input type="button" value="BOM" onclick="location.href='${pageContext.request.contextPath}/d/d1/d18/inputBom?comcode_code=${comcode_code}'">
	<input type="button" value="발주관리" onclick="location.href='${pageContext.request.contextPath}/d/d2/d21/inputOrder?comcode_code=${comcode_code}'">
	<input type="button" value="매입관리" onclick="location.href='${pageContext.request.contextPath}/d/d2/d22/inputPurchase?comcode_code=${comcode_code}'">
	<input type="button" value="재고관리" onclick="location.href='${pageContext.request.contextPath}/d/d2/d23/inputInventory?comcode_code=${comcode_code}'">
	<input type="button" value="재고평가" onclick="location.href='${pageContext.request.contextPath}/d/d2/d24/inputProductTest?comcode_code=${comcode_code}'">
</div>
</body>
</html>