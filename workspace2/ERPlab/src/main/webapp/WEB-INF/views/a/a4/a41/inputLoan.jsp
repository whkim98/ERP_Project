<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>


<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css"/>
<style type="text/css">
.notosanskr * { 
 font-family: 'Noto Sans KR', sans-serif;
 font-size:10px;

}

.notosanskr{ 
 	margin-top: 70px;
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
	color: rgba(160, 160, 160, 0.3);
	background-color: rgba(160, 160, 160, 0.3);
	
}

input#search {
background:url(/image/search-glass.png);
background-repeat: no-repeat;
width:20px;
height:20px;
border: 0;
}
</style>
<script type="text/javascript" charset="UTF-8">

function surf(v, code){		// list ajax 함수 > A4Controller, a4.xml(investmentList select문)
	var type = document.getElementsByName("type")[0].value;
	var url = "${pageContext.request.contextPath}/a/a4/a41/loanAjax";	// controller mapping
	if(v == ''){
		type = null;
		v = null;
	}
	console.log(v);
	var param = "comcode_code="+code+"&word="+v+"&type="+type;		// 넘길 데이터
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("procode"); 	// list가 들어갈 테이블 id
		let newTr = document.createElement("tr");		// tr 만듦
		let newTd = document.createElement("td");		// td 만듦
		procode.innerHTML = '';							// 일단 테이블 비워줌
		procode.innerHTML += '<tr><td>코드</td><td>금액</td><td>적요</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){		// 받아온 list 테이블에 입히기
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.investment_no+", "+map.bs3_no1+", "+map.bs3_no2+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.investment_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.investment_price;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.investment_content;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
		}
	}
}


//전체목록조회 > 새창으로
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

