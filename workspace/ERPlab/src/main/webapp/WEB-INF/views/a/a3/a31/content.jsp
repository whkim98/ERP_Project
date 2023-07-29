<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div align="center">
	<h3>${map.PROJECT_NAME } 프로젝트</h3>
		<table>
			<tr>
				<td>프로젝트명 :</td>
				<td>${map.PROJECT_NAME }</td>
			</tr>
			<tr>
				<td>프로젝트 기간 :</td>
				<td>${map.PROJECT_START} ~ ${map.PROJECT_END }</td>
			</tr>
			<tr>
				<td>원청 회사 :</td>
				<td>${map.PROJECT_CONTRACTOR }</td>
			</tr>
			<tr>
				<td>프로젝트 예산 :</td>
				<td>${map.PROJECT_BUDGET }원</td>
			</tr>
			<tr>
				<td>프로젝트 종류 :</td>
				<td>${map.PROJECTKIND_NAME }</td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td>${map.PROJECT_CONTENT }</td>
			</tr>
			<tr>
				<td>프로젝트 담당자 :</td>
				<td>${map.EMPLOYEE1_NAME }</td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td>${map.EMPLOYEE1_PHONE }</td>
			</tr>
			<tr>
				<td>직급 :</td>
				<td>${map.EMPLOYEE2_POSITION }</td>
			</tr>
			<tr>
				<td>프로젝트 담당팀 :</td>
				<td>${map.TEAM_NAME }</td>
			</tr>
			<tr>
				<td>상태 :</td>
				<c:if test="${map.PROJECT_STATUS } == 0">
					<td>미완료</td>
				</c:if>
				<c:if test="${map.PROJECT_STATUS } == 1">
					<td>완료</td>
				</c:if>
				<c:if test="${map.PROJECT_STATUS } == 2">
					<td>진행중</td>
				</c:if>
			</tr>
		</table>
		<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath }/a/a3/a31/updateForm?project_no=${map.PROJECT_NO }'">
		<input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath }/a/a3/a31/delete?project_no=${map.PROJECT_NO }'">
</div>

</body>
</html>