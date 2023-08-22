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
<form action="${pageContext.request.contextPath}/a/a4/acList" method="POST">
	<select name="type">
		<option value="account_bank">은행명</option>
		<option value="account_num">계좌번호</option>
		<option value="team_name">담당팀</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="hidden" name="team_code" value="${team_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>은행명</td>
			<td>계좌번호</td>
			<td>담당팀</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.account_no }, '${vo.account_bank }', '${vo.account_num}', '${vo.team_name }')">
					<td>${vo.account_bank}</td>
					<td>${vo.account_num }</td>
					<td>${vo.team_name }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, bank, num, team){
    	opener.document.getElementById("account_no").value = no;
    	opener.document.getElementById("account_bank").value = bank;
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