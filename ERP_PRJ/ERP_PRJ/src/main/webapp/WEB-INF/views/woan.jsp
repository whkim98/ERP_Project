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
	<input type="button" value="계좌 현황/관리" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="자금관리" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="예산관리" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="전표입력" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="외화관리" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="전자세금계산서" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="마감결산" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
	<input type="button" value="원가분석" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
</div>
</body>
</html>