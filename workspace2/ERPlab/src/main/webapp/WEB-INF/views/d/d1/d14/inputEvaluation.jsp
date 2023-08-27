<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />
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
function surf(v, code, no){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c22/billsAjax";
	var param = "comcode_code="+code+"&word="+v+"&type="+type+"&receivable_no="+no;
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("procode");
		let newTr = document.createElement("tr");
		let newTd = document.createElement("td");
		procode.innerHTML = '';
		procode.innerHTML += '<tr><td>채권코드</td><td>수금액</td><td>수금일자</td><td>채권 총액</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.receivable_no+","+map.bondbills_no+","+map.bs3_no1+","+map.bs3_no2+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_cino;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.bondbills_total;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.bondbills_date;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_total;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
		}
	}
}
function surf1(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c22/billsAjax2";
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
		procode.innerHTML += '<tr><td>채권코드</td><td>수금액</td><td>수금일자</td><td>채권 총액</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.receivable_no+","+map.bondbills_no+","+map.bs3_no1+","+map.bs3_no2+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_cino;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.bondbills_total;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.bondbills_date;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_total;
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
		<div align="center">
			<h1 style="font-size: 20pt;">수금</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="receivable_cino" ${param.type == 'receivable_cino' ? 'selected' : '' }>CINO</option>
								<option value="receivable_expiry" ${param.type == 'imkind_name' ? 'selected' : '' }>만기날짜</option>
								<option value="receivable_collected" ${param.type == 'receivable_collected' ? 'selected' : '' }>수금여부</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
								<option value="receivable_total" ${param.type == 'receivable_total' ? 'selected' : '' }>금액</option>
							</select>
						</td>
						<c:if test="${rmap.receivable_no != null }">
							<td>
								<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}', ${rmap.receivable_no })">
								<input type="button" value="전체목록" onclick="surf('', '${comcode_code}', ${rmap.receivable_no })">
							</td>
						</c:if>
						<c:if test="${rmap.receivable_no == null }">
							<td>
								<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf1(this.value, '${comcode_code}')">
								<input type="button" value="전체목록" onclick="surf1('', '${comcode_code}')">
							</td>
						</c:if>
					</tr>
				</table>
			</div>
			
			<div style="overflow: scroll;">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>채권코드</td>
						<td>수금액</td>
						<td>수금일자</td>
						<td>채권 총액</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.receivable_no}, ${map.bondbills_no }, ${map.bs3_no1}, ${map.bs3_no2 })" class="filter">
						<td class="code">${map.receivable_cino }</td>
						<td class="price">${map.bondbills_total }</td>
						<td class="cont">${map.bondbills_date}</td>
						<td>${map.receivable_total}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c22/inputBondbills?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/c/c2/c22/updateFormB" id="content" method="post">
				<input type="hidden" name="receivable_no">
				<input type="hidden" name="bondbills_no">
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
					<form action="${pageContext.request.contextPath }/c/c2/c22/updateBondbills" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="bondbills_no" value="${inmap.bondbills_no }">
						<input type="hidden" name="receivable_no" value="${inmap.receivable_no }">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						
						<div>
							<label>서류상 종료 날짜 </label>
							<input type="date" name="evaluation_paperend" id="evaluation_paperend" value="${inmap.evaluation_paperend }" class="required">
						</div>
							
						<div>
							<label>실제 종료 날짜 </label>
							<input type="date" name="evaluation_actualend" id="evaluation_actualend" value="${inmap.evaluation_actualend }" class="required">
						</div>
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="evaluation_content" id="evaluation_content" value="${inmap.evaluation_content }">
						</div>
						
						<div>
							<label>상태 </label>
							<select name="evaluation_status" id="evaluation_status">
								<option value="0" ${inmap.evaluation_status == 0 ? 'selected' : ''}>미완료</option>
								<option value="1" ${inmap.evaluation_status == 1 ? 'selected' : ''}>정상 완료</option>
							</select>
						</div>
						
						<div>
							<label>거래처 </label>
							<input type="text" name="client_name" id="client_name" value="${inmap.client_name }">
						</div>	
						
						<div>
							<label>수금액 </label>
							<input type="text" name="bondbills_price" id="bondbills_price" value="${inmap.bondbills_price }" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)">
						</div>
						
						<div>
							<label>세액 </label>
							<input type="text" name="bondbills_tax" id="bondbills_tax" value="${inmap.bondbills_tax }" readonly="readonly">
						</div>
						
						<div>
							<label>수금 총액 </label>
							<td><input type="text" name="bondbills_total" id="bondbills_total" value="${inmap.bondbills_total }" readonly="readonly">
						</div>
						
						<div>
							<label>차변 </label>
							<select name="debtor_no" id="debtor_no" onchange="check12()" class="required">
								<c:forEach var="vo1" items="${dlist }">
								<c:choose>
								<c:when test="${vo1.bs3_no == inmap.bs3_no1 }">
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
								<c:when test="${vo2.bs3_no == inmap.bs3_no2 }">
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }" selected>${vo2.bs3_ctgr }</option>
								</c:when>
								<c:otherwise>
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }">${vo2.bs3_ctgr }</option>
								</c:otherwise>
								</c:choose>
								</c:forEach>
							</select>
						</div>
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei('${bs3_no1}', '${bs3_no2 }', ${inmap.bondbills_no }, '${comcode_code }', '${inmap.receivable_cino }')">
							<input type="button" value="receive" onclick="location.href='${pageContext.request.contextPath}/c/c2/c22?comcode_code=${comcode_code }'">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c22/createBondbills" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="receivable_no" value="${rmap.receivable_no }">
						<input type="hidden" name="bs3_no1" id="bs3_no1">
						<input type="hidden" name="bs3_no2" id="bs3_no2">
						<h3>수금 등록 사항</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>수금 코드 </label>
							<input type="text" name="bondbills_code" id="bondbills_code" maxlength="30" class="required" onblur="code(this.value)">
							<h6 id="billscode" style="color:red;"></h6>
						</div>
						
						<div>
							<label>CI NUMBER </label>
							<input type="text" name="receivable_cino" id="receivable_cino" value="${rmap.receivable_cino }" readonly="readonly" maxlength="30" class="required">
						</div>
						
						<div>
							<label>만기도래일 </label>
							<input type="date" name="receivable_expiry" id="receivable_expiry" value="${rmap.receivable_expiry }" readonly="readonly">
						</div>
						
						<div>
							<label>채권 총액 </label>
							<input type="text" name="receivable_total" id="receivable_total" value="${rmap.receivable_total }" readonly="readonly">
						</div>
						
						<div>
							<label>거래처 </label>
							<input type="text" name="client_name" id="client_name" value="${rmap.client_name }" readonly="readonly">
						</div>	
						
						<div>
							<label>수금액 </label>
							<input type="text" name="bondbills_price" id="bondbills_price" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>세액 </label>
							<input type="text" name="bondbills_tax" id="bondbills_tax" readonly="readonly">
						</div>
						
						<div>
							<label>수금 총액 </label>
							<input type="text" name="bondbills_total" id="bondbills_total" readonly="readonly">
						</div>
						
						<div>
							<label>수금일자 </label>
							<input type="text" name="bondbills_date" id="bondbills_date" class="required">
						</div>
						
						<div>
							<label>차변 </label>
							<select name="debtor_no" id="debtor_no" onchange="check1()" class="required">
								<option value="0" selected>선택</option>
								<c:forEach var="vo1" items="${dlist }">
									<option value="${vo1.debtor_no }" id="${vo1.bs3_no }">${vo1.bs3_ctgr }</option>
								</c:forEach>
							</select>
						</div>	
						
						<div>
							<label>대변</label> 
							<select name="creditor_no" id="creditor_no" onchange="check2()" class="required">
								<option value="0" selected>선택</option>
								<c:forEach var="vo2" items="${clist }">
									<option value="${vo2.creditor_no }" id="${vo2.bs3_no }">${vo2.bs3_ctgr }</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<input type="button" id="register" value="save" onclick="sub(this.form, ${rmap.receivable_price})" disabled="disabled">
							<input type="reset" value="reset">
							<input type="button" value="receive" onclick="location.href='${pageContext.request.contextPath}/c/c2/c22?comcode_code=${comcode_code }'">
						</div>
					</form>
				</c:otherwise>
			</c:choose>
			
		</div>
	
