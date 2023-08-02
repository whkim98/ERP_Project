<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
.notosanskr * { 
 font-family: 'Noto Sans KR', sans-serif;
 font-size:10px;
}

.A31 input{
	width:
}

.divform1 {
	width: 100%;
	height: 20%;
}

.divform2 {
	float: left;
	margin-left: 5%; 
	width:35%;
}

.divform3 {
	float: left;
	margin-left: 5%; 
	width:45%;
}

.divform4 {
	float: left;
	margin-left: 5%;
}

.hr {
	height: 100vh;
	width: 0.1vw;
	border-width: 0;
	color: #000;
	background-color: #000;
}
</style>
</head>
<body class="notosanskr">
	<div>
		<div align="center">
			<h2>프로젝트 등록</h2>
		</div>
		<div align="center" class="divform1">
			<table>
				<tr>
					<td>프로젝트명 :</td>
					<td><input type="text" name="project_name"></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
					<td>조회 구분 :</td>
					<td><select name="project_status">
							<option value="0">미완료</option>
							<option value="1">완료</option>
							<option value="2">진행중</option>
					</select></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
					<td>프로젝트 기간 :</td>
					<td><input type="text" name="project_instdate" size="8" maxlength="8"> ~ <input
						type="text" name="project_enddate" size="8" maxlength="8"></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
				</tr>
				<tr>
					<td>코드 :</td>
					<td><input type="text" name="project_no"></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
					<td>프로젝트 종류 :</td>
					<td><input type="text" name="project_kind"></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
					<td>원청 회사 :</td>
					<td><input type="text" name="project_contractor"></td>
					<td>
						<a href="${pageContext.request.contextPath}/">
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
						</a>
					</td>
				</tr>
			</table>
		</div>
		<hr>
		<div class="divform2">
			<table id="procode">
				<tr>
					<td>이름</td>
					<td>구분</td>
				</tr>
				<tr>
					<td><input type="text" name="project_name" class="erag"
						onkeypress="add(event)" onclick="put(this.value)"></td>
					<td><select name="project_status">
							<option value="1">완료</option>
							<option value="0" selected>미완료</option>
							<option value="2">진행중</option>
					</select></td>
				</tr>
			</table>
		</div>
		<div class="divform4">
			<hr class="hr">
		</div>
		<div id="add" class="divform3">
			<form action="${pageContext.request.contextPath }/a/a3/a32/createContract" method="POST" name="contract">
			<input type="hidden" name="comcode_code" value="${comcode_code }">
			<input type="hidden" name="client_no" id="client_no">
			<input type="hidden" name="contractkind_no" id="contractkind_no">
			<input type="hidden" name="project_no" id="project_no">
				<h3>계약 등록 사항</h3>
				<table>
					<tr>
						<td>계약명 :</td>
						<td><input type="text" name="contract_name" id="contract_name"></td>
					</tr>
					<tr>
						<td>계약 종류 :</td>
						<td><input type="text" name="contractkind_name" id="contractkind_name" onkeypress="searchck(event)"></td>
					</tr>
					<tr>
						<td>거래처명 :</td>
						<td><input type="text" name="client_name" id="client_name" onkeypress="searchcl(event)"></td>
					</tr>
					<tr>
						<td>사업자등록번호 :</td>
						<td><input type="text" name="client_registeredno" id="client_registeredno"></td>
					</tr>
					<tr>
						<td>담당자 :</td>
						<td><input type="text" name="client_manager" id="client_manager"></td>
					</tr>
					<tr>
						<td>계약 기간 :</td>
						<td><input type="text" name="contract_start"> ~ <input type="text" name="contract_end"></td>
					</tr>
					<tr>
						<td>프로젝트명 :</td>
						<td><input type="text" name="project_name" id="project_name" onkeypress="searchpr(event)"></td>
					</tr>
					<tr>
						<td>프로젝트 예산 :</td>
						<td><input type="text" name="project_budget" id="project_budget"></td>
					</tr>
					<tr>
						<td>프로젝트 내용 :</td>
						<td><input type="text" name="project_content" id="project_content"></td>
					</tr>
					<tr>
						<td>프로젝트 기간 :</td>
						<td><input type="text" name="project_start" id="project_start"> ~ <input type="text" name="project_end" id="project_end"></td>
					</tr>
					<tr>
						<td>계약 내용 :</td>
						<td><input type="text" name="contract_content"></td>
					</tr>
				</table>
				
				<input type="button" value="등록" onclick="sub(this.form)">
			</form>
		</div>
	</div>
	<script type="text/javascript">
	function add(e){
		if(e.keyCode == 13){
			var leng = document.getElementsByName("project_name").length - 1;
        	var name = document.getElementsByName("project_name")[leng - 1].value;
        	document.getElementById("project_name").value = name;
        	document.getElementsByName("project_name")[leng - 1].removeAttribute("onkeypress");
		
			var tr = document.createElement("tr");
			var td = document.createElement("td");
			var pc = document.getElementById("procode");
		
			pc.appendChild(tr);
			td = document.createElement("td");
			td.innerHTML = '<input type="text" name="project_name" onkeypress="add(event)" onclick="put(this.value)">';
			tr.appendChild(td);
			td = document.createElement("td");
			td.innerHTML = '<select name="project_status"><option value="1">완료</option><option value="2">미완료</option><option value="3" selected>진행중</option></select>';
			tr.appendChild(td);
		}
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
	
	function searchcl(e){
		if(e.keyCode == 13){
			var clname = document.getElementById("client_name").value;
			if(clname == ""){
				alert("조회할 거래처명을 입력해주세요.");
				document.getElementById("client_name").focus();
				return;
			}
			let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/searchcl?client_name="+clname+"&comcode_code="+'${comcode_code}', "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
		}
	}
	function searchpr(e){
		if(e.keyCode == 13){
			var prname = document.getElementById("project_name").value;
			if(prname == ""){
				alert("조회할 프로젝트명을 입력해주세요.");
				document.getElementById("project_name").focus();
				return;
			}
			let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/searchpr?project_name="+prname+"&comcode_code="+'${comcode_code}', "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
		}
	}
	function searchck(e){
		if(e.keyCode == 13){
			let openWin = window.open("${pageContext.request.contextPath}/a/a3/a32/searchck", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
		}
	}
</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>