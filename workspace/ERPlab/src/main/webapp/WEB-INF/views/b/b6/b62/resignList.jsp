<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/salary/insertForm" method="post">
	<table>
		<tr>
			<th>정산코드</th>
			<th>추가근무일자</th>
			<th>시작시간</th>
			<th>종료시간</th>
			<th>추가수당</th>
		</tr>
			<c:forEach var="vo" items="${list }">
		<tr>
				<td>${vo.salary_code }</td>
				<td>${vo.salary_date }</td>
				<td>${vo.salary_start }</td>
				<td>${vo.salary_end }</td>
				<td>${vo.salary_cash }</td>
		</tr>
			</c:forEach>
		<tr>
			<td colspan="5"><input type="submit" value="추가 등록"></td>
		</tr>
			
	</table>
	</form>
</div>