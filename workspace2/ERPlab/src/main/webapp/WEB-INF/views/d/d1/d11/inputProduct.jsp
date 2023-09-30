<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d1/d11/productAjax";
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
		procode.innerHTML += '<tr><td>코드</td><td>생산명</td><td>의뢰명</td><td>담당자</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.product_no+",'"+map.product_code+"')");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.product_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.product_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.requestproduct_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.employee1_name;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
		}
	}
}

function requestproduct(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d11/requestproduct?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

function employee(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d11/employee?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

function requestpr(no,code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/updateForm?comcode_code="+code+"&requestproduct_no="+no, "_blank", "scrollbars=yes, top=150, left=300, width=1500, height=1000");
}
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>생산 관리</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="product_code" ${param.type == 'product_code' ? 'selected' : '' }>코드</option>
								<option value="product_lot" ${param.type == 'product_lot' ? 'selected' : '' }>로트번호</option>
								<option value="product_name" ${param.type == 'product_name' ? 'selected' : '' }>생산명</option>
								<option value="requestproduct_name" ${param.type == 'requestproduct_name' ? 'selected' : '' }>의뢰명</option>
								<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
							</select>
						</td>
						<td>
							<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
							<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
						</td>
					</tr>
				</table>
			</div>
			
			<div class="dh_overflow">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>생산코드</td>
						<td>생산명</td>
						<td>의뢰명</td>
						<td>담당자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.product_no}, '${map.product_code }')" class="filter">
						<td>${map.product_code }</td>
						<td>${map.product_name }</td>
						<td>${map.requestproduct_name}</td>
						<td>${map.employee1_name}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 17 }">
			<div class="dh_alignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d11/inputProduct?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d11/updateForm" id="content" method="post">
				<input type="hidden" name="product_no">
				<input type="hidden" name="product_code">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/d/d1/d11/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="employee1_no" id="employee1_no" value="${inmap.employee1_no }">
						<input type="hidden" name="product_no" id="product_no" value="${inmap.product_no }">
						<input type="hidden" name="requestproduct_no" id="requestproduct_no" value="${inmap.requestproduct_no }">
						<input type="hidden" name="bs3_no11" id="bs3_no11" value="${cmap.bs3_no1 }">
						<input type="hidden" name="bs3_no21" id="bs3_no21" value="${cmap.bs3_no2 }">
						<input type="hidden" name="bs3_no12" id="bs3_no12">
						<input type="hidden" name="bs3_no22" id="bs3_no22">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						<div>
							<label>생산 코드 </label>
							<input type="text" name="product_code" id="product_code" maxlength="30" class="required" readonly="readonly" value="${inmap.product_code }">
							<h6 id="productcode" style="color:red;"></h6>
						</div>
						
						<div>
							<label>생산 로트번호 </label>
							<input type="text" name="product_lot" id="product_lot" maxlength="30" class="required" value="${inmap.product_lot }" onblur="lot(this.value)">
							<h6 id="lot" style="color:red;"></h6>
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" maxlength="40" class="required" value="${inmap.product_name }">
						</div>
						
						<div>
							<label>의뢰 코드 </label>
							<input type="text" name="requestproduct_code" id="requestproduct_code" value="${inmap.requestproduct_code }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>기간 </label>
							<input type="date" name="product_install" id="product_install" value="${inmap.product_install }" onchange="startcheck(this.value)"> - <input type="date" name="product_end" id="product_end" value="${inmap.product_end }">
						</div>
						
						<div>
							<label>공정 경로 </label>
							<input type="text" name="product_path" id="product_path" value="${inmap.product_path }" maxlength="50">
						</div>
						
						<div>
							<label>담당자 / 직급</label>
							<input type="text" name="employee1_name" id="employee1_name" readonly="readonly" onclick="employee('${comcode_code}')" value="${inmap.employee1_name }">
							<input type="text" name="employee2_position" id="employee2_position" readonly="readonly" value="${inmap.employee2_position }">
						</div>	
						
						<div>
							<label>생산 금액 </label>
							<input type="text" name="product_budget" id="product_budget" value="${inmap.product_budget }" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>세액 </label>
							<input type="text" name="product_tax" id="product_tax" readonly="readonly" value="${inmap.product_tax }">
						</div>
						
						<div>
							<label>생산 총액 </label>
							<input type="text" name="product_totalbudget" id="product_totalbudget" readonly="readonly" value="${inmap.product_totalbudget }">
						</div>
						
						<div>
							<label>생산 수량 </label>
							<input type="text" name="product_qty" id="product_qty" class="required" value="${inmap.product_qty }" readonly="readonly">
							<input type="button" onclick="goodsList()" value="목록보기">
						</div>
						
						<table id="goodsList">
						</table>
						
						<div>
							<label>비고 </label>
							<input type="text" name="product_content" id="product_content" class="required" value="${inmap.product_content }" maxlength="100">
						</div>
						
						<div>
							<label>차변 </label>
							<select name="debtor_no" id="debtor_no" onchange="check12()" class="required">
								<c:forEach var="vo1" items="${dlist }">
								<c:choose>
								<c:when test="${vo1.bs3_no == cmap.bs3_no1 }">
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
								<c:when test="${vo2.bs3_no == cmap.bs3_no2 }">
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
						<c:if test="${login == 1 || login == 2 || login == 17 }">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei('${cmap.bs3_no1}', '${cmap.bs3_no2 }', ${inmap.product_no }, '${comcode_code }', '${inmap.product_code }')">
						</c:if>
							<input type="button" value="의뢰서 정보" onclick="requestpr(${inmap.requestproduct_no }, '${comcode_code }')">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/d/d1/d11/createProduct" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="employee1_no" id="employee1_no">
						<input type="hidden" name="requestproduct_no" id="requestproduct_no">
						<input type="hidden" name="bs3_no1" id="bs3_no1">
						<input type="hidden" name="bs3_no2" id="bs3_no2">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>생산 코드 </label>
							<input type="text" name="product_code" id="product_code" maxlength="30" class="required" onblur="code(this.value)">
							<h6 id="productcode" style="color:red;"></h6>
						</div>
						
						<div>
							<label>생산 로트번호 </label>
							<input type="text" name="product_lot" id="product_lot" maxlength="30" class="required" onblur="lot(this.value)">
							<h6 id="lot" style="color:red;"></h6>
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" maxlength="40" class="required">
						</div>
						
						<div>
							<label>의뢰 코드 </label>
							<input type="text" name="requestproduct_code" id="requestproduct_code" readonly="readonly" class="required" onclick="requestproduct('${comcode_code}')">
							<h6 id="checkRro" style="color:red;"></h6>
						</div>
						
						<div>
							<label>기간 </label>
							<input type="date" name="product_install" id="product_install" onchange="startcheck(this.value)"> - <input type="date" name="product_end" id="product_end">
						</div>
						
						<div>
							<label>공정 경로 </label>
							<input type="text" name="product_path" id="product_path" maxlength="50">
						</div>
						
						<div>
							<label>담당자 / 직급</label>
							<input type="text" name="employee1_name" id="employee1_name" readonly="readonly" onclick="employee('${comcode_code}')">
							<input type="text" name="employee2_position" id="employee2_position" readonly="readonly">
						</div>	
						
						<div>
							<label>생산 금액 </label>
							<input type="text" name="product_budget" id="product_budget" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>세액 </label>
							<input type="text" name="product_tax" id="product_tax" readonly="readonly">
						</div>
						
						<div>
							<label>생산 총액 </label>
							<input type="text" name="product_totalbudget" id="product_totalbudget" readonly="readonly">
						</div>
						
						<div>
							<label>생산 수량 </label>
							<input type="text" name="product_qty" id="product_qty" class="required" readonly="readonly">
							<input type="button" onclick="goodsList()" value="목록보기">
						</div>
						
						<table id="goodsList">
						</table>
						
						<div>
							<label>비고 </label>
							<input type="text" name="product_content" id="product_content" class="required" maxlength="100">
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
						
						<c:if test="${login == 1 || login == 2 || login == 17 }">
						<div>
							<input type="button" id="register" value="save" onclick="sub(this.form)" disabled="disabled">
							<input type="reset" value="reset">
						</div>
						</c:if>
					</form>
				</c:otherwise>
			</c:choose>
			
		</div>
	
