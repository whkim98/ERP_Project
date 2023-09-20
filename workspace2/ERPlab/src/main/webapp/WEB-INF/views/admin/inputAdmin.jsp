<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
//전체목록조회
function searchpk(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchpk", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

// 입력 시 그에 맞는 리스트 오픈
function searchemp(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchemp?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

//자동완성

function team(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("팀명을 입력해주세요.");
			document.getElementById("team_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a31/team";
		var param = "team_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, teamname, "POST");
	}
}
function teamname(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("team_name").value = data2.team_name;
			document.getElementById("team_no").value = data2.team_no;
		}else {
			alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
		}
	}
}

function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/a/a3/a31/projectAjax";
	var param = "comcode_code="+code+"&word="+v+"&type="+type;
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("procode");
		let newTr = document.createElement("tr");
		let newTd = document.createElement("td");
		procode.innerHTML = '';
		procode.innerHTML += '<tr><td>부서</td><td>팀</td><td>아이디</td><td>비밀번호</td><td>삭제</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.admin_no+")");
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
				newTd.innerHTML = <input type="button" value="삭제" />;
				newTr.appendChild(newTd);
				
			});
		}else {
			procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
		}
	}
}
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
	
		<div class="dh_aligncenter">
		
			<h1>계정관리</h1>
			
			<input type="button" id="erpbtn" value="ERP계정 관리" />
			<input type="button" id="intranetbtn" value="인트라넷계정 관리" />
			<p></p>
		
		</div>
		
		<br>
		<div class="divform2">
			<div class="adminERPlist-head">
				<table>
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
							<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
						</td>
					</tr>
				</table>
			</div>
			
			<div class="adminERPlist-body">
				<c:choose>
					<c:when test="${list == null }">
						내용이 없습니다.
					</c:when>
					<c:otherwise>
						<table id="procode">
							<tr>
								<td>부서</td>
								<td>팀</td>
								<td>아이디</td>
								<td>비밀번호</td>
								<td>삭제</td>
							</tr>
						<c:forEach var="map" items="${list }">
							<tr onclick="selectForm(${map.admin_no})">
								<td>${map.dept_name}</td>
								<td>${map.team_name}</td>
								<td>${map.admin_id}</td>
								<td>${map.admin_pw}</td>
								<td><input type="button" value="삭제" /></td>
							</tr>
						</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="dh_alignright">
				<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/inputAdmin?comcode_code=${comcode_code }'">
			</div>
		</div>
		
		<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath}/updateFormAdmin" id="content" method="post">
				<input type="hidden" name="admin_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<c:if test="${inmap != null }">
			<div class="divform3">
				<form action="${pageContext.request.contextPath }/updateAdmin" method="POST" name="project">
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="hidden" name="admin_no" id="admin_no" value="${inmap.admin_no}">
					<h3>ERP 계정</h3>
					<div>
						<label>아이디</label>
						<input type="text" name="admin_id" id="admin_id">
					</div>
					<div>
						<label>비밀번호</label>
						<input type="text" name="admin_pw" id="admin_pw">
					</div>
					<div>
						<label>팀</label>
						<input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
						<input type="button" onclick="searcht()" value="조회">
						<input type="hidden" name="team_no" id="team_no">
					</div>
					<div>
						<label>부서</label>
						<input type="text" name="project_budget" id="project_budget">
					</div>

					<div>
						<input type="button" value="save" onclick="sub(this.form)">
						<input type="reset" value="reset">
					</div>
					<div>
						<input type="button" value="update" onclick="sub(this.form)">
						<input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/delete?project_no=${inmap.project_no }&comcode_code=${comcode_code }'">
					</div>
				</form>
			</div>
		</c:if>
		
		<c:if test="${inmap == null }">
			<div id="add" class="divform3">
				<form action="${pageContext.request.contextPath}/createAdmin" method="POST" name="project">
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="hidden" name="admin_no" id="admin_no">
					<h3>ERP 계정</h3>
					<div>
						<label>아이디</label>
						<input type="text" name="admin_id" id="admin_id">
					</div>
					<div>
						<label>비밀번호</label>
						<input type="text" name="admin_pw" id="admin_pw">
					</div>
					<div>
						<label>팀</label>
						<input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
						<input type="button" onclick="searcht()" value="조회">
						<input type="hidden" name="team_no" id="team_no">
					</div>
					<div>
						<label>부서</label>
						<input type="text" name="project_budget" id="project_budget">
					</div>

					<div>
						<input type="button" value="save" onclick="sub(this.form)">
						<input type="reset" value="reset">
					</div>
				</form>
			</div>
		</c:if>
	</div>
	
	
<script type="text/javascript">
	
	function sub(f){
		if(f.admin_id.value == ""){
			alert("아이디를 입력하세요");
			f.admin_id.focus();
		}else if(f.admin_pw.value == ""){
			alert("비밀번호를 입력하세요");
			f.admin_pw.focus();
		}else if(f.team_name.value == ""){
			alert("팀을 선택하세요");
			f.team_name.focus();
		}else{
			f.submit();
		}
	}
	
	function put(name){
		document.getElementById("admin_id").value = name;
	}
	
	// 리스트에서 글 선택 시 넘어가는 form
	function selectForm(no){
		document.getElementsByName("admin_no")[0].value = no;
		
		document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp"%>