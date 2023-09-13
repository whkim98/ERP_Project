<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/employee/insert" method="post" name="privacy">
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<table>
		<tr>
			<td>사원코드</td>
			<td><input type="text" name="employee1_code" id="employee1_code"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="employee1_name" id="employee1_name"></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="employee1_addr1" id="employee1_addr1"> <input type="text" name="employee1_addr2" id="employee1_addr2"> <input type="text" name="employee1_postal" id="employee1_postal"></td>
		</tr>
		<tr>
			<td>주민등록번호</td>
			<td><input type="text" name="employee1_residentno" id="employee1_residentno"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="employee1_phone" id="employee1_phone"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="employee1_email" id="employee1_email"></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="employee1_id" id="employee1_id"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="employee1_pw" id="employee1_pw"></td>
		</tr>
		<tr>
			<td>장애여부</td>
			<td>
				<select name="employee1_disability">
			  		<option value="0">N</option>
			  		<option value="1">Y</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>국가유공자여부</td>
			<td>
				<select name="employee1_merit">
			  		<option value="0">N</option>
			  		<option value="1">Y</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>소속팀</td>
			<td>
				<select name="team_no">
			  		<option value="3">경영기획팀</option>
			  		<option value="4">전략기획팀</option>
			  		<option value="6">회계팀</option>
			  		<option value="7">재무팀</option>
			  		<option value="8">인사팀</option>
			  		<option value="9">총무팀</option>
			  		<option value="11">해외영업팀</option>
			  		<option value="12">국내영업팀</option>
			  		<option value="13">매장영업팀</option>
			  		<option value="14">영업관리팀</option>
			  		<option value="16">생산팀</option>
			  		<option value="17">구매팀</option>
			  		<option value="18">품질관리팀</option>
			  		<option value="19">물류팀</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>내선번호</td>
			<td><input type="text" name="employee2_extension" id="employee2_extension"></td>
		</tr>
		<tr>
			<td>직급</td>
			<td><input type="text" name="employee2_position" id="employee2_position"></td>
		</tr>
		<tr>
			<td>연봉</td>
			<td><input type="text" name="employee2_salary" id="employee2_salary"></td>
		</tr>
		<tr>
			<td>잔여휴가</td>
			<td><input type="text" name="employee2_holiday" id="employee2_holiday"></td>
		</tr>
		<tr>
			<td>사대보험여부</td>
			<td>
				<select name="employee2_four">
			  		<option value="0">N</option>
			  		<option value="1">Y</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>근무형태</td>
			<td>
				<select name="employee2_worktype">
			  		<option value="정규">정규</option>
			  		<option value="비정규">비정규</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>