</div>
<script type="text/javascript">

var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
var end = new Date(now_utc-timeOff).toISOString().split("-")[0];
document.getElementById("product_install").setAttribute("min", end+"-01-01");
document.getElementById("product_install").setAttribute("max", end+"-12-31");

if(document.getElementById("product_install").value != ""){
	document.getElementById("product_end").setAttribute("min", document.getElementById("product_install").value);
	document.getElementById("product_end").setAttribute("max", end+"-12-31");
}

function startcheck(v){
	document.getElementById("product_end").value = v;
	document.getElementById("product_end").setAttribute("min", v);
	document.getElementById("product_end").setAttribute("max", end+"-12-31");
}

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no1, no2, ino, code, rcode){
	location.href='${pageContext.request.contextPath }/d/d1/d11/delete?product_no='+ino+'&bs3_no1='+no1+'&bs3_no2='+no2+'&comcode_code='+code+"&product_code="+rcode;
}

function conculator(e, v){
	if(e.keyCode == 13){
		document.getElementById("product_tax").value = Math.round(Number(v) * 0.1);
		let tax = document.getElementById("product_tax").value; 
		document.getElementById("product_totalbudget").value = Math.round(Number(v) + Number(tax));
	}
}

function conculator1(v){
	document.getElementById("product_tax").value = Math.round(Number(v) * 0.1);
	let tax = document.getElementById("product_tax").value; 
	document.getElementById("product_totalbudget").value = Math.round(Number(v) + Number(tax));
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
	if(!pat.test(f.product_budget.value)){
		alert("100,000,000원 미만, 숫자만 입력 가능합니다.");
		f.product_budget.value = "";
		f.product_tax.value = "";
		f.product_totalbudget.value = "";
		f.product_budget.focus();
		return;
	}
	if(f.product_budget.value == ""){
		f.product_budget.focus();
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
	}else if(f.product_end.value == ""){
		f.product_end.focus();
		return;
	}else if(f.product_name.value == ""){
		f.product_name.focus();
		return;
	}else if(f.requestproduct_no.value == ""){
		f.requestproduct_code.focus();
		return;
	}else if(f.product_content.value == ""){
		f.product_content.focus();
		return;
	}else if(f.employee1_no.value == ""){
		f.employee1_name.focus();
		return;
	}
	
	var ch = confirm("등록하시겠습니까?");
	if(ch){
		f.submit();
	}else {
		return;
	}
}

