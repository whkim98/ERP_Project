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
					<td><a style="cursor:pointer" onclick="setParentText(${vo.projectkind_no }, '${vo.projectkind_name }')">${vo.projectkind_name}</a></td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("projectkind_no").value = no;
    	opener.document.getElementById("projectkind_name").value = name;
    	window.close();
    }
</script>
</body>
</html>