//자동완성 > AJAX
function imkind(e, name){
	if(e.keyCode == 13){
		if(name == ""){		// 매개변수값이 비어있는 지 판단
			alert("종류를 입력해주세요.");
			document.getElementById("imkind_name").focus();
			return;	// 비어있으면 imkind_name에 포커싱되고 메소드 종료
		}
		var url = "${pageContext.request.contextPath}/a/a4/imkind";		// url 경로 지정 > controller 매핑
		var param = "imkind_name=" + encodeURIComponent(name);		// controller에 넘길 데이터 인코드해서 세팅
		
		sendRequest(url, param, investmentkind, "POST");	// httpRequest.js에 있는 sendRequest함수 실행 > (경로,넘길데이터,콜벡함수,방식);
	}
}
function investmentkind(){	// 콜벡함수
	if(xhr.readyState==4 && xhr.status==200) {		// 신호가 정상인 지 판단
		var data = xhr.response;	// 넘어온 데이터 세팅
		if(data != ""){			// 넘어온 데이터가 null인지 판단
			var data2 = JSON.parse(data);		// 넘어온 데이터 json으로 변형
			document.getElementById("imkind_name").value = data2.imkind_name;	// 넘어온 데이터 input태그에 세팅
			document.getElementById("imkind_no").value = data2.imkind_no;
		}else {
			document.getElementById("imkind_name").value = '';		// 데이터가 비어있으면 실행
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
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">자금 조달</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="investment_code" ${param.type == 'investment_code' ? 'selected' : '' }>코드</option>
								<option value="imkind_name" ${param.type == 'imkind_name' ? 'selected' : '' }>종류</option>
								<option value="investment_content" ${param.type == 'investment_content' ? 'selected' : '' }>적요</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
								<option value="closing_date" ${param.type == 'closing_date' ? 'selected' : '' }>작성날짜</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
							</select>
						</td>
						<td>
							<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
							<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
						</td>
					</tr>
				</table>
			</div>
			
			<div style="overflow: scroll;">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>코드</td>
						<td>금액</td>
						<td>적요</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.investment_no}, ${map.bs3_no1}, ${map.bs3_no2 })" class="filter" id="filter">
						<td class="code">${map.investment_code }</td>
						<td class="price">${map.investment_price }</td>
						<td class="cont">${map.investment_content }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/a/a4/a41?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/a/a4/a41/updateForm" id="content" method="post">
				<input type="hidden" name="investment_no">
				<input type="hidden" name="bs3_no1">
				<input type="hidden" name="bs3_no2">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/a/a4/a41/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="investment_no" value="${inmap.investment_no }">
						<input type="hidden" name="imkind_no" id="imkind_no" value="${inmap.imkind_no }">
						<input type="hidden" name="ctgr_no" id="ctgr_no" value="8">
						<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
						<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }">
						<input type="hidden" name="account_no" id="account_no" value="${inmap.account_no }">
						<input type="hidden" name="bs3_no11" id="bs3_no11" value="${bs3_no1 }">
						<input type="hidden" name="bs3_no21" id="bs3_no21" value="${bs3_no2 }">
						<input type="hidden" name="bs3_no12" id="bs3_no12">
						<input type="hidden" name="bs3_no22" id="bs3_no22">
						<input type="hidden" name="investment_status" id="investment_status" value="1">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>코드 </label>
							<input type="text" name="investment_code" id="investment_code" value="${inmap.investment_code }" readonly="readonly" maxlength="30" class="required">
						</div>
						
						<div>
							<label>기간 </label>
							<input type="date" name="investment_start" id="investment_start" value="${inmap.investment_start }"> ~ <input type="date" name="investment_end" id="investment_end" value="${inmap.investment_end }">
						</div>
						
						<div>
							<label>금액 </label>
							<input type="text" name="investment_price" id="investment_price" value="${inmap.investment_price }">
						</div>				
						
						<div>
							<label>거래처 </label>
							<input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')" value="${cvo.client_name }">
							<input type="button" onclick="clList('${comcode_code}')" value="조회">
						</div>	
							
						<div>
							<label>사업자등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" readonly="readonly" value="${cvo.client_registeredno }">
						</div>	
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" readonly="readonly" value="${cvo.client_manager }">
						</div>
						
						<div>
							<label>투자 종류</label>
							<input type="text" name="imkind_name" id="imkind_name" value="${inmap.imkind_name }" onkeypress="imkind(event, this.value)">
							<input type="button" onclick="searchim()" value="조회">
						</div>
						
						<div>
							<label>적요 </label>
							<input type="text" name="investment_content" id="investment_content" value="${inmap.investment_content }" maxlength="500">
						</div>
						
						<div>
							<label>은행 </label>
							<input type="text" name="account_bank" id="account_bank" onclick="acList('${comcode_code}', '${inmap.team_code }')" value="${avo.account_bank }" readonly="readonly">
							<input type="button" onclick="acList('${comcode_code}', '${inmap.team_code }')" value="조회">
						</div>
						
						<div>
							<label>계좌번호 </label>
							<td><input type="text" name="account_num" id="account_num" value="${avo.account_num }" readonly="readonly">
						</div>
						
						<div>
							<label>차변 </label>
							<select name="debtor_no" id="debtor_no" onchange="check12()" class="required">
								<c:forEach var="vo1" items="${dlist }">
								<c:choose>
								<c:when test="${vo1.bs3_ctgr == inmap.bs3_ctgr1 }">
									<option value="${vo1.debtor_no }" id="${vo1.bs3_no }" selected>${vo1.bs3_ctgr }</option>
								</c:when>
								<c:otherwise>
									<option value="${vo1.debtor_no }" id="${vo1.bs3_no }">${vo1.bs3_ctgr }</option>
								</c:otherwise>
								</c:choose>
								</c:forEach>
							</select>
						</div>	
						
						<div>
							<label>대변</label> 
							<select name="creditor_no" id="creditor_no" onchange="check22()" class="required">
								<c:forEach var="vo2" items="${clist }">
								<c:choose>
								<c:when test="${vo2.bs3_ctgr == inmap.bs3_ctgr2 }">
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }" selected>${vo2.bs3_ctgr }</option>
								</c:when>
								<c:otherwise>
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }">${vo2.bs3_ctgr }</option>
								</c:otherwise>
								</c:choose>
								</c:forEach>
							</select>
						</div>
						
						<div>
							<label>담당팀 </label>
							<input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)" value="${inmap.team_name }">
							<input type="button" onclick="searcht()" value="조회">
						</div>		
						
						<div>
							<label>비고 </label>
							<input type="text" name="investment_note" id="investment_note" value="${inmap.investment_note }" maxlength="500">
						</div>	
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei('${bs3_no1}', '${bs3_no2 }', ${inmap.investment_no }, '${comcode_code }')">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/a/a4/a41/createLoan" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="imkind_no" id="imkind_no" value="13">
						<input type="hidden" name="ctgr_no" id="ctgr_no" value="8">
						<input type="hidden" name="client_no" id="client_no" value="17">
						<input type="hidden" name="team_no" id="team_no" value="1">
						<input type="hidden" name="bs3_no1" id="bs3_no1">
						<input type="hidden" name="bs3_no2" id="bs3_no2">
						<input type="hidden" name="account_no" id="account_no" value="1">
						<input type="hidden" name="investment_status" id="investment_status" value="1">
							<h3>차입 등록 사항</h3>
						<div>
							<label>코드 </label>
							<input type="text" name="investment_code" id="investment_code" onblur="imcode(this.value)" maxlength="30" class="required">
							<h6 id="imcodecheck" style="color:red;"></h6>
						</div>
						
						<div>
							<label>기간 </label>
							<input type="date" name="investment_start" id="investment_start"> ~ <input type="date" name="investment_end" id="investment_end">
						</div>
						
						<div>
							<label>금액 </label>
							<input type="text" name="investment_price" id="investment_price">
						</div>				
						
						<div>
							<label>거래처 </label>
							<input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')">
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
							<label>투자 종류</label>
							<input type="text" name="imkind_name" id="imkind_name" onkeypress="imkind(event, this.value)">
							<input type="button" onclick="searchim()" value="조회">
						</div>
						
						<div>
							<label>적요 </label>
							<input type="text" name="investment_content" id="investment_content" maxlength="500">
						</div>
						
						<div>
							<label>은행 </label>
							<input type="text" name="account_bank" id="account_bank" onclick="acList('${comcode_code}', '${map.team_code }')" readonly="readonly">
							<input type="button" onclick="acList('${comcode_code}', '${map.team_code }')" value="조회">
						</div>
						
						<div>
							<label>계좌번호 </label>
							<input type="text" name="account_num" id="account_num" readonly="readonly">
						</div>
						
						<div>
							<label>차변 </label>
							<select name="debtor_no" id="debtor_no" onchange="check1()" class="required">
								<c:forEach var="vo1" items="${dlist }">
									<option value="${vo1.debtor_no }" id="${vo1.bs3_no }" selected>${vo1.bs3_ctgr }</option>
								</c:forEach>
							</select>
						</div>	
						
						<div>
							<label>대변</label> 
							<select name="creditor_no" id="creditor_no" onchange="check2()" class="required">
								<c:forEach var="vo2" items="${clist }">
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }" selected>${vo2.bs3_ctgr }</option>
								</c:forEach>
							</select>
						</div>
						
						<div>
							<label>담당팀 </label>
							<input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
						</div>		
						
						<div>
							<label>비고 </label>
							<input type="text" name="investment_note" id="investment_note" maxlength="500">
						</div>	
						<div>
							<input type="button" id="register" value="save" onclick="sub(this.form)" disabled="disabled">
							<input type="reset" value="reset">
						</div>
					</form>
				</c:otherwise>
			</c:choose>
			
		</div>
	
