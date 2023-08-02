<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
	<form action="${pageContext.request.contextPath }/a/a3/a31/update" method="POST" name="project">
	<input type="hidden" name="comcode_code" value="${comcode_code}">
	<input type="hidden" name="project_no" id="project_no" value="${map.project_no}">
	<input type="hidden" name="projectkind_no" id="projectkind_no" value="${map.projectkind_no}">
		<h3>${map.project_name } 프로젝트</h3>
		<table>
			<tr>
				<td>프로젝트명 :</td>
				<td><input type="text" name="project_name" value="${map.project_name }"></td>
			</tr>
			<tr>
				<td>프로젝트 기간 :</td>
				<td><input type="text" name="project_start" value="${map.project_start}"> ~ 
				<input type="text" name="project_end" value="${map.project_end }"></td>
			</tr>
			<tr>
				<td>원청 회사 :</td>
				<td><input type="text" name="project_contractor" value="${map.project_contractor }"></td>
			</tr>
			<tr>
				<td>프로젝트 예산 :</td>
				<td><input type="text" name="project_budget" value="${map.project_budget }"></td>
			</tr>
			<tr>
				<td>프로젝트 종류 :</td>
				<td><input type="text" name="projectkind_name" id="projectkind_name" value="${map.projectkind_name }" onkeypress="kind(event)" readonly="readonly">
				<input type="button" onclick="searchpk()" value="조회"></td></td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td><input type="text" name="project_content" value="${map.project_content }"></td>
			</tr>
			<tr>
				<td>프로젝트 담당자 :</td>
				<td><input type="text" name="employee1_name" id="employee1_name" value="${map.employee1_name }" onkeypress="searchemp(event)">
				<input type="hidden" name="employee1_no" id="employee1_no" value="${map.employee1_no }"></td>
			</tr>
			<tr>
				<td>전화번호 :</td>
				<td><input type="text" name="employee1_phone" id="employee1_phone" value="${map.employee1_phone }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>직급 :</td>
				<td><input type="text" name="employee2_position" id="employee2_position" value="${map.employee2_position }" readonly="readonly"></td>
			</tr>
			<tr>
				<td>프로젝트 담당팀 :</td>
				<td><input type="text" name="team_name" id="team_name" value="${map.team_name }" onkeypress="team(event)" readonly="readonly">
				<input type="button" onclick="searcht()" value="조회">
				<input type="hidden" name="team_no" id="team_no" value="${map.team_no }"></td>
			</tr>
			<tr>
				<td>상태 :</td>
				<td>
					<select name="project_status">
						<option value="0" selected>미완료</option>
						<option value="1">완료</option>
						<option value="2">진행중</option>
					</select>
				</td>
			</tr>
		</table>
		<input type="button" value="수정" onclick="sub(this.form)">
	</form>
</div>

<script type="text/javascript">
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

//전체목록조회
function searchpk(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchpk", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

// 입력 시 그에 맞는 리스트 오픈
function searchemp(e){
	if(e.keyCode == 13){
		var empname = document.getElementById("employee1_name").value;
		if(empname == ""){
			alert("조회할 담당자 이름을 입력해주세요.");
			document.getElementById("employee1_name").focus();
			return;
		}
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchemp?employee1_name="+empname+"&comcode_code="+'${comcode_code}', "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
}

// 자동완성
function kind(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("종류를 입력해주세요.");
			document.getElementById("projectkind_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a31/kind";
		var param = "porjectkind_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, projectkind, "POST");
	}
}
function projectkind(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		document.getElementById("projectkind_name").value = data.projectkind_name;
		document.getElementById("projectkind_no").value = data.projectkind_no;
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
		document.getElementById("team_name").value = data.team_name;
		document.getElementById("team_no").value = data.team_no;
}
</script>
</body>
</html>