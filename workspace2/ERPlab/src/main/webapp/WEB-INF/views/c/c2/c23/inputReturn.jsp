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
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c22/billsAjax";
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
		procode.innerHTML += '<tr><td>코드</td><td>금액</td><td>여부</td><td>만기일</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.client_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_cino;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_total;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_collected == 0 ? '미수금' : '수금' ;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.receivable_expiry;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
		}
	}
}

//전체목록조회 > 새창으로

function goodsList(code){
	let openWin = window.open("${pageContext.request.contextPath}/c/c2/c23/goodsreturn?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=700, height=700");
}
function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}


</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">반품</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
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
						<td>로트</td>
						<td>바코드</td>
						<td>상품</td>
						<td>반품일자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.return_no})" class="filter">
						<td class="code">${map.return_code }</td>
						<td class="price">${map.goodslot_lot }</td>
						<td class="price">${map.goods_barcode }</td>
						<td class="price">${map.goods_name }</td>
						<td class="cont">${map.return_date }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c23/inputReturn?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/c/c2/c23/updateForm" id="content" method="post">
				<input type="hidden" name="return_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/c/c2/c23/updateReturn" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="return_no" value="${inmap.return_no }">
						<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
						<input type="hidden" name="goodslot_no" id="goodslot_no" value="${inmap.goodslot_no }">
						<input type="hidden" name="bs3_no11" id="bs3_no11" value="${bs3_no1 }">
						<input type="hidden" name="bs3_no21" id="bs3_no21" value="${bs3_no2 }">
						<input type="hidden" name="bs3_no12" id="bs3_no12">
						<input type="hidden" name="bs3_no22" id="bs3_no22">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>코드 </label>
							<input type="text" name="return_code" id="return_code" value="${inmap.return_code }" readonly="readonly" maxlength="30" class="required">
						</div>
						
						<div>
							<label>품명 </label>
							<input type="text" name="goods_name" id="goods_name" value="${inmap.goods_name }" readonly="readonly" onclick="goodsList('${comcode_code}')" class="required">
							<input type="button" onclick="goodsList('${comcode_code}')" value="조회">
						</div>	
						
						<div>
							<label>로트번호 </label>
							<input type="text" name="goodslot_lot" id="goodslot_lot" value="${inmap.goodslot_lot }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>바코드 </label>
							<input type="text" name="goods_barcode" id="goods_barcode" value="${inmap.goods_barcode }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>원가 </label>
							<input type="text" name="goodslot_total" id="goodslot_total" value="${inmap.goodslot_total }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>사유 </label>
							<input type="text" name="return_comment" id="return_comment" value="${inmap.return_comment }">
						</div>
						
						<div>
							<label>날짜 </label>
							<input type="date" name="return_date" id="return_date" value="${inmap.return_date }" max="2023-01-01">
						</div>
						
						<div>
							<label>수량 </label>
							<input type="text" name="return_qty" id="return_qty" value="${inmap.return_qty }" class="required">
						</div>				
						
						<div>
							<label>제조사 </label>
							<input type="text" name="client_name" id="client_name" value="${inmap.client_name }" class="required">
						</div>	
						
						<div>
							<label>금액</label>
							<input type="text" name="return_price" id="return_price" value="${inmap.return_price }" onkeypress="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>세액</label>
							<input type="text" name="return_tax" id="return_tax" value="${inmap.return_tax }" class="required">
						</div>
						
						<div>
							<label>반품 총액</label>
							<input type="text" name="return_total" id="return_total" value="${inmap.return_total }" class="required">
						</div>
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei('${inmap.return_code }', ${inmap.return_no }, '${comcode_code }')">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c23/createReturn" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="client_no" id="client_no" value="17">
						<input type="hidden" name="goodslot_no" id="goodslot_no" value="1">
						<input type="hidden" name="bs3_no1" id="bs3_no1">
						<input type="hidden" name="bs3_no2" id="bs3_no2">
							<h3>반품 등록 사항</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>코드 </label>
							<input type="text" name="return_code" id="return_code" maxlength="30" class="required" onblur="returncode(this.value)">
							<h6 id="returncodecheck" style="color:red;"></h6>
						</div>
						
						<div>
							<label>품명 </label>
							<input type="text" name="goods_name" id="goods_name" readonly="readonly" onclick="goodsList('${comcode_code}')" class="required">
							<input type="button" onclick="goodsList('${comcode_code}')" value="조회">
						</div>	
						
						<div>
							<label>로트번호 </label>
							<input type="text" name="goodslot_lot" id="goodslot_lot" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>바코드 </label>
							<input type="text" name="goods_barcode" id="goods_barcode" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>원가 </label>
							<input type="text" name="goodslot_total" id="goodslot_total" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>제조사 </label>
							<input type="text" name="client_name" id="client_name" class="required">
						</div>	
						
						<div>
							<label>사유 </label>
							<input type="text" name="return_comment" id="return_comment">
						</div>
						
						<div>
							<label>날짜 </label>
							<input type="date" name="return_date" id="return_date">
						</div>
						
						<div>
							<label>수량 </label>
							<input type="text" name="return_qty" id="return_qty" class="required">
						</div>				
						
						<div>
							<label>금액</label>
							<input type="text" name="return_price" id="return_price" onkeypress="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>세액</label>
							<input type="text" name="return_tax" id="return_tax" class="required">
						</div>
						
						<div>
							<label>반품 총액</label>
							<input type="text" name="return_total" id="return_total" class="required">
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
function deletei(recode, ino, code){
	location.href='${pageContext.request.contextPath }/c/c2/c23/delete?return_code='+recode+'&return_no='+ino+'&comcode_code='+code;
}


