<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>

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
	var url = "${pageContext.request.contextPath}/d/d1/d12/requestProductAjax";
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
		procode.innerHTML += '<tr><td>코드</td><td>이름</td><td>거래처</td><td>담당자</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.requestproduct_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.requestproduct_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.requestproduct_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
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

function deleteGoods(cno, rno){
	var url = "${pageContext.request.contextPath}/d/d1/d12/deleteGoods";
	var param = "connectrequest_no="+cno+"&requestproduct_no="+rno;
	
	sendRequest(url,param,goodslist,"POST");
}
function goodslist(){
	if(xhr.readyState==4 && xhr.status==200){
		var data = xhr.response;
		let g = document.getElementById("gajax");
		if(data != ""){
			
		}
	}
}

</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">생산 의뢰</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="requestproduct_code" ${param.type == 'requestproduct_code' ? 'selected' : '' }>코드</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
								<option value="requestproduct_name" ${param.type == 'requestproduct_name' ? 'selected' : '' }>의뢰명</option>
								<option value="requestproduct_end" ${param.type == 'requestproduct_end' ? 'selected' : '' }>만기일</option>
								<option value="requestproduct_content" ${param.type == 'requestproduct_content' ? 'selected' : '' }>내용</option>
								<option value="closing_date" ${param.type == 'closing_date' ? 'selected' : '' }>작성일</option>
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
						<td>의뢰명</td>
						<td>거래처</td>
						<td>담당자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.requestproduct_no})" class="filter">
						<td class="code">${map.requestproduct_code }</td>
						<td class="price">${map.requestproduct_name }</td>
						<td class="cont">${map.client_name}</td>
						<td>${map.employee1_name}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d12/inputRequestProduct?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d12/updateForm" id="content" method="post">
				<input type="hidden" name="requestproduct_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/d/d1/d12/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="requestproduct_no" value="${inmap.requestproduct_no }">
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
							<input type="text" name="requestproduct_code" id="requestproduct_code" value="${inmap.requestproduct_code }" readonly="readonly" maxlength="30" class="required">
						</div>
							
						<div>
							<label>의뢰명 </label>
							<input type="text" name="requestproduct_name" id="requestproduct_name" value="${inmap.requestproduct_name }" class="required">
						</div>
						
						<div>
							<label>기간 </label>
							<input type="date" name="requestproduct_start" id="requestproduct_start" value="${inmap.requestproduct_start }"> - <input type="date" name="requestproduct_end" id="requestproduct_end" value="${inmap.requestproduct_end }">
						</div>
						
						<div id="gajax">
						<c:forEach var="i" items="${glist }" varStatus="status">
							<div style="float:left;" ondblclick="detail(${status.index})">
								품명 <input type="text" name="goods_name" id="goods_name" value="${i.goods_name }">
							</div>
								<table class="hidden" id="${status.index }">
									<tr>
										<td>의뢰 수량</td>
										<td><input type="text" name="connectrequest_qty" id="connectrequest_qty" value="${i.connectrequest_qty }"></td>
									</tr>
									<tr>
										<td>상품 코드</td>
										<td><input type="text" name="goods_code" id="goods_code" value="${i.goods_code }"></td>
									</tr>
									<tr>
										<td>바코드</td>
										<td><input type="text" name="goods_barcode" id="goods_barcode" value="${i.goods_barcode }"></td>
									</tr>
									<tr>
										<td>분류</td>
										<td><<input type="text" name="goodssort_name" id="goodssort_name" value="${i.goodssort_name }">/td>
									</tr>
									<tr>
										<td>종류</td>
										<td><<input type="text" name="goodskind_name" id="goodskind_name" value="${i.goodskind_name }">/td>
									</tr>
									<tr>
										<td>소비자가</td>
										<td><<input type="text" name="goods_customerprice" id="goods_customerprice" value="${i.goods_customerprice }">/td>
									</tr>
									<tr>
										<td>단위</td>
										<td><<input type="text" name="goodsst_unit" id="goodsst_unit" value="${i.goodsst_unit }">/td>
									</tr>
									<tr>
										<td>사양</td>
										<td><<input type="text" name="goodsst_spec" id="goodsst_spec" value="${i.goodsst_spec }">/td>
									</tr>
									<tr>
										<td>규격</td>
										<td><<input type="text" name="goodsst_size" id="goodsst_size" value="${i.goodsst_size }">/td>
									</tr>
									<tr>
										<td>포장</td>
										<td><<input type="text" name="goodsst_package" id="goodsst_package" value="${i.goodsst_package }">/td>
									</tr>
									<tr>
										<td>사입량</td>
										<td><<input type="text" name="goodsst_ea" id="goodsst_ea" value="${i.goodsst_ea }">/td>
									</tr>
									<tr>
										<td>설명</td>
										<td><<input type="text" name="goods_description" id="goods_description" value="${i.goods_description }">/td>
									</tr>
								</table>
								<input type="button" value="delete" onclick="deleteGoods(${i.connectrequest_no},${i.requestproduct_no })">
						</c:forEach>
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