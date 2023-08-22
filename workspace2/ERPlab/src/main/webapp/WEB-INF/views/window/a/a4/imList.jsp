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
			<td>종류</td>
		</tr>
		<c:forEach var="vo" items="${list }">
			<tr>
				<td><a style="cursor:pointer" onclick="setParentText(${vo.imkind_no }, '${vo.imkind_name }')">${vo.imkind_name}</a></td>
			</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("imkind_no").value = no;
    	opener.document.getElementById("imkind_name").value = name;
    	window.close();
    }
</script>
</body>
</html>