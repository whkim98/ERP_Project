<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Team List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<form action="${pageContext.request.contextPath}/a/a4/searcht" method="POST">
		<select name="type">
			<option value="team_code">코드</option>
			<option value="team_name">이름</option>
		</select>
		<input type="text" name="word" id="word">
		<input type="button" onclick="sub(this.form)" value="조회">
	</form>
	
	<table>
		<tr>
			<td>코드</td>
			<td>팀명</td>
		</tr>
		<c:forEach var="vo" items="${list }">
			<tr onclick="setParentText(${vo.team_no }, '${vo.team_name }')">
				<td>${vo.team_code}</td>
				<td>${vo.team_name}</td>
			</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("team_no").value = no;
    	opener.document.getElementById("team_name").value = name;
    	window.close();
    }
	
	function sub(f){
		if(document.getElementById("word").value == ""){
			alert("조회 내용을 입력해주세요.");
			document.getElementById("word").focus()
		}else {
			f.submit();
		}
	}
</script>
</body>
</html>