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
	<form action="${pageContext.request.contextPath }/a/a3/a32/update" method="POST" name="contract">
	<input type="hidden" name="comcode_code" value="${comcode_code}">
	<input type="hidden" name="contract_no" value="${map.contract_no}">
	<input type="hidden" name="project_no" id="project_no" value="${map.project_no}">
	<input type="hidden" name="contractkind_no" id="contractkind_no" value="${map.contractkind_no }">
	<input type="hidden" name="client_no" id="client_no" value="${map.client_no }">
		<h3>계약서 수정</h3>
		<table>
				<tr>
					<td>계약명 :</td>
					<td><input type="text" name="contract_name" value="${map.contract_name }"></td>
				</tr>
				<tr>
					<td>계약 종류 :</td>
					<td><input type="text" name="contractkind_name" id="contractkind_name" value="${map.contractkind_name }">
					<input type="button" onclick="searchck()" value="조회"></td>
				</tr>
				<tr>
					<td>거래처명 :</td>
					<td><input type="text" name="client_name" id="client_name" value="${map.client_name }">
					<input type="button" onclick="searchcl()" value="조회"></td>
				</tr>
				<tr>
					<td>사업자등록번호 :</td>
					<td><input type="text" name="client_registeredno" id="client_registeredno" value="${map.client_registeredno }"></td>
				</tr>
				<tr>
					<td>담당자 :</td>
					<td><input type="text" name="client_manager" id="client_manager" value="${map.client_manager }"></td>
				</tr>
				<tr>
					<td>계약 기간 :</td>
					<td><input type="text" name="contract_start" value="${map.contract_start}"> ~ <input type="text" name="contract_end" value="${map.contract_end }"></td>
				</tr>
				<tr>
					<td>프로젝트명 :</td>
					<td><input type="text" name="project_name" id="project_name" value="${map.project_name }">
					<input type="button" onclick="searchpr()" value="조회"></td>
				</tr>
				<tr>
					<td>프로젝트 예산 :</td>
					<td><input type="text" name="project_budget" id="project_budget" value="${map.project_budget }"></td>
				</tr>
				<tr>
					<td>프로젝트 내용 :</td>
					<td><input type="text" name="project_content" id="project_content" value="${map.project_content }"></td>
				</tr>
				<tr>
					<td>프로젝트 기간 :</td>
					<td><input type="text" name="project_start" value="${map.project_start}"> ~ <input type="text" name="project_end" value="${map.project_end }"></td>
				</tr>
				<tr>
					<td>계약 내용 :</td>
					<td><input type="text" name="contract_content" value="${map.contract_content }"></td>
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

function searchemp(){
	var empname = document.getElementById("employee1_name").value;
	if(empname == ""){
		alert("조회할 담당자 이름을 입력해주세요.");
		document.getElementById("employee1_name").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchemp?employee1_name="+empname+"&comcode_code="+'${comcode_code}', "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function kind(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/kind", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function team(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/team", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
</script>
</body>
</html>