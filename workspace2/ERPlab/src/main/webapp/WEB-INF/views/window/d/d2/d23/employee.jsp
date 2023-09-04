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
<form action="${pageContext.request.contextPath}/d/d2/d22/employee" method="POST">
	<select name="type">
		<option value="employee1_code">코드</option>
		<option value="employee1_name">이름</option>
		<option value="employee2_position">직급</option>
		<option value="team_name">팀</option>
		<option value="dept_name">부서</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>사원코드</td>
			<td>이름</td>
			<td>직급</td>
			<td>팀</td>
			<td>부서</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.employee2_no }, '${vo.employee1_name}', '${vo.employee2_position}', '${vo.employee1_code }', '${vo.employee2_extension }')">
					<td>${vo.employee1_code}</td>
					<td>${vo.employee1_name }</td>
					<td>${vo.employee2_position }</td>
					<td>${vo.team_name }</td>
					<td>${vo.dept_name }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, position, code, ext){
    	opener.document.getElementById("employee2_no").value = no;
    	opener.document.getElementById("employee1_name").value = name;
    	opener.document.getElementById("employee2_position").value = position;
    	opener.document.getElementById("employee1_code").value = code;
    	opener.document.getElementById("employee2_extension").value = ext;
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