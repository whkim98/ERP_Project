<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/a/a3/a32/contractAjax";
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
		procode.innerHTML += '<tr><td>코드</td><td>계약 종류</td><td>계약명</td><td>프로젝트명</td><td>거래처</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.contract_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.contract_no;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.contractkind_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.contract_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.project_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
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
			<h2>계약 관리</h2>
		</div>
		<br>
		<div class="divform2">
			<div>
					<table>
						<tr>
							<td>
								<select name="type">
									<option value="contract_name" ${param.type == 'contract_name' ? 'selected' : '' }>이름</option>
									<option value="contractkind_name" ${param.type == 'contractkind_name' ? 'selected' : '' }>종류</option>
									<option value="contract_content" ${param.type == 'contract_content' ? 'selected' : '' }>내용</option>
									<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
									<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>프로젝트명</option>
								</select>
							</td>
							<td>
								<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
								<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
							</td>
						</tr>
					</table>
			</div>
			<div class="dh_overflow">
				<c:choose>
					<c:when test="${list == null }">
						<table>
							<tr>
								<td>코드</td>
								<td>계약 종류</td>
								<td>계약명</td>
								<td>프로젝트명</td>
								<td>거래처</td>
							</tr>
							<tr><td colspan="5">등록된 계약이 없습니다.</td></tr>
						</table>
						
					</c:when>
					<c:otherwise>
						<table>
							<tr>
								<td>코드</td>
								<td>계약 종류</td>
								<td>계약명</td>
								<td>프로젝트명</td>
								<td>거래처</td>
							</tr>
						<c:forEach var="map" items="${list }">
							<tr onclick="selectForm(${map.contract_no})">
								<td>${map.contract_no }</td>
								<td>${map.contractkind_name }</td>
								<td>${map.contract_name }</td>
								<td>${map.project_name }</td>
								<td>${map.client_name }</td>
							</tr>
						</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			<c:if test="${login == 1 || login == 2 || login == 5 }">
			<div class="dh_alignright">
				<input type="button" value="ADD" onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/inputContract?comcode_code=${comcode_code }'">
			</div>
			</c:if>
	
		</div>
		
		<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath}/a/a3/a32/updateForm" id="content" method="post">
				<input type="hidden" name="contract_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<c:if test="${inmap != null }">
			<div class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a32/update" method="POST" name="contract">
					<input type="hidden" name="comcode_code" value="${comcode_code}">
					<input type="hidden" name="contract_no" value="${inmap.contract_no}">
					<input type="hidden" name="project_no" id="project_no" value="${inmap.project_no}">
					<input type="hidden" name="contractkind_no" id="contractkind_no" value="${inmap.contractkind_no }">
					<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						<div>
							<label>계약명 </label>
							<input type="text" name="contract_name" id="contract_name" value="${inmap.contract_name }" class="required" maxlength="30">
						</div>
						<div>
							<label>계약 종류 </label>
							<input type="text" name="contractkind_name" id="contractkind_name" value="${inmap.contractkind_name }" onkeypress="searchck(event)" class="required">
							<input type="button" onclick="ckList()" value="조회">
						</div>
						<div>
							<label>거래처명 </label>
							<input type="text" name="client_name" id="client_name" value="${inmap.client_name }" onkeypress="searchcl(event, '${comcode_code}')" class="required">
							<input type="button" onclick="clList('${comcode_code}')" value="조회">
						</div>
						<div>
							<label>사업자등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" value="${inmap.client_registeredno }" readonly="readonly">
						</div>
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" value="${inmap.client_manager }" readonly="readonly">
						</div>
						<div>
							<label>계약 기간 </label>
							<input type="date" name="contract_start" id="contract_start" value="${inmap.contract_start}" onchange="startcheck(this.value)" class="required"> ~ 
							<input type="date" name="contract_end" id="contract_end" value="${inmap.contract_end }" class="required">
						</div>
						<div>
							<label>프로젝트명 </label>
							<input type="text" name="project_name" id="project_name" value="${inmap.project_name }" onkeypress="searchpr(event, '${comcode_code}')" class="required">
							<input type="button" onclick="prList('${comcode_code}')" value="조회">
						</div>
						<div>
							<label>프로젝트 예산 </label>
							<input type="text" name="project_budget" id="project_budget" value="${inmap.project_budget }" readonly="readonly">
						</div>
						<div>
							<label>프로젝트 내용 </label>
							<input type="text" name="project_content" id="project_content" value="${inmap.project_content }" readonly="readonly">
						</div>
						<div>
							<label>프로젝트 기간 </label>
							<input type="date" name="project_start" id="project_start" value="${inmap.project_start}" readonly="readonly"> ~ <input type="date" name="project_end" id="project_end" value="${inmap.project_end }" readonly="readonly">
						</div>
						<div>
							<label>계약 내용 </label>
							<input type="text" name="contract_content" id="contract_content" maxlength="1000" value="${inmap.contract_content }" class="required">
						</div>
						<c:if test="${login == 1 || login == 2 || login == 5 }">
						<div>
							<input type="button" value="수정" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/a/a3/a32/delete?contract_no=${inmap.contract_no }&comcode_code=${comcode_code }'">
						</div>
						</c:if>
				</form>
			</div>
		</c:if>
		
		<c:if test="${inmap == null }">
			<div id="add" class="divform3">
				<form action="${pageContext.request.contextPath }/a/a3/a32/createContract" method="POST" name="contract">
					<input type="hidden" name="comcode_code" value="${comcode_code }">
					<input type="hidden" name="client_no" id="client_no">
					<input type="hidden" name="contractkind_no" id="contractkind_no">
					<input type="hidden" name="project_no" id="project_no">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						<div>
							<label>계약명 </label>
							<input type="text" name="contract_name" id="contract_name" class="required" maxlength="30">
						</div>
						<div>
							<label>계약 종류 </label>
							<input type="text" name="contractkind_name" id="contractkind_name" onkeypress="searchck(event)" class="required">
							<input type="button" onclick="ckList()" value="조회">
						</div>
						<div>
							<label>거래처명 </label>
							<input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')" class="required">
							<input type="button" onclick="clList('${comcode_code}')" value="조회">
						</div>
						<div>
							<label>사업자등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" readonly="readonly">
						</div>
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" readonly="readonly">
						</div>
						<div>
							<label>계약 기간 </label>
							<input type="date" name="contract_start" id="contract_start" onchange="startcheck(this.value)" class="required"> ~ 
							<input type="date" name="contract_end" id="contract_end" class="required">
						</div>
						<div>
							<label>프로젝트명 </label>
							<input type="text" name="project_name" id="project_name" onkeypress="searchpr(event, '${comcode_code}')" class="required">
							<input type="button" onclick="prList('${comcode_code}')" value="조회">
						</div>
						<div>
							<label>프로젝트 예산 </label>
							<input type="text" name="project_budget" id="project_budget" readonly="readonly">
						</div>
						<div>
							<label>프로젝트 내용 </label>
							<input type="text" name="project_content" id="project_content" vreadonly="readonly">
						</div>
						<div>
							<label>프로젝트 기간 </label>
							<input type="date" name="project_start" id="project_start" readonly="readonly"> ~ <input type="date" name="project_end" id="project_end" value="${inmap.project_end }" readonly="readonly">
						</div>
						<div>
							<label>계약 내용 </label>
							<input type="text" name="contract_content" id="contract_content" maxlength="1000" class="required">
						</div>
						<c:if test="${login == 1 || login == 2 || login == 5 }">
						<div>
							<input type="button" value="save" onclick="sub(this.form)">
							<input type="reset" value="reset">
						</div>
						</c:if>
				</form>
			</div>
		</c:if>
	</div>
	<script type="text/javascript">
	var pat = /^[0-9]{0,8}$/;
	
	var now_utc = Date.now() // 지금 날짜를 밀리초로
	//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
	var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
	//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
	var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
	var end = new Date(now_utc-timeOff).toISOString().split("-")[0];
	document.getElementById("contract_start").setAttribute("min", end+"-01-01");
	document.getElementById("contract_start").setAttribute("max", end+"-12-31");
	if(document.getElementById("contract_start").value != ""){
		document.getElementById("contract_end").setAttribute("min", document.getElementById("contract_start").value);
		document.getElementById("contract_end").setAttribute("max", end+"-12-31");
	}

	function startcheck(v){
		document.getElementById("contract_end").value = v;
		document.getElementById("contract_end").setAttribute("min", v);
		document.getElementById("contract_end").setAttribute("max", end+"-12-31");
	}
	
	function sub(f){
		if(f.contract_name.value == ""){
			f.contract_name.focus();
			return;
		}else if(f.contractkind_name.value == ""){
			f.contractkind_name.focus();
			return;
		}else if(f.client_name.value == ""){
			f.client_name.focus();
			return;
		}else if(f.contract_start.value == "" || f.contract_end.value == ""){
			f.contract_start.focus();
			return;
		}else if(f.project_name.value == ""){
			f.project_name.focus();
			return;
		}else if(f.contract_content.value == ""){
			f.contract_content.focus();
			return;
		}
		
		if(f.contract_start.value == ""){
			let cc = confirm("계약기간이 입력되지 않았습니다. 계속하시겠습니까?");
			if(cc){
				f.contract_start.value = today;
			}else {
				f.contract_start.focus();
				return;
			}
		}
		
		if(f.contract_end.value == ""){
			let cc = confirm("계약기간이 입력되지 않았습니다. 계속하시겠습니까?");
			if(cc){
				if(f.contract_start.value != ""){
					f.contract_end.value = f.contract_start.value;
				}else {
					f.contract_end.value = today;
				}
			}else {
				f.contract_end.focus();
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
	
	function clList(code){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/clList?&comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	function prList(code){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/prList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	function ckList(){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/ckList", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	
	function searchcl(e, code){
		if(e.keyCode == 13){
			var clname = document.getElementById("client_name").value;
			if(clname == ""){
				alert("조회할 거래처명을 입력해주세요.");
				document.getElementById("client_name").focus();
				return;
			}
			var url = "${pageContext.request.contextPath}/a/a3/a32/searchcl";
			var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
			
			sendRequest(url, param, clName, "POST");
		}
	}
	function clName(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.response;
			if(data != ""){
				var data2 = JSON.parse(data);
				document.getElementById("client_no").value = data2.client_no;
				document.getElementById("client_name").value = data2.client_name;
				document.getElementById("client_registeredno").value = data2.client_registeredno;
				document.getElementById("client_manager").value = data2.client_manager;
			}else {
				alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.")
			}
		}
	}
	
	function searchpr(e, code){
		if(e.keyCode == 13){
			var prname = document.getElementById("project_name").value;
			if(prname == ""){
				alert("조회할 프로젝트명을 입력해주세요.");
				document.getElementById("project_name").focus();
				return;
			}
			var url = "${pageContext.request.contextPath}/a/a3/a32/searchpr";
			var param = "comcode_code="+encodeURIComponent(code)+"&project_name="+prname;
			
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
				document.getElementById("project_budget").value = data2.project_budget;
				document.getElementById("project_content").value = data2.project_content;
				document.getElementById("project_start").value = data2.project_start;
				document.getElementById("project_end").value = data2.project_end;
			}else {
				alert("조회된 프로젝트가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 프로젝트를 선택해주세요.")
			}
		}
	}
	
	function searchck(e){
		if(e.keyCode == 13){
			var ckname = document.getElementById("contractkind_name").value;
			var url = "${pageContext.request.contextPath}/a/a3/a32/searchck";
			var param = "contractkind_name="+encodeURIComponent(ckname);
			sendRequest(url, param, ckName, "POST");
		}
	}
	function ckName(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.response;
			if(data != ""){
				var data2 = JSON.parse(data);
				document.getElementById("contractkind_no").value = data2.contractkind_no;
				document.getElementById("contractkind_name").value = data2.contractkind_name;
			}else {
				alert("조회된 종류가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 종류를 선택해주세요.")
			}
		}
	}
	
	function selectForm(no){
		document.getElementsByName("contract_no")[0].value = no;
		
		document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}
</script>
</div>
</body>
</html>