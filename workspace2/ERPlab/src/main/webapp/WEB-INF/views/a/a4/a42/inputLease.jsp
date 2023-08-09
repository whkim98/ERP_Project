<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

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
<script type="text/javascript" charset="UTF-8">
//전체목록조회
function searchim(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searchim", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function acList(code, team){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/acList?comcode_code="+code+"&team_code="+team, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

//자동완성
function imkind(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("종류를 입력해주세요.");
			document.getElementById("imkind_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a4/imkind";
		var param = "imkind_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, investmentkind, "POST");
	}
}
function investmentkind(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("imkind_name").value = data2.imkind_name;
			document.getElementById("imkind_no").value = data2.imkind_no;
		}else {
			document.getElementById("imkind_name").value = '';
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
		var url = "${pageContext.request.contextPath}/a/a4/team";
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
			document.getElementById("team_name").value = '';
			alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
		}
	}
}

function check(f) {
	if(f.word.value == ""){
		alert("검색어를 입력하십시오!");
		return false;
	}
	
	return true;
}
</script>
</head>
<body class="notosanskr">
	<div>
		<div align="center">
			<h2>자금 유용</h2>
		</div>
		<div align="center" class="divform1">
			
							<img alt="glasses" src="/image/donghyeon/magnifier.png" class="">
					
		</div>
		<hr>
		<div class="divform2">
			<form action="${pageContext.request.contextPath }/a/a4/a42" method="get" onsubmit="return check(this)" >
			<table>
				<tr>
					<td>
						<select name="type">
							<option value="investment_code" ${param.type == 'investment_code' ? 'selected' : '' }>코드</option>
							<option value="imkind_name" ${param.type == 'imkind_name' ? 'selected' : '' }>종류</option>
							<option value="investment_content" ${param.type == 'investment_content' ? 'selected' : '' }>적요</option>
							<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
							<option value="closing_date" ${param.type == 'closing_date' ? 'selected' : '' }>날짜</option>
							<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
						</select>
					</td>
					<td>
						<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
						<input type="submit" value="조회">
						<input type="button" value="전체목록" onclick="location.href='${pageContext.request.contextPath }/a/a4/a42?type=null&comcode_code=${comcode_code }'">
						<input type="hidden" name="comcode_code" value="${comcode_code}">
					</td>
				</tr>
			</table>
			</form>
			<table id="procode">
				<tr>
					<td>코드</td>
					<td>금액</td>
					<td>비고</td>
				</tr>
			<c:if test="${list != null }">
				<c:forEach var="map" items="${list }">
				<tr onclick="location.href='${pageContext.request.contextPath }/a/a4/a42/updateForm?investment_no=${map.investment_no }&bs3_no1=${map.bs3_no1 }&bs3_no2=${map.bs3_no2 }&comcode_code=${comcode_code }'">
					<td>${map.investment_code }</td>
					<td>${map.investment_price }</td>
					<td>${map.investment_note }</td>
				</tr>
				</c:forEach>
			</c:if>
				<tr ondblclick="put(0)" class="put">
					<td><input type="text" name="investment_code" class="erag"></td>
					<td><input type="text" name="investment_price" class="erag"></td>
					<td><input type="text" name="investment_note" class="erag" onkeypress="add(event,0)"></td>
				</tr>
			</table>
		<input type="button" onclick="ins()" id="ins" value="추가">
		<input type="button" onclick="del()" id="del" value="삭제">
		</div>
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<form action="${pageContext.request.contextPath }/a/a4/a42/createLease" method="POST">
			<input type="hidden" name="comcode_code" value="${comcode_code }">
			<input type="hidden" name="imkind_no" id="imkind_no" value="13">
			<input type="hidden" name="ctgr_no" id="ctgr_no" value="8">
			<input type="hidden" name="client_no" id="client_no" value="17">
			<input type="hidden" name="team_no" id="team_no" value="1">
			<input type="hidden" name="bs3_no1" id="bs3_no1">
			<input type="hidden" name="bs3_no2" id="bs3_no2">
			<input type="hidden" name="account_no" id="account_no" value="1">
			<input type="hidden" name="investment_status" id="investment_status" value="2">
				<h3>차입 등록 사항</h3>
				<table>
					<tr>
						<td>코드 : </td>
						<td><input type="text" name="investment_code" id="investment_code"></td>
					</tr>
					<tr>
						<td>기간 :</td>
						<td><input type="text" name="investment_start"> ~ <input type="text" name="investment_end"></td>
					</tr>
					<tr>
						<td>금액 :</td>
						<td><input type="text" name="investment_price" id="investment_price" value="0"></td>
					</tr>
					<tr>
						<td>거래처 :</td>
						<td><input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')">
						<input type="button" onclick="clList('${comcode_code}')" value="조회"></td>
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
						<td>투자 종류:</td>
						<td><input type="text" name="imkind_name" id="imkind_name" onkeypress="imkind(event, this.value)">
						<input type="button" onclick="searchim()" value="조회"></td>
					</tr>
					<tr>
						<td>적요 :</td>
						<td><input type="text" name="investment_content"></td>
					</tr>
					<tr>
						<td>은행 :</td>
						<td><input type="text" name="account_bank" id="account_bank" onkeypress="searchac(event, '${comcode_code}')" readonly="readonly">
						<input type="button" onclick="acList('${comcode_code}', '${map.team_code }')" value="조회"></td>
					</tr>
					<tr>
						<td>계좌번호 :</td>
						<td><input type="text" name="account_num" id="account_num" readonly="readonly"></td>
					</tr>
					<tr>
						<td>차변 :</td>
						<td>
							<select name="debtor_no" id="debtor_no" onchange="check1()">
								<option value="0" selected>선택</option>
							<c:forEach var="vo1" items="${dlist }">
								<option value="${vo1.debtor_no }" id="${vo1.bs3_no }">${vo1.bs3_ctgr }</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>대변 :</td>
						<td>
							<select name="creditor_no" id="creditor_no" onchange="check2()">
								<option value="0" selected>선택</option>
								<c:forEach var="vo2" items="${clist }">
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }">${vo2.bs3_ctgr }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>담당팀 :</td>
						<td><input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
						<input type="button" onclick="searcht()" value="조회"></td>
					</tr>
					<tr>
						<td>비고 :</td>
						<td><input type="text" name="investment_note" id="investment_note"></td>
					</tr>
				</table>
				
				<input type="button" value="등록" onclick="sub(this.form)">
			</form>
		</div>
	</div>
	<script type="text/javascript">
	
	function put(i){
		let v = document.getElementsByName("investment_code")[i].value;
		let arr = document.getElementsByName("investment_code");
		
		var leng = document.getElementsByName("investment_code").length - 1;
		for( var r=0; r<leng; r++ ){
			var name = document.getElementsByName("investment_code")[r].value;
			var price = document.getElementsByName("investment_price")[r].value;
			var note = document.getElementsByName("investment_note")[r].value;
			if(v == name){
				document.getElementById("investment_code").value = name;
				document.getElementById("investment_price").value = price;
				document.getElementById("investment_note").value = note;
			}
		}
	}
		function check1(){
			let t = document.getElementById("debtor_no");
			let arr = document.querySelectorAll("#debtor_no > option");
			let bs3_no1 = document.getElementById("bs3_no1");
			arr.forEach(function(e, i, array) {
				if(t.value == e.value){
					bs3_no1.value = e.id;
				}
			});
		}
		function check2(){
			let t = document.getElementById("creditor_no");
			let arr = document.querySelectorAll("#creditor_no > option");
			let bs3_no2 = document.getElementById("bs3_no2");
			arr.forEach(function(e, i, array) {
				if(t.value == e.value){
					bs3_no2.value = e.id;
				}
			});
		}
	
	
		function sub(f){
			var pat = /^[0-9]{0,8}$/;
			if(f.investment_code.value == ""){
				alert("코드를 입력해주세요.");
				f.investment_code.focus();
				return;
			}else if(f.debtor_no.value == 0){
				alert("차변 계정과목을 선택해주세요.");
				f.debtor_no.focus();
				return;
			}else if(f.creditor_no.value == 0){
				alert("대변 계정과목을 선택해주세요.");
				f.creditor_no.focus();
				return;
			}else if(f.creditor_no.value == f.debtor_no.value){
				alert("계정과목이 같습니다. 다시 선택해주세요.");
				f.debtor_no.focus();
				return;
			}else if(f.investment_price.value == ""){
				var ch = confirm("금액이 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.investment_price.value = 0;
					f.submit();
				}else{
					f.investment_price.focus();
					return;
				}
			}else if(!pat.test(f.investment_price.value)){
				alert("100,000,000미만, 숫자만 입력 가능합니다.");
				f.investment_price.focus();
				return;
			}else if(f.investment_start.value == "" || f.investment_end.value == ""){
				var ch = confirm("기간이 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.investment_end.focus();
					return;
				}
			}else if(f.client_name.value == ""){
				var ch = confirm("거래처가 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.client_name.focus();
					return;
				}
			}else if(f.imkind_name.value){
				var ch = confirm("종류가 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.imkind_name.focus();
					return;
				}
			}else if(f.investment_content.value == ""){
				var ch = confirm("적요가 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.investment_content.focus();
					return;
				}
			}else if(f.account_bank.value == ""){
				var ch = confirm("계좌가 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.account_bank.focus();
					return;
				}
			}else if(f.team_name.value == ""){
				var ch = confirm("담당팀이 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.team_name.focus();
					return;
				}
			}else if(f.investment_note.value == ""){
				var ch = confirm("비고가 입력되지 않았습니다. 등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					f.investment_note.focus();
					return;
				}
			}else {
				var ch = confirm("등록하시겠습니까?");
				if(ch){
					f.submit();
				}else {
					return;
				}
			}
		}
	
	function searchcl(e, code){
		if(e.keyCode == 13){
			var clname = document.getElementById("client_name").value;
			if(clname == ""){
				alert("조회할 거래처명을 입력해주세요.");
				document.getElementById("client_name").focus();
				return;
			}
			var url = "${pageContext.request.contextPath}/a/a4/searchcl";
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
				document.getElementById("client_name").value = '';
				document.getElementById("client_registeredno").value = '';
				document.getElementById("client_manager").value = '';
				alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
			}
		}
	}
	
	
	function add(e,i){
		if(e.keyCode == 13){
			var leng = document.getElementsByName("investment_code").length - 1;
        	var name = document.getElementsByName("investment_code")[i].value;
        	var price = document.getElementsByName("investment_price")[i].value;
        	if(price == ""){
        		price = 0;
        	}
        	var note = document.getElementsByName("investment_note")[i].value;
        	document.getElementById("investment_code").value = name;
        	document.getElementById("investment_price").value = price;
        	document.getElementById("investment_note").value = note;
		}
	}
	
	function ins(){
		let puts = document.querySelectorAll(".put");
		var tr = document.createElement("tr");
		var td = document.createElement("td");
		var pc = document.getElementById("procode");
		
		pc.appendChild(tr);
		tr.setAttribute("ondblclick", "put("+(puts.length)+")");
		tr.setAttribute("class", "put");
		td = document.createElement("td");
		td.innerHTML = '<input type="text" name="investment_code" class="erag">';
		tr.appendChild(td);
		td = document.createElement("td");
		td.innerHTML = '<input type="text" name="investment_price" class="erag">';
		tr.appendChild(td);
		td = document.createElement("td");
		var inp = document.createElement("input");
		inp.setAttribute("type","text");
		inp.setAttribute("name","investment_note");
		inp.setAttribute("class","erag");
		inp.setAttribute("onkeypress","add(event,"+(puts.length)+")");
		td.append(inp);
		tr.appendChild(td);
	}
	
	function del(){
		let tab = document.getElementById("procode");
		tab.deleteRow(-1);
	}
</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>