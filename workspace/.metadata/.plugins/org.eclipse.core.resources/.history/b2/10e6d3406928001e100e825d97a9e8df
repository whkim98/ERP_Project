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
	<input type="button" value="기자재" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="비품/소모품" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
</div>
</body>
</html>