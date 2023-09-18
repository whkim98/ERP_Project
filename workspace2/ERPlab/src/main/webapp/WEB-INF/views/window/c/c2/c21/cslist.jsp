<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_ClientSort List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<table id="procode">
		<tr>
			<td>종류</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td>정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.clientsort_no }, '${vo.clientsort_name}')">
					<td>${vo.clientsort_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("clientsort_no").value = no;
    	opener.document.getElementById("clientsort_name").value = name;
    	window.close();
    }
	
</script>
</body>
</html>