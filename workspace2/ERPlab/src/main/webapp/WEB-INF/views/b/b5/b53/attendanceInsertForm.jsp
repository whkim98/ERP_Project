<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/attendance/insert" method="post" name="privacy">
	<input type="hidden" name="employee2_no" value="${employee2_no }">
	<table>
		<tr>
			<td>휴가종류</td>
			<td>
				<select name="hdkind_no">
			  		<option value="1">연차</option>
			  		<option value="2">반차</option>
			  		<option value="3">조퇴</option>
			  		<option value="4">지각</option>
			  		<option value="5">결근</option>
			  		<option value="6">경조휴가</option>
			  		<option value="7">병가</option>
			  		<option value="8">예비군</option>
			  		<option value="9">민방위</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>휴가시작일</td>
			<td>
				<input type="text" name="attendance_start" id="attendance_start">
			</td>
		</tr>
		<tr>
			<td>휴가종료일</td>
			<td>
				<input type="text" name="attendance_end" id="attendance_end">
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="입력">
			</td>
		</tr>
	</table>
	</form>
</div>