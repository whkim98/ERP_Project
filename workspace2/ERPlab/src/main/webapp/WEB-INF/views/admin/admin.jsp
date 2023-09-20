<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="admin-container">

	<form action="${pageContext.request.contextPath}/admin" method="get">
    	<input type="hidden" name="comcode_code" value="${comcode_code}">
    </form>

	<div class="admin-menu">
		
		<h1>계정관리</h1>
		
		<input type="button" id="erpbtn" onclick="location.href='${pageContext.request.contextPath}/admin?comcode_code=${comcode_code}'" value="ERP계정 관리" />
		<input type="button" id="intranetbtn" onclick="location.href='${pageContext.request.contextPath}/intranet?comcode_code=${comcode_code}'" value="인트라넷계정 관리" />
		<p></p>
		
	</div>
	
	<div class="admin-contents">
		<table class="admin-search">
			<tr>
				<td>
					<select name="type">
						<option value="admin_id" ${param.type == 'admin_id' ? 'selected' : '' }>아이디</option>
						<option value="dept_name" ${param.type == 'dept_name' ? 'selected' : '' }>부서</option>
						<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>팀</option>
					</select>
				</td>
				<td>
					<input type="text" placeholder="검색어를 입력하세요" />
				</td>
				<td>
					<input type="button" onclick="" value="검색" />
				</td>
			</tr>
		</table>
		<br>
		
		<div class="admin-add">
			<input type="button" onclick="location.href='${pageContext.request.contextPath}/adminInsert?comcode_code=${comcode_code}'" value="계정추가" />
		</div>
		<br>
		
		<table id="adminERPList">
		
			<tr>
				<th>부서</th>
				<th>팀</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			
		<c:if test="${list !=null}">
		<c:forEach var="map" items="${list}" >
		    <input type="hidden" name="admin_no" id="admin_no" value="${map.admin_no}" />	
			<tr>
				<td name="adminERPdept">${map.dept_name}</td>
				<td name="adminERPteam">${map.team_name}</td>
				<td name="adminERPid">${map.admin_id}</td>
				<td name="adminERPpw">${map.admin_pw}</td>
				<td name="adminERPrevisebtn"><input type="button" onclick="location.href='${pageContext.request.contextPath}/updateFormAdmin?admin_no=${vo.admin_no}&comcode_code=${comcode_code}'" value="수정" /></td>
				<td name="adminERPdeletebtn"><input type="button" onclick="location.href='${pageContext.request.contextPath}/deleteAdmin?admin_no=${vo.admin_no}&comcode_code=${comcode_code}'" value="삭제" /></td>								
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${list == null}">
			<tr>
				<td>내용이 없습니다.</td>
			</tr>
		</c:if>
		
		</table>
			
	</div>

</div>

<script type="text/javascript">




</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
