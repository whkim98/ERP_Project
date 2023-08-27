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
<form action="${pageContext.request.contextPath}/d/d1/d12/requestproduct" method="POST">
	<select name="type">
		<option value="requestproduct_code">의뢰코드</option>
		<option value="requestproduct_name">의뢰명</option>
		<option value="client_name">거래처명</option>
		<option value="employee1_name">담당자</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>의뢰코드</td>
						<td>의뢰명</td>
						<td>거래처</td>
						<td>담당자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="setParentText(${map.requestproduct_no}, '${map.requestproduct_code }')" class="filter">
						<td class="code">${map.requestproduct_code }</td>
						<td class="price">${map.requestproduct_name }</td>
						<td class="cont">${map.client_name}</td>
						<td>${map.employee1_name}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("requestproduct_no").value = no;
    	opener.document.getElementById("requestproduct_code").value = name;
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