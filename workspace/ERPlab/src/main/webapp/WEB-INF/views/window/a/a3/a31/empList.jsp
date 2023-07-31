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
			<td>코드</td>
			<td>이름</td>
			<td>직급</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.employee1_name}', ${vo.employee1_no }, '${vo.employee2_position }', '${vo.employee1_phone }')">${vo.employee1_code}</a></td>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.employee1_name}', ${vo.employee1_no }, '${vo.employee2_position }', '${vo.employee1_phone }')">${vo.employee1_name }</a></td>
					<td><a style="cursor:pointer" onclick="setParentText('${vo.employee1_name}', ${vo.employee1_no }, '${vo.employee2_position }', '${vo.employee1_phone }')">${vo.employee2_position }</a></td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(name, no, position, phone){
    	opener.document.getElementById("employee1_name").value = name;
    	opener.document.getElementById("employee1_no").value = no;
    	opener.document.getElementById("employee1_phone").value = phone;
    	opener.document.getElementById("employee2_position").value = position;
    	window.close();
    }
</script>
</body>
</html>