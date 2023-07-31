<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div align="center">
	<h3>${map.project_name } 프로젝트</h3>
		<table>
			<tr>
				<td>프로젝트명 :</td>
				<td>${map.project_name }</td>
			</tr>
			<tr>
				<td>프로젝트 기간 :</td>
				<td>${map.project_start} ~ ${map.project_end }</td>
			</tr>
			<tr>
				<td>원청 회사 :</td>
				<td>${map.project_contractor }</td>
			</tr>
			<tr>
				<td>프로젝트 예산 :</td>
				<td>${map.project_budget }원</td>
			</tr>
			<tr>
				<td>프로젝트 종류 :</td>
				<td>${map.projectkind_name }</td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td>${map.project_content }</td>
			</tr>
			<tr>
				<td>프로젝트 담당자 :</td>
				<td>${map.employee1_name }</td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td>${map.employee1_phone }</td>
			</tr>
			<tr>
				<td>직급 :</td>
				<td>${map.employee2_position }</td>
			</tr>
			<tr>
				<td>프로젝트 담당팀 :</td>
				<td>${map.team_name }</td>
			</tr>
			<tr>
				<td>상태 :</td>
				<c:if test="${map.project_status == 0 }">
					<td>미완료</td>
				</c:if>
				<c:if test="${map.project_status == 1}">
					<td>완료</td>
				</c:if>
				<c:if test="${map.project_status == 2}">
					<td>진행중</td>
				</c:if>
			</tr>
		</table>
		<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath }/a/a3/a31/updateFormP?project_no=${map.project_no }'">
		<input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath }/a/a3/a31/delete?project_no=${map.project_no }&comcode_code=${comcode_code }'">
		<input type="button" value="계약 관리" onclick="location.href='${pageContext.request.contextPath }/a/a3/a32/?project_no=${map.project_no }'">
</div>

</body>
</html>