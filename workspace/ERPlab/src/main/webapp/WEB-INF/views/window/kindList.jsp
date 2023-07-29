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
			<td>프로젝트 종류</td>
		</tr>
		<c:forEach var="vo" items="${list }">
				<tr>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.kind_name }')">${vo.kind_name}</a></td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(name){
    	opener.document.getElementById("kind_name").value = name;
    	window.close();
    }
</script>
</body>
</html>