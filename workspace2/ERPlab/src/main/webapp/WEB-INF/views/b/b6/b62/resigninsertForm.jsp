<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/resign/insert" method="post" name="privacy">
	<input type="hidden" name="employee2_no" value="${employee2_no }">
	<input type="hidden" name="employee1_no" value="${employee1_no }">
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<table>
		<tr>
			<td>퇴직코드</td>
			<td><input type="text" name="resign_code" id="resign_code" maxlength="30"></td>
		</tr>
		<tr>
			<td>퇴직날짜</td>
			<td><input type="date" name="resign_date" id="resign_date"></td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>