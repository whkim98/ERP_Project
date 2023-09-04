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
	<form action="${pageContext.request.contextPath}/a/a3/a32/searchpr" method="POST">
		<select name="type">
			<option value="project_no">번호</option>
			<option value="project_name">프로젝트명</option>
			<option value="project_status">상태</option>
			<option value="team_name">팀명</option>
		</select>
		<input type="hidden" name="comcode_code" value="${comcode_code }">
		<input type="text" name="word" id="word">
		<input type="button" onclick="sub(this.form)" value="조회">
	</form>

	<table>
		<tr>
			<td>프로젝트명</td>
			<td>예산</td>
			<td>내용</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.project_no }, '${vo.project_name}', ${vo.project_budget }, '${vo.project_content }', '${vo.project_start }', '${vo.project_end }')">
					<td>${vo.project_name}</td>
					<td>${vo.project_budget }</td>
					<td>${vo.project_content }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, budget, content, start, end){
    	opener.document.getElementById("project_no").value = no;
    	opener.document.getElementById("project_name").value = name;
    	opener.document.getElementById("project_budget").value = budget;
    	opener.document.getElementById("project_content").value = content;
    	opener.document.getElementById("project_start").value = start;
    	opener.document.getElementById("project_end").value = end;
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