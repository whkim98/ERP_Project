<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.divform1 {
	width: 100%;
	height: 20%;
}

.divform2 {
	float: left;
	margin-left: 10%;
}

.divform3 {
	float: left;
	margin-left: 10%;
}

.divform4 {
	float: left;
	margin-left: 12%;
}

.hr {
	height: 60vh;
	width: 0.1vw;
	border-width: 0;
	color: #000;
	background-color: #000;
}
</style>
</head>
<body>
	<div>
		<div align="center">
			<h2>.. 등록</h2>
		</div>
		<div align="center" class="divform1">
			<table>
				<tr>
					<td>.. 이름 :</td>
					<td><input type="text" name="project_name"></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
					</td>
					<td>조회 구분 :</td>
					<td><select name="project_status">
							<option value="0">미완료</option>
							<option value="1">완료</option>
							<option value="2">진행중</option>
					</select></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
					</td>
					<td>.. 기간 :</td>
					<td><input type="text" name="project_instdate"> ~ <input
						type="text" name="project_enddate"></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
					</td>
				</tr>
				<tr>
					<td>코드 :</td>
					<td><input type="text" name="project_no"></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
					</td>
					<td>.. 종류 :</td>
					<td><input type="text" name="project_kind"></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
					</td>
					<td>원청 회사 :</td>
					<td><input type="text" name="project_contractor"></td>
					<td>
						<button onclick="${pageContext.request.contextPath}/">돋보기</button>
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
					<td><input type="text" name="project_no"></td>
					<td><input type="text" name="project_name" class="erag"
						onkeypress="add(event)"></td>
					<td><select name="project_status">
							<option value="1">완료</option>
							<option value="0">미완료</option>
							<option value="2" selected>진행중</option>
					</select></td>
				</tr>
			</table>
		</div>
		<div class="divform4">
			<hr class="hr">
		</div>
		<div id="add" class="divform3">
			<form action="" method="POST" name="project">
				<h3>.... 등록 사항</h3>
				<table>
					<tr>
						<td>.. 이름 :</td>
						<td><input type="text" name="project_name" id="project_name"></td>
					</tr>
					<tr>
						<td>.. 기간 :</td>
						<td><input type="text" name="project_instdate"> ~ <input type="text" name="project_enddate"></td>
					</tr>
					<tr>
						<td>.... :</td>
						<td><input type="text" name="project_contractor"></td>
					</tr>
					<tr>
						<td>.. 예산 :</td>
						<td><input type="text" name="project_budget"></td>
					</tr>
					<tr>
						<td>.. 종류:</td>
						<td><input type="text" name="project_kind"></td>
					</tr>
					<tr>
						<td>.. 내용 :</td>
						<td><input type="text" name="project_content"></td>
					</tr>
					<tr>
						<td>.. 담당자 :</td>
						<td><input type="text" name="employee1_name"></td>
					</tr>
					<tr>
						<td>.. 담당팀 :</td>
						<td><input type="text" name="team_name"></td>
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
			alert(".. 명을 입력하십시오!");
			f.project_name.focus();
		}else if(f.project_instdate.value == ""){
			alert("기간을 입력하십시오!");
			f.project_instdate.focus();
		}else if(f.project_enddate.value == ""){
			alert("기간을 입력하십시오!");
			f.project_enddate.focus();
		}else if(f.project_contractor.value == ""){
			alert("회사명을 입력하십시오!");
			f.project_contractor.focus();
		}else if(f.project_budget.value == ""){
			alert("예산을 입력하십시오!");
			f.project_budget.focus();
		}else if(f.project_kind.value == ""){
			alert(".. 종류를 입력하십시오!");
			f.project_kind.focus();
		}else if(f.project_content.value == ""){
			alert("내용을 입력하십시오!");
			f.project_content.focus();
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
	
</script>
</body>
</html>