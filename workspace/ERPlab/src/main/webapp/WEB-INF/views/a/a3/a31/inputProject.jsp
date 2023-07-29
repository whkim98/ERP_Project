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
					<td>코드</td>
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
			<form action="" method="POST" name="project">
				<h3>프로젝트 등록 사항</h3>
				<table>
					<tr>
						<td>프로젝트명 :</td>
						<td><input type="text" name="project_name" id="project_name"></td>
					</tr>
					<tr>
						<td>프로젝트 기간 :</td>
						<td><input type="text" name="project_instdate"> ~ <input type="text" name="project_enddate"></td>
					</tr>
					<tr>
						<td>원청 회사 :</td>
						<td><input type="text" name="project_contractor"></td>
					</tr>
					<tr>
						<td>프로젝트 예산 :</td>
						<td><input type="text" name="project_budget"></td>
					</tr>
					<tr>
						<td>프로젝트 종류:</td>
						<td><input type="text" name="projectkind_name" id="projectkind_name" onclick="kind()"></td>
					</tr>
					<tr>
						<td>내용 :</td>
						<td><input type="text" name="project_content"></td>
					</tr>
					<tr>
						<td>프로젝트 담당자 :</td>
						<td><input type="text" name="employee1_name" id="employee1_name" onclick="searchemp()" readonly="readonly">
					</tr>
					<tr>
						<td>전화번호 :</td>
						<td><input type="text" name="employee1_phone" id="employee1_phone" readonly="readonly"></td>
					</tr>
					<tr>
						<td>직급 :</td>
						<td><input type="text" name="employee2_position" id="employee2_position" readonly="readonly"></td>
					</tr>
					<tr>
						<td>프로젝트 담당팀 :</td>
						<td><input type="text" name="team_name" id="team_name" onclick="team()"></td>
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
				<input type="hidden" name="employee1_no" id=employee1_no">
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
			td.innerHTML = "<input type='text' name='project_no'>";
			tr.appendChild(td);
			td = document.createElement("td");
			td.innerHTML = '<input type="text" name="project_name" onkeypress="add(event)">';
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
	
	function searchemp(){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/searchemp", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	function kind(){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/kind", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	function team(){
		let openWin = window.open("${pageContext.request.contextPath}/a/a3/a31/team", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	
	function put(name){
		document.getElementById("project_name").value = name;
	}
</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>