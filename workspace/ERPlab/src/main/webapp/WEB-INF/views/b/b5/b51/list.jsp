<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/employee/insertForm" method="post">
	<table>
		<tr>
			<th>직원코드</th>
			<th>이름</th>
			<th>주소</th>
			<th>주민등록번호</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>장애여부</th>
			<th>국가유공자여부</th>
			<th>내선번호</th>
			<th>직급</th>
			<th>연차</th>
			<th>연봉</th>
			<th>잔여휴가</th>
			<th>사대보험 여부</th>
			<th>근로형태</th>
		</tr>
			<c:forEach var="vo" items="${list }">
		<tr>
				<td>${vo.employee1_code }</td>
				<td>${vo.employee1_name }</td>
				<td>${vo.employee1_addr1 } ${vo.employee1_addr2 } ${vo.employee1_postal}</td>
				<td>${vo.employee1_residentno }</td>
				<td>${vo.employee1_phone }</td>
				<td>${vo.employee1_email }</td>
				<td>${vo.employee1_id }</td>
				<td>${vo.employee1_pw }</td>
				<c:if test="${vo.employee1_disability == 0 }">
					<td>N</td>
				</c:if>
				<c:if test="${vo.employee1_disability == 1 }">
					<td>Y</td>
				</c:if>
				<c:if test="${vo.employee1_merit == 0 }">
					<td>N</td>
				</c:if>
				<c:if test="${vo.employee1_merit == 1 }">
					<td>Y</td>
				</c:if>
				<td>${vo.employee2_extension }</td>
				<td>${vo.employee2_position }</td>
				<td>${vo.employee2_exp }년차</td>
				<td>${vo.employee2_salary }</td>
				<td>${vo.employee2_holiday }</td>
				<c:if test="${vo.employee2_four == 0 }">
					<td>N</td>
				</c:if>
				<c:if test="${vo.employee2_four == 1 }">
					<td>Y</td>
				</c:if>
				<td>${vo.employee2_worktype }</td>
		</tr>
			</c:forEach>
		<tr>
			<td colspan="5"><input type="submit" value="추가 등록"></td>
		</tr>
			
	</table>
	</form>
</div>