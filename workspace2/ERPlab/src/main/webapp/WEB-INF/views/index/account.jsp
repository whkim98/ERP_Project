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
<h2>회계팀</h2>
<br>
	<input type="button" value="재무상태표" onclick="location.href='${pageContext.request.contextPath}/b11main?comcode_code=${comcode_code}'">
	<input type="button" value="손익계산서" onclick="location.href='${pageContext.request.contextPath}/b12main?comcode_code=${comcode_code}'">
	<input type="button" value="현금흐름표" onclick="location.href='${pageContext.request.contextPath}/b13main?comcode_code=${comcode_code}'">	
</div>
</body>
</html>