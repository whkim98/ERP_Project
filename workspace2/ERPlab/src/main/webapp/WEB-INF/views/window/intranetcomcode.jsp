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
<div align="center">
<form action="${pageContext.request.contextPath}/login/searchcode">
	<table>
		<tr>
			<td>
				<select name="type">
					<option value="" selected>검색</option>
					<option value="code" ${param.type == 'code' ? 'selected' : '' }>코드</option>
					<option value="name" ${param.type == 'name' ? 'selected' : '' }>이름</option>
				</select>
				<input type="text" name="word">
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="submit" value="조회">
			</td>
		</tr>
	</table>
</form>

	<table>
		<tr>
			<td>코드</td>
			<td colspan="2">회사명</td>
		</tr>
		<c:forEach var="vo" items="${list }">
				<tr>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.comcode_code}')">${vo.comcode_code}</a></td>
					<td colspan="2"><a style="cursor:pointer" onclick="setParentText('${vo.comcode_code}')">${vo.comcode_name }</a></td>
				</tr>
		</c:forEach>
	</table>

</div>
</body>
<script type="text/javascript">
	function setParentText(code){
    	opener.document.getElementsByName("comcode_code")[1].value = code;
    	window.close();
    }
</script>
</html>