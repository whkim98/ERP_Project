<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_ContractKind List</title>
</head>
<body>
<div>
	<table>
		<tr>
			<td>번호</td>
			<td>종류</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="2">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.contractkind_no}, '${vo.contractkind_name }')">
					<td>${vo.contractkind_no}</td>
					<td>${vo.contractkind_name }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("contractkind_no").value = no;
    	opener.document.getElementById("contractkind_name").value = name;
    	window.close();
    }
</script>
</body>
</html>