</div>
<script type="text/javascript">

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no1, no2, ino, code){
	location.href='${pageContext.request.contextPath }/a/a4/a41/delete?investment_no='+ino+'&bs3_no1='+no1+'&bs3_no2='+no2+'&comcode_code='+code;
}


// 코드 UNIQUE 검사 AJAX
function imcode(v){
	var url = "${pageContext.request.contextPath }/a/a4/imcode";	// controller mapping 지정
	var param = "investment_code="+encodeURIComponent(v);			// parameter로 넘길 데이터 인코드해서 설정
	
	sendRequest(url,param,imcodecheck,"POST");		// httpRequest.js파일에 있는 sendRequest메소드 실행 > (경로, 데이터, 콜벡함수, 방식)
}
function imcodecheck(){		// imcode의 sendRequest에서 지정한 콜벡함수
	if(xhr.readyState==4 && xhr.status==200) {		// 신호가 정상인지 판단
		var data = xhr.responseText;				// controller에서 넘어온 데이터
		if(data != ""){		// 데이터가 정상적으로 넘어왔는 지 판단
			if(data == "사용 가능한 코드입니다."){		// 데이터값 판단
				document.getElementById("imcodecheck").innerText = data;	// imcodecheck라는 id의 text에 넘어온 data 저장
				document.getElementById("imcodecheck").style.color = "blue";
				document.getElementById("register").disabled = false;		// register 라는 id의 태그 활성화 > 버튼 활성화
			}else {
				document.getElementById("imcodecheck").innerText = data;
				document.getElementById("register").disabled = true;		// 버튼 비활성화
				document.getElementById("investment_code").focus();			// investment_code에 커서 지정
			}
		}
	}
}