</div>
<script type="text/javascript">

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no1, no2, ino, code, rcode){
	location.href='${pageContext.request.contextPath }/c/c2/c22/deleteBondbills?bondbills_no='+ino+'&bs3_no1='+no1+'&bs3_no2='+no2+'&comcode_code='+code+"&receivable_cino="+rcode;
}

function conculator(e, v){
	if(e.keyCode == 13){
		document.getElementById("bondbills_tax").value = Number(v) * 0.1;
		let tax = document.getElementById("bondbills_tax").value; 
		document.getElementById("bondbills_total").value = Number(v) + Number(tax);
	}
}

function conculator1(v){
	document.getElementById("bondbills_tax").value = Number(v) * 0.1;
	let tax = document.getElementById("bondbills_tax").value; 
	document.getElementById("bondbills_total").value = Number(v) + Number(tax);
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
function sub(f, total){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.bondbills_price.value == ""){
		f.bondbills_price.focus();
		return;
	}else if(f.bondbills_tax.value == ""){
		f.bondbills_tax.focus();
		return;
	}else if(f.bondbills_total.value == ""){
		f.bondbills_total.focus();
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
	}else if(f.bondbills_date.value == ""){
		f.bondbills_date.focus();
		return;
	}else if(!pat.test(f.bondbills_price.value)){
		alert("채권 금액인 "+total+"원 미만, 숫자만 입력 가능합니다.");
		f.bondbills_price.focus();
		return;
	}else {
		var ch = confirm("등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			return;
		}
	}
}

//코드 UNIQUE 검사 AJAX
function code(v){
	var url = "${pageContext.request.contextPath }/c/c2/c22/getBondbillsCode";
	var param = "bondbills_code="+encodeURIComponent(v);
	
	sendRequest(url,param,codecheck,"POST");
}
function codecheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				document.getElementById("billscode").innerText = data;
				document.getElementById("billscode").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("billscode").innerText = data;
				document.getElementById("register").disabled = true;
				document.getElementById("bondbills_code").focus();	
			}
		}
	}
}


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, bno, bno1, bno2){
	document.getElementsByName("receivable_no")[0].value = no;
	document.getElementsByName("bondbills_no")[0].value = bno;
	document.getElementsByName("bs3_no1")[0].value = bno1;
	document.getElementsByName("bs3_no2")[0].value = bno2;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
</div>
</body>
</html>