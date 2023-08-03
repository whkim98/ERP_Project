<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
	<form action="${pageContext.request.contextPath }/a/a3/a33/updateEstimate" method="POST" name="estimate">
			<input type="hidden" name="comcode_code" value="${comcode_code }">
			<input type="hidden" name="project_no" id="project_no" value="${map.project_no }">
			<input type="hidden" name="employee1_no" id="employee1_no">
				<h3>${map.project_name } 평가 수정</h3>
				<table>
					<tr>
						<td>평가점수 :</td>
						<td><input type="text" name="estimate_score" id="estimate_score" value="${map.estimate_score}"></td>
					</tr>
					<tr>
						<td>평가내용 :</td>
						<td><input type="text" name="estimate_content" id="estimate_content" value="${map.estimate_content }"></td>
					</tr>
					<tr>
						<td>평가결과 :</td>
						<td><input type="text" name="estimate_result" id="estimate_result" value="${map.estimate_result}"></td>
					</tr>
					<tr>
						<td>최종마감일 :</td>
						<td><input type="text" name="estimate_fact" id="estimate_fact" value="${map.estimate_fact }"></td>
					</tr>
					<tr>
						<td>프로젝트명 :</td>
						<td><input type="text" name="project_name" id="project_name" onkeypress="searchpr(event, '${comcode_code}')" value="${map.project_name }">
						<input type="button" onclick="prList('${comcode_code}')" value="조회"></td>
					</tr>
					<tr>
						<td>상태 :</td>
						<td><input type="text" name="project_status" id="project_status" readonly="readonly" value="${map.project_status }"></td>
					</tr>
					<tr>
						<td>프로젝트 내용 :</td>
						<td><input type="text" name="project_content" id="project_content" readonly="readonly" value="${map.project_content }"></td>
					</tr>
					<tr>
						<td>프로젝트 기간 :</td>
						<td><input type="text" name="project_start" id="project_start" readonly="readonly" value="${map.project_start }"> ~ <input type="text" name="project_end" id="project_end" readonly="readonly" value="${map.project_end }"></td>
					</tr>
					<tr>
						<td>프로젝트 담당팀 :</td>
						<td><input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)" value="${map.team_name }">
						<input type="button" onclick="searcht()" value="조회"></td>
					</tr>
					<tr>
						<td>프로젝트 담당자 :</td>
						<td><input type="text" name="employee1_name" id="employee1_name" onkeypress="searchemp(event, '${comcode_code}')" value="${map.employee1_name }"></td>
					</tr>
					<tr>
						<td>전화번호 :</td>
						<td><input type="text" name="employee1_phone" id="employee1_phone" readonly="readonly" value="${map.employee1_phone }"></td>
					</tr>
				</table>
				
				<input type="button" value="수정" onclick="sub(this.form)">
			</form>
</div>

<script type="text/javascript">
function sub(f){
	if(f.contract_name.value == ""){
		alert("계약명을 입력하십시오!");
		f.contract_name.focus();
	}else if(f.contractkind_name.value == ""){
		alert("계약 종류를 입력하십시오!");
		f.contractkind_name.focus();
	}else if(f.client_name.value == ""){
		alert("거래처명을 입력하십시오!");
		f.client_name.focus();
	}else if(f.contract_start.value == "" || f.contract_end.value == ""){
		alert("기간을 입력하십시오!");
		f.contract_start.focus();
	}else if(f.project_name.value == ""){
		alert("프로젝트명을 입력하십시오!");
		f.project_name.focus();
	}else if(f.contract_content.value == ""){
		alert("계약내용을 입력하십시오!");
		f.contract_content.focus();
	}else{
		f.submit();
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
		}else {
			alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
		}
	}
}
</script>
</body>
</html>