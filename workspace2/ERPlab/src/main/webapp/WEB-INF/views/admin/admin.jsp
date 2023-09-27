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
					<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
				</td>
				<td>
					<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
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
				<td name="adminERPrevisebtn"><input type="button" onclick="location.href='${pageContext.request.contextPath}/updateFormAdmin?admin_no=${map.admin_no}&comcode_code=${comcode_code}'" value="수정" /></td>
				<td name="adminERPdeletebtn"><input type="button" onclick="location.href='${pageContext.request.contextPath}/deleteAdmin?admin_no=${map.admin_no}&comcode_code=${comcode_code}'" value="삭제" /></td>								
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

function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/adminAjax";
	var param = "comcode_code="+code+"&word="+v+"&type="+type;
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("adminERPList");
		let newTr = document.createElement("tr");
		let newTd = document.createElement("td");
		procode.innerHTML = '';
		procode.innerHTML += '<tr><th>부서</th><th>팀</th><th>아이디</th><th>비밀번호</th><th>수정</th><th>삭제</th></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.dept_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.admin_id;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.admin_pw;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="location.href=`${pageContext.request.contextPath}/updateFormAdmin?admin_no='+map.admin_no+'&comcode_code=${comcode_code}`" value="수정" />';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="location.href=`${pageContext.request.contextPath}/deleteAdmin?admin_no='+map.admin_no+'&comcode_code=${comcode_code}`" value="삭제" />';
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="6">목록이 없습니다.</td></tr>';
		}
	}
}


</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
