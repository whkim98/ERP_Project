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
</script>
</body>
</html>