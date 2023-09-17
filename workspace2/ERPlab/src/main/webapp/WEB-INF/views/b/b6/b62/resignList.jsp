<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/resign/insertForm" method="post">
		<table>
			<tr>
				<th>이름</th>
				<th>사원코드</th>
				<th>주소</th>
				<th>주민등록번호</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>직급</th>
				<th>연차</th>
				<th>연봉</th>
				<th>퇴직여부</th>
				<th></th>
			</tr>
			<c:forEach var="vo" items="${list }">
			<tr>
				<td>${vo.employee1_name }</td>
				<td>${vo.employee1_code }</td>
				<td>${vo.employee1_addr1} ${vo.employee1_addr2 } ${vo.employee1_postal}</td>
				<td>${vo.employee1_residentno }</td>
				<td>${vo.employee1_phone }</td>
				<td>${vo.employee1_email }</td>
				<td>${vo.employee1_id }</td>
				<td>${vo.employee1_pw }</td>
				<td>${vo.employee2_position }</td>
				<td>${vo.employee2_exp }</td>
				<td>${vo.employee2_salary }</td>
				<c:if test="${vo.emphistory_resign != null }">
				<td>Y</td>
				</c:if>
				<c:if test="${vo.emphistory_resign == null }">
				<td>N</td>
				<td><input type="button" value="퇴직등록" onclick="location.href='${pageContext.request.contextPath }/greeting/resign/insertForm?employee2_no=${vo.employee2_no }&employee1_no=${vo.employee1_no }'">
				</c:if>
			</tr>
			</c:forEach>
		</table>
	</form>
</div>