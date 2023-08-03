<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/salary/insert" method="post" name="privacy">
	<table>
		<tr>
			<td>정산코드</td>
			<td><input type="text" name="salary_code" id="salary_code"></td>
		</tr>
		<tr>
			<td>추가근무일자</td>
			<td><input type="text" name="salary_date" id="salary_date"></td>
		</tr>
		<tr>
			<td>시작시간</td>
			<td><input type="text" name="salary_start" id="salary_start"></td>
		</tr>
		<tr>
			<td>종료시간</td>
			<td><input type="text" name="salary_end" id="salary_end"></td>
		</tr>
		<tr>
			<td>근무종류</td>
			<td><input type="text" name="salarytype_name" id="salarytype_name"></td>
		</tr>
		<tr>
			<td>사원코드</td>
			<td><input type="text" name="employee1_code" id="employee1_code"></td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>