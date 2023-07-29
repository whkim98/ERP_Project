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
				<tr>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.team_name }')">${vo.team_code}</a></td>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.team_name }')">${vo.team_name}</a></td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(name){
    	opener.document.getElementById("team_name").value = name;
    	window.close();
    }
</script>
</body>
</html>