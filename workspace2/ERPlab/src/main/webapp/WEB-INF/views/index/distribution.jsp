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
<h2>물류팀</h2>
<br>
	<input type="button" value="재고관리" onclick="location.href='${pageContext.request.contextPath}/stock?comcode_code=${comcode_code }'">
	<input type="button" value="입출고관리" onclick="location.href='${pageContext.request.contextPath}/management?comcode_code=${comcode_code }'">
</div>
</body>
</html>