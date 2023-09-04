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
<form action="${pageContext.request.contextPath}/d/d1/d14/selectProduct" method="POST">
	<select name="type">
		<option value="product_code">생산코드</option>
		<option value="product_name">생상명</option>
		<option value="product_lot">로트번호</option>
		<option value="requestproduct_name">의뢰명</option>
		<option value="employee1_name">담당자</option>
		<option value="team_name">팀</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>생산코드</td>
			<td>생산명</td>
			<td>의뢰명</td>
			<td>담당자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.requestproduct_no }, '${vo.product_code}', '${vo.product_name}')">
					<td class="code">${vo.product_code }</td>
						<td class="price">${vo.product_name }</td>
						<td class="cont">${vo.requestproduct_name}</td>
						<td>${vo.employee1_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, code, name){
    	opener.document.getElementById("requestproduct_no").value = no;
    	opener.document.getElementById("product_code").value = code;
    	opener.document.getElementById("product_name").value = name;
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