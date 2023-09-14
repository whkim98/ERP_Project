<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<tr onclick="setParentText(${vo.account_no }, '${vo.account_bank }', '${vo.account_num }')">
				<td>${vo.account_bank}</td>
				<td>${vo.account_num}</td>
				<td>${vo.account_type}</td>
			</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, num){
    	opener.document.getElementById("account_no").value = no;
    	opener.document.getElementById("account_bank").value = name;
    	opener.document.getElementById("account_num").value = num;
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