<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
      <div align="center">
         <h1 style="font-size: 20pt;">근태관리</h1>
      </div>
<div align="center">
	<table>
		<tr>
			<th>직원코드</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>내선번호</th>
			<th>잔여휴가</th>
			<th>근로형태</th>
			<th></th>
		</tr>
			<c:forEach var="vo" items="${list }">
		<tr>
				<td>${vo.employee1_code }</td>
				<td>${vo.employee1_name }</td>
				<td>${vo.employee1_phone }</td>
				<td>${vo.employee1_email }</td>
				<td>${vo.employee2_extension }</td>
				<td>${vo.employee2_holiday }</td>
				<td>${vo.employee2_worktype }</td>
				<td><input type="button" value="근태관리" onclick="location.href='${pageContext.request.contextPath }/greeting/attendance/insertForm?employee2_no=${vo.employee2_no }'"></td>
		</tr>
			</c:forEach>
			
	</table>
</div>