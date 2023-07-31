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
<h2>전략기획팀</h2>
<br>
	<input type="button" value="프로젝트" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/?comcode_code=${comcode_code}'">
	<input type="button" value="계약관리" onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/?comcode_code=${comcode_code}&project_no=0'">
	<input type="button" value="실적 / 평가" onclick="#">
</div>
</body>
</html>