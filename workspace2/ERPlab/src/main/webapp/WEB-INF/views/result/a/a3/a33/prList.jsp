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
			<td>프로젝트명</td>
			<td>예산</td>
			<td>내용</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.project_no }, '${vo.project_name}', ${vo.project_status }, '${vo.project_content }', '${vo.project_start }', '${vo.project_end }')">
					<td>${vo.project_name}</td>
					<td>${vo.project_budget }</td>
					<td>${vo.project_content }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, status, content, start, end){
    	opener.document.getElementById("project_no").value = no;
    	opener.document.getElementById("project_name").value = name;
    	if(status == 0){
    		opener.document.getElementById("project_status").value = "미완료";
		}else if(status == 1){
			opener.document.getElementById("project_status").value = "완료";
		}else if(status == 2){
			opener.document.getElementById("project_status").value = "진행중";
		}else {
			opener.document.getElementById("project_status").value = "default";
		}
    	opener.document.getElementById("project_content").value = content;
    	opener.document.getElementById("project_start").value = start;
    	opener.document.getElementById("project_end").value = end;
    	window.close();
    }
</script>
</body>
</html>