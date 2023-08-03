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
	<form action="${pageContext.request.contextPath}/a/a3/a32/searchck" method="POST">
		<select name="type">
			<option value="contractkind_no">번호</option>
			<option value="contractkind_name">종류</option>
		</select>
		<input type="text" name="word" id="word">
		<input type="button" onclick="sub(this.form)" value="조회">
	</form>
	
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