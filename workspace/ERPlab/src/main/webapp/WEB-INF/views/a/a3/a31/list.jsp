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
			프로젝트 목록이 없습니다.
		</c:when>
		<c:otherwise>
			<table>
				<tr>
					<td>코드</td>
					<td>종류</td>
					<td>이름</td>
					<td>상태</td>
					<td>담당자</td>
					<td>진행팀</td>
				</tr>
			<c:forEach var="map" items="${list }">
				<tr onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/contentP?project_no=${map.project_no }'">
					<td>${map.project_no }</td>
					<td>${map.projectkind_name }</td>
					<td>${map.project_name }</td>
					<c:if test="${map.project_status == 0}">
						<td>미완료</td>
					</c:if>
					<c:if test="${map.project_status == 1}">
						<td>완료</td>
					</c:if>
					<c:if test="${map.project_status == 2}">
						<td>진행중</td>
					</c:if>
					<td>${map.employee1_name }</td>
					<td>${map.team_name }</td>
					<c:if test="${ login == 1 }">
						<td><input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/delete?project_no=${map.project_no }&comcode_code=${comcode_code }'"></td>
					</c:if>
				</tr>
			</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
	
	<form action="${pageContext.request.contextPath }/a/a3/a31/" method="get" onsubmit="return check(this)" >
			<span style="float: left;">
				<select name="type">
					<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>이름</option>
					<option value="projectkind_name" ${param.type == 'projectkind_name' ? 'selected' : '' }>종류</option>
					<option value="project_content" ${param.type == 'project_content' ? 'selected' : '' }>내용</option>
					<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
					<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
				</select>
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
				<input type="submit" value="조회">
			</span>
		</form>	
		<div align="center">
			<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/inputProject'">
		</div>
	
	<div align="center">
		<c:if test="${paging.prev }">
			<a href="${pageContext.request.contextPath }/a/a3/a31/?page=${paging.begin - 1}&type=${param.type}&word=${param.word}&comcode_code=${comcode_code }">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }" step="1">
			<c:choose>
				<c:when test="${i == paging.page }">
					<strong>[${i}]</strong>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath }/a/a3/a31/?page=${i}&type=${param.type}&word=${param.word}&comcode_code=${comcode_code }">[${i }]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.next }">
			<a href="${pageContext.request.contextPath }/a/a3/a31/?page=${paging.end + 1}&type=${param.type}&word=${param.word}&comcode_code=${comcode_code }">[다음]</a>
		</c:if>
	</div>
	
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>