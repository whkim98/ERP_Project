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
<h2>인사팀</h2>
<br>
	<input type="button" value="인사정보" onclick="location.href='${pageContext.request.contextPath }/greeting?comcode_code=${comcode_code }'">
	<input type="button" value="조직관리" onclick="#">
	<input type="button" value="근태관리" onclick="location.href='${pageContext.request.contextPath }/greeting/attendance?comcode_code=${comcode_code }'">
	<input type="button" value="정산" onclick="location.href='${pageContext.request.contextPath }/greeting/privacy?comcode_code=${comcode_code }'">
	<input type="button" value="퇴직" onclick="location.href='${pageContext.request.contextPath }/greeting/resignList?comcode_code=${comcode_code }'">
</div>
</body>
</html>