<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/list" method="post" name="privacy">
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<table>
		<tr>
			<td>사원코드</td>
			<td><input type="text" name="employee1_code" id="employee1_code" maxlength="30"></td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>