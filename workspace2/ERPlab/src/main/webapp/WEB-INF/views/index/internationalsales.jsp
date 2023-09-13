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
<h2>해외영업팀</h2>
<br>
	<input type="button" value="해외 거래처관리" onclick="location.href='${pageContext.request.contextPath}/internationalsales/list?comcode_code=${comcode_code }'">
	<input type="button" value="수출관리" onclick="location.href='${pageContext.request.contextPath}/internationalsales/export?comcode_code=${comcode_code }'">
	<input type="button" value="수입(매입)" onclick="location.href='${pageContext.request.contextPath}/internationsales/import?comcode_code=${comcode_code }'">
	<input type="button" value="수입발주관리" onclick="location.href='${pageContext.request.contextPath}/internationsales/income?comcode_code=${comcode_code }'">
</div>
</body>
</html>