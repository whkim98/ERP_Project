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
					<td><input type="text" name="contractkind_name" id="contractkind_name" value="${map.contractkind_name }" onkeypress="searchck(event)">
					<input type="button" onclick="ckList()" value="조회"></td>
				</tr>
				<tr>
					<td>거래처명 :</td>
					<td><input type="text" name="client_name" id="client_name" value="${map.client_name }" onkeypress="searchcl(event, '${comcode_code}')">
					<input type="button" onclick="clList('${comcode_code}')" value="조회"></td>
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
					<td><input type="text" name="project_name" id="project_name" value="${map.project_name }" onkeypress="searchpr(event, '${comcode_code}')">
					<input type="button" onclick="prList('${comcode_code}')" value="조회"></td>
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

function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/clList?&comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function prList(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/prList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function ckList(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/ckList", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

function searchcl(code){
	if(e.keyCode == 13){
		var clname = document.getElementById("client_name").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("client_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a32/searchcl?&comcode_code="+code;
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
</script>
</body>
</html>