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
<form action="${pageContext.request.contextPath}/a/a3/a32/searchcl" method="POST">
	<select name="type">
		<option value="client_no">번호</option>
		<option value="client_name">거래처명</option>
		<option value="client_manager">담당자명</option>
		<option value="businesstype_name">업태</option>
		<option value="businesstype_subctgr">종목</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>거래처명</td>
			<td>사업자등록번호</td>
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