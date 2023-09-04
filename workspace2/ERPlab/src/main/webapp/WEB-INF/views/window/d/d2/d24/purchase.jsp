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
<form action="${pageContext.request.contextPath}/d/d2/d22/employee" method="POST">
	<select name="type">
		<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
		<option value="purchase_code" ${param.type == 'purchase_code' ? 'selected' : '' }>코드</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
		<option value="purchase_date" ${param.type == 'purchase_date' ? 'selected' : '' }>매입일자</option>
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="word" id="word">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>매입코드</td>
			<td>담당자</td>
			<td>담당팀</td>
			<td>차변</td>
			<td>대변</td>
			<td>매입일자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="6">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.purchase_no }, '${vo.purchase_code}')">
					<td>${vo.purchase_code }</td>
					<td>${vo.employee1_name}</td>
					<td>${vo.team_name}</td>
					<td>${vo.closing_debtor}</td>
					<td>${vo.closing_creditor}</td>
					<td>${vo.purchase_date }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, code){
    	opener.document.getElementById("purchase_no").value = no;
    	opener.document.getElementById("purchase_code").value = code;
    	
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