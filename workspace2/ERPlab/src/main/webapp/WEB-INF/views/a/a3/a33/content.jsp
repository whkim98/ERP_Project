<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div align="center">
	<h3>${map.project_name } 평가 수정</h3>
				<table>
					<tr>
						<td>평가점수 :</td>
						<td>${map.estimate_score}</td>
					</tr>
					<tr>
						<td>평가내용 :</td>
						<td>${map.estimate_content }</td>
					</tr>
					<tr>
						<td>평가결과 :</td>
						<td>${map.estimate_result}</td>
					</tr>
					<tr>
						<td>최종마감일 :</td>
						<td>${map.estimate_fact }</td>
					</tr>
					<tr>
						<td>프로젝트명 :</td>
						<td>${map.project_name }</td>
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
					<tr>
						<td>프로젝트 내용 :</td>
						<td>${map.project_content }</td>
					</tr>
					<tr>
						<td>프로젝트 기간 :</td>
						<td>${map.project_start } ~ ${map.project_end }</td>
					</tr>
					<tr>
						<td>프로젝트 담당팀 :</td>
						<td>${map.team_name }</td>
					</tr>
					<tr>
						<td>프로젝트 담당자 :</td>
						<td>${map.employee1_name }</td>
					</tr>
					<tr>
						<td>전화번호 :</td>
						<td>${map.employee1_phone }</td>
					</tr>
				</table>
		
		<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath }/a/a3/a33/updateForm?estimate_no=${map.estimate_no }'">
		<input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath }/a/a3/a33/delete?estimate_no=${map.estimate_no }&comcode_code=${comcode_code }'">
</div>
</body>
</html>