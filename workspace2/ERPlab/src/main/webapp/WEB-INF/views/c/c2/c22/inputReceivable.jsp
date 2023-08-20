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
	var url = "${pageContext.request.contextPath}/c/c2/c22/receivableAjax";
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
function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

function bills(no, code){
	location.href="${pageContext.request.contextPath}/c/c2/c22/inputBondbills?comcode_code="+code+"&receivable_no="+no;
}
//자동완성 > AJAX
</script>

<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">채권 관리</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="receivable_cino" ${param.type == 'receivable_cino' ? 'selected' : '' }>코드</option>
								<option value="receivable_collected" ${param.type == 'receivable_collected' ? 'selected' : '' }>종류</option>
								<option value="receivable_expiry" ${param.type == 'receivable_expiry' ? 'selected' : '' }>적요</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
							</select>
						</td>
						<td>
							<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')" onblur="surf('', '${comcode_code}')">
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
						<td>여부</td>
						<td>만기일</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.receivable_no})" class="filter">
						<td class="code">${map.receivable_cino }</td>
						<td class="price">${map.receivable_total }</td>
						<td class="cont">${map.receivable_collected == 0 ? '미수금' : '수금' }</td>
						<td class="cont">${map.receivable_expiry}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td colspan="4">목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c22?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/c/c2/c22/updateForm" id="content" method="post">
				<input type="hidden" name="receivable_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/c/c2/c22/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="receivable_no" id="receivable_no" value="${inmap.receivable_no }">
						<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
							<h3>채권</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>코드 </label>
							<input type="text" name="receivable_code" id="receivable_code" value="${inmap.receivable_code }" readonly="readonly" maxlength="30" class="required">
						</div>
						
						<div>
							<label>CI NUMBER </label>
							<input type="text" name="receivable_cino" id="receivable_cino" value="${inmap.receivable_cino }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>금액 </label>
							<input type="text" name="receivable_price" id="receivable_price" value="${inmap.receivable_price }">
						</div>				
						
						<div>
							<label>거래처 </label>
							<input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')" value="${inmap.client_name }">
							<input type="button" onclick="clList('${comcode_code}')" value="조회">
						</div>	
							
						<div>
							<label>사업자등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" readonly="readonly" value="${inmap.client_registeredno }">
						</div>	
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" readonly="readonly" value="${inmap.client_manager }">
						</div>
						
						<div>
							<label>만기일</label>
							<input type="date" name="receivable_expiry" id="receivable_expiry" value="${inmap.receivable_expiry }" class="required">
						</div>
						
						<div>
							<label>수금여부 </label>
							<select name="receivable_collected" id="receivable_collected" class="required">
							<c:if test="${inmap.receivable_collected == 0}">
								<option value="0" selected="selected">미수금</option>
								<option value="1">수금</option>
							</c:if>
							<c:if test="${inmap.receivable_collected == 1}">
								<option value="0">미수금</option>
								<option value="1" selected="selected">수금</option>
							</c:if>
							</select>
						</div>
						
						<div>
							<label>수금완료일자 </label>
							<input type="text" name="receivable_collect" id="receivable_collect" value="${inmap.receivable_collect}">
						</div>
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.receivable_no }, '${inmap.receivable_cino }', '${comcode_code }')">
						</div>
						<div align="left">
							<input type="button" value="bills" onclick="bills(${inmap.receivable_no}, '${comcode_code }')">
						</div>
					</form>
					<form action="${pageContext.request.contextPath }/c/c2/c22/inputBondbills" id="bills">
						<input type="hidden" name="receivable_no">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c22/createReceivable" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="client_no" id="client_no" value="17">
							<h3>채권 등록 사항</h3>
						<div>
							<label>코드 </label>
							<input type="text" name="receivable_code" id="receivable_code" maxlength="30" onblur="code(this.value)" class="required">
							<h6 id="receivecode" style="color:red;"></h6>
						</div>
						
						<div>
							<label>CI NUMBER </label>
							<input type="text" name="receivable_cino" id="receivable_cino" class="required" onblur="cino(this.value)">
							<h6 id="receivecino" style="color:red;"></h6>
						</div>
						
						<div>
							<label>금액 </label>
							<input type="text" name="receivable_price" id="receivable_price">
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
							<label>만기일</label>
							<input type="date" name="receivable_expiry" id="receivable_expiry" class="required">
						</div>
						
						<div>
							<label>수금여부 </label>
							<select name="receivable_collected" id="receivable_collected" class="required">
								<option value="0" selected="selected">미수금</option>
								<option value="1">수금</option>
							</select>
						</div>
						
						<div>
							<label>수금완료일자 </label>
							<input type="text" name="receivable_collect" id="receivable_collect">
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
function deletei(ino, recode, code){
	location.href='${pageContext.request.contextPath }/c/c2/c22/delete?receivable_code='+recode+'&receivable_no='+ino+'&comcode_code='+code;
}


// 코드 UNIQUE 검사 AJAX
function cino(v){
	var url = "${pageContext.request.contextPath }/c/c2/c22/getUniqueCIno";
	var param = "receivable_cino="+encodeURIComponent(v);
	
	sendRequest(url,param,cinocheck,"POST");
}
function cinocheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				document.getElementById("receivecino").innerText = data;
				document.getElementById("receivecino").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("receivecino").innerText = data;
				document.getElementById("register").disabled = true;
				document.getElementById("receivable_cino").focus();	
			}
		}
	}
}
function code(v){
	var url = "${pageContext.request.contextPath }/c/c2/c22/getUniqueCode";
	var param = "receivable_code="+encodeURIComponent(v);
	
	sendRequest(url,param,codecheck,"POST");
}
function codecheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				document.getElementById("receivecode").innerText = data;
				document.getElementById("receivecode").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("receivecode").innerText = data;
				document.getElementById("register").disabled = true;
				document.getElementById("receivable_code").focus();	
			}
		}
	}
}


// submit 유효성 검사
function sub(f){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.receivable_code.value == ""){
		f.receivable_code.focus();
		return;
	}else if(f.receivable_cino.value == ""){
		f.receivable_cino.focus();
		return;
	}else if(f.receivable_expiry.value == ""){
		f.receivable_expiry.focus();
		return;
	}else if(f.receivable_collected.value == ""){
		f.receivable_collected.focus();
		return;
	}else if(f.receivable_price.value == ""){
		var ch = confirm("금액이 입력되지 않았습니다. 등록하시겠습니까?");	// 확인 true, 취소 false
		if(ch){
			f.receivable_price.value = 0;
			f.submit();
		}else{
			f.receivable_price.focus();
			return;
		}
	}else if(!pat.test(f.receivable_price.value)){
		alert("100,000,000미만, 숫자만 입력 가능합니다.");
		f.receivable_price.focus();
		return;
	}else if(f.client_name.value == ""){
		var ch = confirm("거래처가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.client_name.focus();
			return;
		}
	}else if(f.receivable_collect.value == ""){
		var ch = confirm("수금완료일자가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.receivable_collect.focus();
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
function selectForm(no){
	document.getElementsByName("receivable_no")[0].value = no;
	
	document.getElementById("content").submit();
}

function bondbills(no){
	let l = document.getElementsByName("receivable_no").length;
	document.getElementsByName("receivable_no")[l-1].value = no
	
	document.getElementById("bills").submit();
}


</script>
</div>
</body>
</html>