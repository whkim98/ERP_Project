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
<h2>국내영업팀</h2>
<br>
	<input type="button" value="국내 거래처관리" onclick="location.href='${pageContext.request.contextPath }/c/c2/c21?comcode_code=${comcode_code }'">
	<input type="button" value="채권관리" onclick="location.href='${pageContext.request.contextPath }/c/c2/c22?comcode_code=${comcode_code }'">
	<input type="button" value="반품관리" onclick="location.href='${pageContext.request.contextPath }/c/c2/c23/inputReturn?comcode_code=${comcode_code }'">
	<input type="button" value="매출현황" onclick="location.href='${pageContext.request.contextPath }/c/c2/c25/inputLocalSales?comcode_code=${comcode_code }'">
</div>
</body>
</html>