//코드 UNIQUE 검사 AJAX
function code(v){
	var url = "${pageContext.request.contextPath }/d/d1/d11/getProductCode";
	var param = "product_code="+encodeURIComponent(v);
	
	sendRequest(url,param,codecheck,"POST");
}
function codecheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				if(document.getElementById("checkRro").innerText == "이미 해당 의뢰에 대한 생산이 등록되어있습니다."){
					document.getElementById("register").disabled = true;
				}else {
					document.getElementById("register").disabled = false;
				}
				document.getElementById("productcode").innerText = data;
				document.getElementById("productcode").style.color = "blue";
			}else {
				document.getElementById("productcode").innerText = data;
				document.getElementById("productcode").style.color = "red";
				document.getElementById("register").disabled = true;
			}
		}
	}
}

function lot(v){
	var url = "${pageContext.request.contextPath }/d/d1/d11/getLotNo";
	var param = "goodslot_lot="+encodeURIComponent(v);
	
	sendRequest(url,param,lotcheck,"POST");
}
function lotcheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 로트입니다."){
				document.getElementById("lot").innerText = data;
				document.getElementById("lot").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("lot").innerText = data;
				document.getElementById("lot").style.color = "red";
				document.getElementById("register").disabled = true;
			}
		}
	}
}


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, code){
	document.getElementsByName("product_no")[0].value = no;
	document.getElementsByName("product_code")[0].value = code;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

function goodsList(){
	var no = document.getElementById("requestproduct_no").value;
	if(no == ""){
		alert("의뢰를 선택하여 주십시오.");
		document.getElementById("requestproduct_code").focus();
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d1/d11/goodsAjax";
	var param = "requestproduct_no="+encodeURIComponent(no);
	
	sendRequest(url,param,goodsCheck,"POST");
}
function goodsCheck(){
	var sum = 0;
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		let g = document.getElementById("goodsList");
		g.innerHTML = '';
		let newTr = document.createElement("tr");
		let newTd = document.createElement("td");
		g.appendChild(newTr);
		newTd = document.createElement("td");
		newTd.innerHTML = '상품 코드';
		newTr.appendChild(newTd);
		newTd = document.createElement("td");
		newTd.innerHTML = '바코드';
		newTr.appendChild(newTd);
		newTd = document.createElement("td");
		newTd.innerHTML = '품명';
		newTr.appendChild(newTd);
		newTd = document.createElement("td");
		newTd.innerHTML = '의뢰 수량';
		newTr.appendChild(newTd);
		if(data != ""){	
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				g.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goods_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goods_barcode;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goods_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.connectrequest_qty;
				newTr.appendChild(newTd);
				sum += Number(map.connectrequest_qty);
			});
		}else {
			g.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
		}
		document.getElementById("product_qty").value = sum;
	}
}


</script>
</div>
</body>
</html>