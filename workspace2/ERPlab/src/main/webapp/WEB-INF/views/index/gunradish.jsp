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
<h2>총무팀</h2>
<br>
	<input type="button" value="기자재" onclick="location.href='${pageContext.request.contextPath}/tools?comcode_code=${comcode_code }'">
	<input type="button" value="비품/소모품" onclick="location.href='${pageContext.request.contextPath}/supplies?comcode_code=${comcode_code }'">
</div>
</body>
</html>