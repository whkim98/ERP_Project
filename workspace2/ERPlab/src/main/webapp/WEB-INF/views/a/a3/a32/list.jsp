<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">

	function check(f) {
		if(f.word.value == ""){
			alert("검색어를 입력하십시오!");
			return false;
		}
		
		return true;
	}
	
</script>    

<%@include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<c:choose>
		<c:when test="${list == null }">
			등록된 계약이 없습니다.
		</c:when>
		<c:otherwise>
			<table>
				<tr>
					<td>코드</td>
					<td>계약 종류</td>
					<td>계약명</td>
					<td>프로젝트명</td>
					<td>거래처</td>
					<c:if test="${ login == 1 }">
						<td>삭제</td>
					</c:if>
				</tr>
			<c:forEach var="map" items="${list }">
				<tr onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/contentC?contract_no=${map.contract_no }'">
					<td>${map.contract_no }</td>
					<td>${map.contractkind_name }</td>
					<td>${map.contract_name }</td>
					<td>${map.project_name }</td>
					<td>${map.client_name }</td>
					<c:if test="${ login == 1 }">
						<td><input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/delete?project_no=${map.project_no }&comcode_code=${comcode_code }'"></td>
					</c:if>
				</tr>
			</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
	
	<form action="${pageContext.request.contextPath }/a/a3/a32/?comcode_code=${comcode_code}" method="get" onsubmit="return check(this)" >
			<span style="float: left;">
				<select name="type">
					<option value="contract_name" ${param.type == 'contract_name' ? 'selected' : '' }>이름</option>
					<option value="contractkind_name" ${param.type == 'contractkind_name' ? 'selected' : '' }>종류</option>
					<option value="contract_content" ${param.type == 'contract_content' ? 'selected' : '' }>내용</option>
					<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
					<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>프로젝트명</option>
				</select>
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
				<input type="submit" value="조회">
			</span>
		</form>	
		<div align="center">
			<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/inputContract'">
		</div>
	
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>