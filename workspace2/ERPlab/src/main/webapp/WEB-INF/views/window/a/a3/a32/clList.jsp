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
			<td>거래처명</td>
			<td>이름</td>
			<td>담당자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.client_no }, '${vo.client_name}', '${vo.client_registeredno }', '${vo.client_manager }')">
					<td>${vo.client_name}</td>
					<td>${vo.client_registeredno }</td>
					<td>${vo.client_manager }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, register, manager){
    	opener.document.getElementById("client_no").value = no;
    	opener.document.getElementById("client_name").value = name;
    	opener.document.getElementById("client_registeredno").value = register;
    	opener.document.getElementById("client_manager").value = manager;
    	window.close();
    }
</script>
</body>
</html>