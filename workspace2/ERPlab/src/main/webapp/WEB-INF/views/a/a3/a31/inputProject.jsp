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
function kind(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("종류를 입력해주세요.");
			document.getElementById("projectkind_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a31/kind";
		var param = "projectkind_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, projectkind, "POST");
	}
}
function projectkind(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("projectkind_name").value = data2.projectkind_name;
			document.getElementById("projectkind_no").value = data2.projectkind_no;
		}else {
			alert("조회된 종류가 없습니다. 조회 버튼을 클릭하여 목록에서 종류를 선택해주세요.");
		}
	}
}

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
		procode.innerHTML += '<tr><td>코드</td><td>종류</td><td>프로젝트명</td><td>상태</td><td>담당자</td><td>진행팀</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.project_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.project_no;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.projectkind_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.project_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				if(map.project_status == 0){
					newTd.innerHTML = '미완료';
				}else if(map.project_status == 1){
					newTd.innerHTML = '완료'
				}else if(map.project_status == 2){
					newTd.innerHTML = '진행중'
				}
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.employee1_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
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
			<h2>프로젝트 등록</h2>
		</div>
		<br>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>이름</option>
								<option value="projectkind_name" ${param.type == 'projectkind_name' ? 'selected' : '' }>종류</option>
								<option value="project_content" ${param.type == 'project_content' ? 'selected' : '' }>내용</option>
								<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
							</select>
						</td>
						<td>
							<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
							<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
						</td>
					</tr>
				</table>
			</div>
			<c:choose>
				<c:when test="${list == null }">
					프로젝트 목록이 없습니다.
				</c:when>
				<c:otherwise>
					<table id="procode">
						<tr>
							<td>코드</td>
							<td>종류</td>
							<td>이름</td>
							<td>상태</td>
							<td>담당자</td>
							<td>진행팀</td>
						</tr>
					<c:forEach var="map" items="${list }">
						<tr onclick="selectForm(${map.project_no})">
							<td>${map.project_no }</td>
							<td>${map.projectkind_name }</td>
							<td>${map.project_name }</td>
							<c:if test="${map.project_status == 0}">
								<td>미완료</td>
							</c:if>
							<c:if test="${map.project_status == 1}">
								<td>완료</td>
							</c:if>
							<c:if test="${map.project_status == 2}">
								<td>진행중</td>
							</c:if>
							<td>${map.employee1_name }</td>
							<td>${map.team_name }</td>
						</tr>
					</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>
			<div class="dh_alignright">
				<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/inputProject?comcode_code=${comcode_code }'">
			</div>
		</div>
		
		<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/a/a3/a31/updateFormP" id="content" method="post">
				<input type="hidden" name="project_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<c:if test="${inmap != null }">
			<div class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a31/update" method="POST" name="project">
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="hidden" name="project_no" id="project_no" value="${inmap.project_no}">
				<input type="hidden" name="projectkind_no" id="projectkind_no" value="${inmap.projectkind_no}">
					<h3>프로젝트</h3>
					<table>
						<tr>
							<td>프로젝트명 </td>
							<td><input type="text" name="project_name" id="project_name" value="${inmap.project_name }"></td>
						</tr>
						<tr>
							<td>프로젝트 기간 </td>
							<td><input type="date" name="project_start" id="project_start" value="${inmap.project_start}" onchange="startcheck(this.value)"> ~ 
							<input type="date" name="project_end" id="project_end" value="${inmap.project_end }"></td>
						</tr>
						<tr>
							<td>원청 회사 </td>
							<td><input type="text" name="project_contractor" id="project_contractor" value="${inmap.project_contractor }"></td>
						</tr>
						<tr>
							<td>프로젝트 예산 </td>
							<td><input type="text" name="project_budget" id="project_budget" value="${inmap.project_budget }"></td>
						</tr>
						<tr>
							<td>프로젝트 종류 </td>
							<td><input type="text" name="projectkind_name" id="projectkind_name" value="${inmap.projectkind_name }" onkeypress="kind(event, this.value)">
							<input type="button" onclick="searchpk()" value="조회"></td>
						</tr>
						<tr>
							<td>내용 </td>
							<td><input type="text" name="project_content" id="project_content" value="${inmap.project_content }"></td>
						</tr>
						<tr>
							<td>프로젝트 담당자 </td>
							<td><input type="text" name="employee1_name" id="employee1_name" value="${inmap.employee1_name }" onclick="searchemp('${comcode_code}')" readonly="readonly">
							<input type="hidden" name="employee1_no" id="employee1_no" value="${inmap.employee1_no }"></td>
						</tr>
						<tr>
							<td>전화번호 </td>
							<td><input type="text" name="employee1_phone" id="employee1_phone" value="${inmap.employee1_phone }" readonly="readonly"></td>
						</tr>
						<tr>
							<td>직급 </td>
							<td><input type="text" name="employee2_position" id="employee2_position" value="${inmap.employee2_position }" readonly="readonly"></td>
						</tr>
						<tr>
							<td>프로젝트 담당팀 </td>
							<td><input type="text" name="team_name" id="team_name" value="${inmap.team_name }" onkeypress="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
							<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }"></td>
						</tr>
						<tr>
							<td>상태 </td>
							<td>
								<select name="project_status" id="project_status">
									<option value="0" ${inmap.project_status == 0 ? 'selected' : '' }>미완료</option>
									<option value="1" ${inmap.project_status == 1 ? 'selected' : '' }>완료</option>
									<option value="2" ${inmap.project_status == 2 ? 'selected' : '' }>진행중</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="button" value="update" onclick="sub(this.form)">
					<input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/a/a3/a31/delete?project_no=${inmap.project_no }&comcode_code=${comcode_code }'">
				</form>
			</div>
		</c:if>
		
		<c:if test="${inmap == null }">
			<div id="add" class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a31/createProject" method="POST" name="project">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
				<input type="hidden" name="projectkind_no" id="projectkind_no">
					<h3>프로젝트 등록 사항</h3>
					<table>
						<tr>
							<td>프로젝트명 </td>
							<td><input type="text" name="project_name" id="project_name"></td>
						</tr>
						<tr>
							<td>프로젝트 기간 </td>
							<td><input type="date" name="project_start" id="project_start" onchange="startcheck(this.value)"> ~ <input type="date" name="project_end" id="project_end"></td>
						</tr>
						<tr>
							<td>원청 회사 </td>
							<td><input type="text" name="project_contractor" id="project_contractor"></td>
						</tr>
						<tr>
							<td>프로젝트 예산 </td>
							<td><input type="text" name="project_budget" id="project_budget"></td>
						</tr>
						
						<tr>
							<td>프로젝트 종류 </td>
							<td><input type="text" name="projectkind_name" id="projectkind_name" onkeypress="kind(event, this.value)">
							<input type="button" onclick="searchpk()" value="조회"></td>
						</tr>
						<tr>
							<td>내용 </td>
							<td><input type="text" name="project_content" id="project_content"></td>
						</tr>
						<tr>
							<td>프로젝트 담당자 </td>
							<td><input type="text" name="employee1_name" id="employee1_name" onclick="searchemp('${comcode_code}')" readonly="readonly">
							<input type="hidden" name="employee1_no" id="employee1_no"></td>
						</tr>
						<tr>
							<td>전화번호 </td>
							<td><input type="text" name="employee1_phone" id="employee1_phone" readonly="readonly"></td>
						</tr>
						<tr>
							<td>직급 </td>
							<td><input type="text" name="employee2_position" id="employee2_position" readonly="readonly"></td>
						</tr>
						<tr>
							<td>프로젝트 담당팀 </td>
							<td><input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
							<input type="hidden" name="team_no" id="team_no"></td>
						</tr>
						<tr>
							<td>상태 </td>
							<td>
								<select name="project_status" id="project_status">
									<option value="0" selected>미완료</option>
									<option value="1">완료</option>
									<option value="2">진행중</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="button" value="save" onclick="sub(this.form)">
					<input type="reset" value="reset">
				</form>
			</div>
		</c:if>
	</div>
	<script type="text/javascript">
	
	var now_utc = Date.now() // 지금 날짜를 밀리초로
	//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
	var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
	//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	var end = new Date(now_utc-timeOff).toISOString().split("-")[0];
	document.getElementById("project_start").setAttribute("min", end+"-01-01");
	document.getElementById("project_start").setAttribute("max", end+"-12-31");

	function startcheck(v){
		document.getElementById("project_end").value = v;
		document.getElementById("project_end").setAttribute("min", v);
		document.getElementById("project_end").setAttribute("max", end+"-12-31");
	}
	
	function sub(f){
		if(f.project_name.value == ""){
			alert("프로젝트명을 입력하십시오!");
			f.project_name.focus();
		}else if(f.project_start.value == ""){
			alert("실행 날짜를 입력하십시오!");
			f.project_start.focus();
		}else if(f.project_end.value == ""){
			alert("종료 날짜를 입력하십시오!");
			f.project_end.focus();
		}else if(f.project_contractor.value == ""){
			alert("원천회사명을 입력하십시오!");
			f.project_contractor.focus();
		}else if(f.project_budget.value == ""){
			alert("예산을 입력하십시오!");
			f.project_budget.focus();
		}else if(f.projectkind_name.value == ""){
			alert("프로젝트 종류를 입력하십시오!");
			f.projectkind_name.focus();
		}else if(f.employee1_name.value == ""){
			alert("담당자를 입력하십시오!");
			f.employee1_name.focus();
		}else if(f.team_name.value == ""){
			alert("담당팀을 입력하십시오!");
			f.team_name.focus();
		}else{
			f.submit();
		}
	}
	
	function put(name){
		document.getElementById("project_name").value = name;
	}
	
	// 리스트에서 글 선택 시 넘어가는 form
	function selectForm(no){
		document.getElementsByName("project_no")[0].value = no;
		
		document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}
</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>