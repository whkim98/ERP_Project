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
<h2>재무팀</h2>
<br>
	<input type="button" value="계좌 현황/관리" onclick="location.href='${pageContext.request.contextPath }/account?comcode_code=${comcode_code}'">
	<input type="button" value="자금관리" onclick="location.href='${pageContext.request.contextPath }/funds?comcode_code=${comcode_code}'">
	<input type="button" value="예산관리" onclick="location.href='${pageContext.request.contextPath }/budget?comcode_code=${comcode_code}'">
	
 	<input type="button" value="전표입력" onclick="location.href='${pageContext.request.contextPath }/b31main?comcode_code=${comcode_code}'">
	<input type="button" value="전자세금계산서" onclick="location.href='${pageContext.request.contextPath }/b32main?comcode_code=${comcode_code}'">
	<input type="button" value="외화관리" onclick="location.href='${pageContext.request.contextPath }/b33main'">

	<input type="button" value="마감결산" onclick="location.href='${pageContext.request.contextPath }/b/b4/b41?comcode_code=${comcode_code }'">
	<input type="button" value="원가분석" onclick="location.href='${pageContext.request.contextPath}/d/d1/d18/inputBom?comcode_code=${comcode_code}'">
</div>
</body>
</html>