// 코드 UNIQUE 검사 AJAX
function returncode(v){
	var url = "${pageContext.request.contextPath }/c/c2/c23/returncode";
	var param = "return_code="+encodeURIComponent(v);
	
	sendRequest(url,param,returncodecheck,"POST");
}
function returncodecheck(){	
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){	
				document.getElementById("returncodecheck").innerText = data;
				document.getElementById("returncodecheck").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("returncodecheck").innerText = data;
				document.getElementById("register").disabled = true;
				document.getElementById("return_code").focus();	
			}
		}
	}
}


//	bs3_no 세팅
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
	var pat = /^[0-9]{0,8}$/;
	if(f.return_code.value == ""){
		f.return_code.focus();
		return;
	}else if(f.goods_name.value == ""){
		f.goods_name.focus();
		return;
	}else if(f.return_qty.value == ""){
		f.return_qty.focus();
		return;
	}else if(f.return_price.value == ""){
		f.return_price.focus();
	}else if(!pat.test(f.return_price.value)){
		alert("100,000,000미만, 숫자만 입력 가능합니다.");
		f.return_price.value = '';
		f.return_price.focus();
		return;
	}else if(f.return_date.value == ""){
		document.getElementById("return_date").valueAsDate = new Date();
		console.log(f.return_date.value);
		var ch = confirm("날짜가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.return_date.focus();
			return;
		}
	}else if(f.return_comment.value == ""){
		var ch = confirm("사유가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.return_comment.focus();
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

function conculator(e, v){
	if(e.keyCode == 13){
		var pat = /^[0-9]{0,8}$/;
		if(!pat.test(v)){
			alert("100,000,000미만, 숫자만 입력 가능합니다.");
			document.getElementById("return_price").value  = '';
			document.getElementById("return_price").focus();
			return;
		}
		document.getElementById("return_tax").value = Math.floor(Number(v) * 0.1);
		let tax = document.getElementById("return_tax").value; 
		document.getElementById("return_total").value = Math.floor(Number(v) + Number(tax));
	}
}
function conculator1(v){
	var pat = /^[0-9]{0,8}$/;
	if(!pat.test(v)){
		alert("100,000,000미만, 숫자만 입력 가능합니다.");
		document.getElementById("return_price").value  = '';
		document.getElementById("return_price").focus();
		return;
	}
	document.getElementById("return_tax").value = Math.floor(Number(v) * 0.1);
	let tax = document.getElementById("return_tax").value; 
	document.getElementById("return_total").value = Math.floor(Number(v) + Number(tax));
}


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("return_no")[0].value = no;
	
	document.getElementById("content").submit();
}


</script>
</div>
</body>
</html>