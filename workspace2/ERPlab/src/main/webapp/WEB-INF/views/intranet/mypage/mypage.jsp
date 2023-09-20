<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/intranet/layout/header.jsp" %>


<div class="intranetAdmin-container">

	<div class="intranetAdmin">
	
		<form>
	
		<table class="intranetAdmin-myinfo">
			<tr>
				<td>직원아이디</td>
				<td>int.employee1_id</td>
			</tr>
			<tr>
				<td>현재 비밀번호</td>
				<td><input type="text" placeholder="현재 비밀번호를 입력하세요"></td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="text" placeholder="변경할 비밀번호를 입력하세요"></td>
			</tr>	
			<tr>
				<td>변경할 비밀번호(재입력)</td>
				<td><input type="text" placeholder="변경할 비밀번호를 재입력하세요"></td>
			</tr>	
		</table>
		
		<input type="button" value="비밀번호 변경" />
	
		</form>

	</div>

</div>

</body>
</html>