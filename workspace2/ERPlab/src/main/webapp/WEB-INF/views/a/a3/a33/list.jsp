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
					<td>번호</td>
					<td>프로젝트명</td>
					<td>평가점수</td>
					<td>평가결과</td>
					<td>최종마감일</td>
					<td>담당팀</td>
					<c:if test="${ login == 1 }">
						<td>삭제</td>
					</c:if>
				</tr>
			<c:forEach var="map" items="${list }">
				<tr onclick="location.href='${pageContext.request.contextPath}/a/a3/a33/content?estimate_no=${map.estimate_no }'">
					<td>${map.estimate_no }</td>
					<td>${map.project_name }</td>
					<td>${map.estimate_score }</td>
					<td>${map.estimate_result }</td>
					<td>${map.estimate_fact }</td>
					<td>${map.team_name }</td>
					<c:if test="${ login == 1 }">
						<td><input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath}/a/a3/a33/delete?estimate_no=${map.estimate_no }&comcode_code=${comcode_code }'"></td>
					</c:if>
				</tr>
			</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
	
	<form action="${pageContext.request.contextPath }/a/a3/a33/?comcode_code=${comcode_code}" method="get" onsubmit="return check(this)" >
			<span style="float: left;">
				<select name="type">
					<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>이름</option>
					<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>종류</option>
					<option value="estimate_content" ${param.type == 'estimate_content' ? 'selected' : '' }>내용</option>
					<option value="estimate_fact" ${param.type == 'estimate_fact' ? 'selected' : '' }>거래처</option>
				</select>
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
				<input type="submit" value="조회">
			</span>
		</form>	
		<div align="center">
			<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/a/a3/a33/inputEstimate'">
		</div>
	
</div>

<%@include file="/WEB-INF/views/layout/footer.jsp" %>