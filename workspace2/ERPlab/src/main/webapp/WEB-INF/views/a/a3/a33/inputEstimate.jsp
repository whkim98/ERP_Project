<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
<<script type="text/javascript">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/a/a3/a33/estimateAjax";
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
		procode.innerHTML += '<tr><td>번호</td><td>프로젝트명</td><td>평가점수</td><td>평가결과</td><td>최종마감일</td><td>담당팀</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.estimate_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.estimate_no;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.project_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.estimate_score;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.estimate_result;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.estimate_fact;
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
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">실적 등록</h1>
		</div>
		<br>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>이름</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>종류</option>
								<option value="estimate_content" ${param.type == 'estimate_content' ? 'selected' : '' }>내용</option>
								<option value="estimate_fact" ${param.type == 'estimate_fact' ? 'selected' : '' }>거래처</option>
							</select>
						</td>
						<td>
							<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
							<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
						</td>
					</tr>
				</table>
			</div>
			<div>
				<c:choose>
					<c:when test="${list == null }">
						등록된 계약이 없습니다.
					</c:when>
					<c:otherwise>
						<table>
							<tr>
								<td>번호</td>
								<td>프로젝트명</td>
								<td>평가점수</td>
								<td>평가결과</td>
								<td>최종마감일</td>
								<td>담당팀</td>
							</tr>
						<c:forEach var="map" items="${list }">
							<tr onclick="selectForm(${map.estimate_no})">
								<td>${map.estimate_no }</td>
								<td>${map.project_name }</td>
								<td>${map.estimate_score }</td>
								<td>${map.estimate_result }</td>
								<td>${map.estimate_fact }</td>
								<td>${map.team_name }</td>
							</tr>
						</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
	
			<div align="center">
				<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath}/a/a3/a33/inputEstimate?comcode_code=${comcode_code }'">
			</div>
	
		</div>
		
		<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/a/a3/a33/updateForm" id="content" method="post">
				<input type="hidden" name="estimate_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<c:if test="${inmap != null }">
			<div id="add" class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a33/update" method="POST" name="estimate">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
				<input type="hidden" name="project_no" id="project_no" value="${inmap.project_no }">
				<input type="hidden" name="employee1_no" id="employee1_no" value="${inmap.employee1_no }">
					<h3>${inmap.project_name } 평가 수정</h3>
					<table>
						<tr>
							<td>평가점수 </td>
							<td><input type="text" name="estimate_score" id="estimate_score" value="${inmap.estimate_score}"></td>
						</tr>
						<tr>
							<td>평가내용 </td>
							<td><input type="text" name="estimate_content" id="estimate_content" value="${inmap.estimate_content }"></td>
						</tr>
						<tr>
							<td>평가결과 </td>
							<td><input type="text" name="estimate_result" id="estimate_result" value="${inmap.estimate_result}"></td>
						</tr>
						<tr>
							<td>최종마감일 </td>
							<td><input type="text" name="estimate_fact" id="estimate_fact" value="${inmap.estimate_fact }"></td>
						</tr>
						<tr>
							<td>프로젝트명 </td>
							<td><input type="text" name="project_name" id="project_name" onkeypress="searchpr(event, '${comcode_code}')" value="${inmap.project_name }">
							<input type="button" onclick="prList('${comcode_code}')" value="조회"></td>
						</tr>
						<tr>
							<td>상태 </td>
							<td><input type="text" name="project_status" id="project_status" readonly="readonly" value="${inmap.project_status }"></td>
						</tr>
						<tr>
							<td>프로젝트 내용 </td>
							<td><input type="text" name="project_content" id="project_content" readonly="readonly" value="${inmap.project_content }"></td>
						</tr>
						<tr>
							<td>프로젝트 기간 </td>
							<td><input type="text" name="project_start" id="project_start" readonly="readonly" value="${inmap.project_start }"> ~ <input type="text" name="project_end" id="project_end" readonly="readonly" value="${inmap.project_end }"></td>
						</tr>
						<tr>
							<td>프로젝트 담당팀 </td>
							<td><input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)" value="${inmap.team_name }">
							<input type="button" onclick="searcht()" value="조회"></td>
						</tr>
						<tr>
							<td>프로젝트 담당자 </td>
							<td><input type="text" name="employee1_name" id="employee1_name" onkeypress="searchemp(event, '${comcode_code}')" value="${inmap.employee1_name }"></td>
						</tr>
						<tr>
							<td>전화번호 </td>
							<td><input type="text" name="employee1_phone" id="employee1_phone" readonly="readonly" value="${inmap.employee1_phone }"></td>
						</tr>
					</table>
					
					<input type="button" value="update" onclick="sub(this.form)">
					<input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/a/a3/a33/delete?estimate_no=${inmap.estimate_no }&comcode_code=${comcode_code }'">
				</form>
			</div>
		</c:if>
		
		<c:if test="${inmap == null }">
			<div id="add" class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a33/createEstimate" method="POST" name="estimate">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
				<input type="hidden" name="project_no" id="project_no">
				<input type="hidden" name="team_no" id="team_no">
				<input type="hidden" name="employee1_no" id="employee1_no">
					<h3>계약 등록 사항</h3>
					<table>
						<tr>
							<td>평가점수 </td>
							<td><input type="text" name="estimate_score" id="estimate_score"></td>
						</tr>
						<tr>
							<td>평가내용 </td>
							<td><input type="text" name="estimate_content" id="estimate_content"></td>
						</tr>
						<tr>
							<td>평가결과 </td>
							<td><input type="text" name="estimate_result" id="estimate_result"></td>
						</tr>
						<tr>
							<td>최종마감일 </td>
							<td><input type="date" name="estimate_fact" id="estimate_fact"></td>
						</tr>
						<tr>
							<td>프로젝트명 </td>
							<td><input type="text" name="project_name" id="project_name" onkeypress="searchpr(event, '${comcode_code}')">
							<input type="button" onclick="prList('${comcode_code}')" value="조회"></td>
						</tr>
						<tr>
							<td>상태 </td>
							<td><input type="text" name="project_status" id="project_status" readonly="readonly"></td>
						</tr>
						<tr>
							<td>프로젝트 내용 </td>
							<td><input type="text" name="project_content" id="project_content" readonly="readonly"></td>
						</tr>
						<tr>
							<td>프로젝트 기간 :</td>
							<td><input type="date" name="project_start" id="project_start" readonly="readonly"> ~ <input type="date" name="project_end" id="project_end" readonly="readonly"></td>
						</tr>
						<tr>
							<td>평가 담당팀 </td>
							<td><input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회"></td>
						</tr>
						<tr>
							<td>담당자 </td>
							<td><input type="text" name="employee1_name" id="employee1_name" onkeypress="searchemp(event, '${comcode_code}')"></td>
						</tr>
						<tr>
							<td>전화번호 </td>
							<td><input type="text" name="employee1_phone" id="employee1_phone" readonly="readonly"></td>
						</tr>
					</table>
					
					<input type="button" value="save" onclick="sub(this.form)">
					<input type="reset" value="reset">
				</form>
			</div>
		</c:if>
		
	</div>
	<script type="text/javascript">

	function sub(f){
		if(f.estimate_result.value == ""){
			f.estimate_result.focus();
		}else if(f.estimate_content.value == ""){
			f.estimate_content.focus();
		}else if(f.estimate_score.value == ""){
			f.estimate_score.focus();
		}else if(f.project_name.value == ""){
			f.project_name.focus();
		}else if(f.team_name.value == ""){
			f.team_name.focus();
		}else if(f.employee1_name.value == ""){
			f.employee1_name.focus();
		}
		
		if(f.estimate_fact.value = ""){
			var ch = confirm("최종마감일이 입력되지 않았습니다. 계속하시겠습니까?");
			if(ch){
				f.estimate_fact.value = today;
			}else {
				f.estimate_fact.focus();
				return;
			}
		}
		
		var ch = confirm("등록하시겠습니까?")
		if(ch){
			f.submit();
		}else {
			return;
		}
	}
	
	function prList(code){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a33/prList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	
	function searchpr(e, code){
		if(e.keyCode == 13){
			var prname = document.getElementById("project_name").value;
			if(prname == ""){
				alert("조회할 프로젝트명을 입력해주세요.");
				document.getElementById("project_name").focus();
				return;
			}
			var url = "${pageContext.request.contextPath}/a/a3/a33/searchpr";
			var param = "comcode_code="+encodeURIComponent(code)+"&project_name="+encodeURIComponent(prname);
			
			sendRequest(url, param, prName, "POST");
		}
	}
	function prName(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.response;
			if(data != ""){
				var data2 = JSON.parse(data);
				document.getElementById("project_no").value = data2.project_no;
				document.getElementById("project_name").value = data2.project_name;
				if(data2.project_status == 0){
					document.getElementById("project_status").value = "미완료";
				}else if(data2.project_status == 1){
					document.getElementById("project_status").value = "완료";
				}else if(data2.project_status == 2){
					document.getElementById("project_status").value = "진행중";
				}else {
					document.getElementById("project_status").value = "default";
				}
				document.getElementById("project_content").value = data2.project_content;
				document.getElementById("project_start").value = data2.project_start;
				document.getElementById("project_end").value = data2.project_end;
			}else {
				alert("조회된 프로젝트가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 프로젝트를 선택해주세요.");
			}
		}
	}
	
	function searcht(){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}

	// 입력 시 그에 맞는 리스트 오픈
	function searchemp(e, code){
		if(e.keyCode == 13){
			var empname = document.getElementById("employee1_name").value;
			if(empname == ""){
				alert("조회할 담당자 이름을 입력해주세요.");
				document.getElementById("employee1_name").focus();
				return;
			}
			let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchemp?employee1_name="+empname+"&comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
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
	
	// 리스트에서 글 선택 시 넘어가는 form
	function selectForm(no){
		document.getElementsByName("estimate_no")[0].value = no;
		
		document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}
	
</script>
</div>
</body>
</html>