//	bs3_no 세팅
	function check1(){
		let t = document.getElementById("debtor_no");	// debtor_no 불러옴
		let arr = document.querySelectorAll("#debtor_no > option");	// debtor_no의 옵션 태그들 nodelist로 불러옴
		let bs3_no1 = document.getElementById("bs3_no1");	// bs3_no1 불러옴
		arr.forEach(function(e, i, array) {
			if(t.value == e.value){		// 위에서 선언한 debtor_no를 불러온 값과 option태그들의 value값을 for문으로 전부 검사
				bs3_no1.value = e.id;	// value가 같으면 해당 옵션태그의 id를 bs3_no1에 저장
			}					// check 메소드 전부 동일
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
	
	function check12(){
		let t = document.getElementById("debtor_no");
		let arr = document.querySelectorAll("#debtor_no > option");
		let bs3_no1 = document.getElementById("bs3_no12");
		arr.forEach(function(e, i, array) {
			if(t.value == e.value){
				bs3_no1.value = e.id;
			}
		});
	}
	function check22(){
		let t = document.getElementById("creditor_no");
		let arr = document.querySelectorAll("#creditor_no > option");
		let bs3_no2 = document.getElementById("bs3_no22");
		arr.forEach(function(e, i, array) {
			if(t.value == e.value){
				bs3_no2.value = e.id;
			}
		});
	}

	
// submit 유효성 검사
function sub(f){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.investment_code.value == ""){
		f.investment_code.focus();
		return;
	}else if(f.debtor_no.value == 0){
		f.debtor_no.focus();
		return;
	}else if(f.creditor_no.value == 0){
		f.creditor_no.focus();
		return;
	}else if(f.creditor_no.value == f.debtor_no.value){
		alert("계정과목이 같습니다. 다시 선택해주세요.");
		f.debtor_no.focus();
		return;
	}else if(f.investment_price.value == ""){
		var ch = confirm("금액이 입력되지 않았습니다. 등록하시겠습니까?");	// 확인 true, 취소 false
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
	}else if(f.imkind_name.value == ""){
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


// 거래처 자동완성 AJAX
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
			var data2 = JSON.parse(data);	// ajax로 받아온 데이터를 json으로 변형
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


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, bno1, bno2){
	document.getElementsByName("investment_no")[0].value = no;
	document.getElementsByName("bs3_no1")[0].value = bno1;
	document.getElementsByName("bs3_no2")[0].value = bno2;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
</div>
</body>
</html>