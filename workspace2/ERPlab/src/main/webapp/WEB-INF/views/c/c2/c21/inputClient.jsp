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
	var url = "${pageContext.request.contextPath}/a/a4/a41/loanAjax";
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
		procode.innerHTML += '<tr><td>거래처</td><td>사업자등록번호</td><td>구분</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.client_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_registeredno;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_businesstype;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
		}
	}
}


//전체목록조회 > 새창으로
function ctlist(){
	let openWin = window.open("${pageContext.request.contextPath}/c/c2/c21/ctlist", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function cslist(){
	let openWin = window.open("${pageContext.request.contextPath}/c/c2/c21/cslist", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function btsubctgr(){
	let openWin = window.open("${pageContext.request.contextPath}/c/c2/c21/btsubctgr", "_blank", "scrollbars=yes, top=150, left=300, width=700, height=700");
}
function goodslist(i, code){
	let openWin = window.open("${pageContext.request.contextPath}/c/c2/c21/goodslist?i="+i+"&comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=800");
}

//자동완성 > AJAX
function country(e, name){
	if(e.keyCode == 13){
		if(name == ""){		
			alert("국가를 입력해주세요.");
			document.getElementById("country_name").focus();
			return;	
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/country";		
		var param = "country_name=" + encodeURIComponent(name);		
		
		sendRequest(url, param, countryname, "POST");	
	}
}
function countryname(){	
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;	
		if(data != ""){			
			var data2 = JSON.parse(data);		
			document.getElementById("country_name").value = data2.country_name;	
			document.getElementById("country_no").value = data2.country_no;
		}else {
			document.getElementById("country_name").value = '';
			alert("조회된 국가가 없습니다. 조회 버튼을 클릭하여 목록에서 국가를 선택해주세요.");
		}
	}
}

function clientsort(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("종류를 입력해주세요.");
			document.getElementById("clientsort_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/clientsort";
		var param = "clientsort_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, clientsortname, "POST");
	}
}
function clientsortname(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("clientsort_name").value = data2.clientsort_name;
			document.getElementById("clientsort_no").value = data2.clientsort_no;
		}else {
			document.getElementById("clientsort_name").value = '';
			alert("중복된 종류입니다. 조회 버튼을 클릭하여 목록에서 종류를 선택해주세요.");
		}
	}
}
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">거래처 관리</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
								<option value="clientsort_name" ${param.type == 'clientsort_name' ? 'selected' : '' }>종류</option>
								<option value="client_businesstype" ${param.type == 'client_businesstype' ? 'selected' : '' }>구분</option>
								<option value="businesstype_name" ${param.type == 'businesstype_name' ? 'selected' : '' }>업태</option>
								<option value="businesstype_subctgr" ${param.type == 'businesstype_subctgr' ? 'selected' : '' }>업종</option>
								<option value="country_name" ${param.type == 'country_name' ? 'selected' : '' }>국가</option>
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
						<td>거래처</td>
						<td>사업자등록번호</td>
						<td>구분</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.client_no})" class="filter" id="filter">
						<td class="code">${map.client_name }</td>
						<td class="price">${map.client_registeredno }</td>
						<td class="cont">${map.client_businesstype }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c21?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/c/c2/c21/updateForm" id="content" method="post">
				<input type="hidden" name="client_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/c/c2/c21/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="country_no" id="country_no" value="${inmap.country_no }">
						<input type="hidden" name="clientsort_no" id="clientsort_no" value="${inmap.clientsort_no }">
						<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
						<input type="hidden" name="businesstype_no" id="businesstype_no" value="${inmap.businesstype_no }">
							<h3>거래처 등록 사항</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>거래처명 </label>
							<input type="text" name="client_name" id="client_name" value="${inmap.client_name }" maxlength="30" class="required">
						</div>
						
						<div>
							<label>국가 </label>
							<input type="text" name="country_name" id="country_name" value="${inmap.country_name }" onkeypress="country(event, this.value)" class="required">
							<input type="button" onclick="ctlist()" value="조회">
						</div>
						
						<div>
							<label>종류 </label>
							<input type="text" name="clientsort_name" id="clientsort_name" value="${inmap.clientsort_name }" onkeypress="clientsort(event, this.value)" class="required">
							<input type="button" onclick="cslist()" value="조회">
						</div>
						
						<div>
							<label>사업자 등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" value="${inmap.client_registeredno }" maxlength="30" class="required">
							<h6 id="registeredno" style="color:red;"></h6>
						</div>
						
						<div>
							<label>법인 등록번호</label>
							<input type="text" name="client_corporatedno" id="client_corporatedno" value="${inmap.client_corporatedno }" maxlength="30">
						</div>
						
						<div>
							<label>대표자 </label>
							<input type="text" name="client_representative" id="client_representative" value="${inmap.client_representative }" class="required">
						</div>				
						
						<div>
							<label>사업형태 </label>
							<input type="text" name="client_businesstype" id="client_businesstype" value="${inmap.client_businesstype }">
						</div>	
							
						<div>
							<label>업태 </label>
							<input type="text" name="businesstype_name" id="businesstype_name" readonly="readonly" value="${inmap.businesstype_name }" onclick="btname()" class="required">
							<label>업종 </label>
							<input type="text" name="businesstype_subctgr" id="businesstype_subctgr" readonly="readonly" value="${inmap.businesstype_subctgr }" onclick="btsubctgr()" class="required">
						</div>
						
						<div>
							<label>사업장 </label>
							<input type="text" name="client_addr1" id="client_addr1" value="${inmap.client_addr1 }" class="required">
						</div>
						
						<div>
							<label>상세 주소</label>
							<input type="text" name="client_addr2" id="client_addr2" value="${inmap.client_addr2 }" class="required">
						</div>
						
						<div>
							<label>우편 번호 </label>
							<input type="text" name="client_postal" id="client_postal" value="${inmap.client_postal }" class="required">
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" value="${inmap.client_manager }">
						</div>
						<div>
							<label>담당자번호 </label>
							<input type="text" name="client_contact" id="client_contact" value="${inmap.client_contact }">
						</div>
						
						<div>
							<label>대표 번호 </label>
							<input type="text" name="client_directno" id="client_directno" value="${inmap.client_directno }" class="required">
						</div>
						
						<div>
							<label>fax </label>
							<input type="text" name="client_fax" id="client_fax" value="${inmap.client_fax }">
						</div>		
						
						<div>
							<label>이메일 </label>
							<input type="text" name="client_email" id="client_email" value="${inmap.client_email }" class="required">
						</div>	
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.client_no }, '${comcode_code }')">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c21/createClient" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="country_no" id="country_no" value="26">
						<input type="hidden" name="clientsort_no" id="clientsort_no" value="3">
						<input type="hidden" name="businesstype_no" id="businesstype_no" value="1">
							<h3>거래처 등록 사항</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>거래처명 </label>
							<input type="text" name="client_name" id="client_name" maxlength="30" class="required">
						</div>
						
						<div>
							<label>국가 </label>
							<input type="text" name="country_name" id="country_name" onkeypress="country(event, this.value)" class="required">
							<input type="button" onclick="ctlist()" value="조회">
						</div>
						
						<div>
							<label>종류 </label>
							<input type="text" name="clientsort_name" id="clientsort_name" onkeypress="clientsort(event, this.value)" class="required">
							<input type="button" onclick="cslist()" value="조회">
						</div>
						
						<div>
							<label>사업자 등록번호 </label>
							<input type="text" name="client_registeredno" id="client_registeredno" maxlength="30" class="required">
							<h6 id="registeredno" style="color:red;"></h6>
						</div>
						
						<div>
							<label>법인 등록번호</label>
							<input type="text" name="client_corporatedno" id="client_corporatedno" maxlength="30">
						</div>
						
						<div>
							<label>대표자 </label>
							<input type="text" name="client_representative" id="client_representative" class="required">
						</div>				
						
						<div>
							<label>사업형태 </label>
							<input type="text" name="client_businesstype" id="client_businesstype">
						</div>	
							
						<div>
							<label>업태 </label>
							<input type="text" name="businesstype_name" id="businesstype_name" readonly="readonly" onclick="btsubctgr()" class="required">
							<label>업종 </label>
							<input type="text" name="businesstype_subctgr" id="businesstype_subctgr" readonly="readonly" onclick="btsubctgr()" class="required">
						</div>
						
						<div>
							<label>사업장 </label>
							<input type="text" name="client_addr1" id="client_addr1" class="required">
						</div>
						
						<div>
							<label>상세 주소</label>
							<input type="text" name="client_addr2" id="client_addr2" class="required">
						</div>
						
						<div>
							<label>우편 번호 </label>
							<input type="text" name="client_postal" id="client_postal" class="required">
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager">
						</div>
						<div>
							<label>담당자번호 </label>
							<input type="text" name="client_contact" id="client_contact">
						</div>
						
						<div>
							<label>대표 번호 </label>
							<input type="text" name="client_directno" id="client_directno" class="required">
						</div>
						
						<div>
							<label>fax </label>
							<input type="text" name="client_fax" id="client_fax">
						</div>		
						
						<div>
							<label>이메일 </label>
							<input type="text" name="client_email" id="client_email" class="required">
						</div>	
						
						<div align="right">
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


// 사업자등록번호 UNIQUE 검사 AJAX
function registeredno(v){
	var url = "${pageContext.request.contextPath }/c/c2/c21/registeredno";
	var param = "client_registeredno="+encodeURIComponent(v);			
	
	sendRequest(url,param,registerednocheck,"POST");	
}
function registerednocheck(){	
	if(xhr.readyState==4 && xhr.status==200) {		
		var data = xhr.responseText;	
		if(data != ""){		
			if(data == "사용 가능한 코드입니다."){		
				document.getElementById("registeredno").innerText = data;
				document.getElementById("registeredno").style.color = "blue";
				document.getElementById("register").disabled = false;		
			}else {
				document.getElementById("registeredno").innerText = data;
				document.getElementById("register").disabled = true;		
				document.getElementById("client_registeredno").focus();			
			}
		}
	}
}


// submit 유효성 검사
function sub(f){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.client_registeredno.value == ""){
		f.client_registeredno.focus();
		return;
	}else if(f.businesstype_name.value == ""){
		f.businesstype_name.focus();
		return;
	}else if(f.businesstype_subctgr.value == ""){
		f.businesstype_subctgr.focus();
		return;
	}else if(f.client_name.value == ""){
		f.client_name.focus();
		return;
	}else if(f.country_name.value == ""){
		f.country_name.focus();
		return;
	}else if(f.clientsort_name.value == ""){
		f.clientsort_name.focus();
		return;
	}else if(f.client_representative.value == ""){
		f.client_representative.focus();
		return;
	}else if(f.client_addr1.value == ""){
		f.client_addr1.focus();
		return;
	}else if(f.client_addr2.value == ""){
		f.client_addr2.focus();
		return;
	}else if(f.client_postal.value == ""){
		f.client_postal.focus();
		return;
	}else if(f.client_directno.value == ""){
		f.client_directno.focus();
		return;
	}else if(f.client_email.value == ""){
		f.client_email.focus();
		return;
	}else if(f.client_corporatedno.value == ""){
		var ch = confirm("법인등록번호가 입력되지 않았습니다. 등록하시겠습니까?");	// 확인 true, 취소 false
		if(ch){
			f.submit();
		}else{
			f.client_corporatedno.focus();
			return;
		}
	}else if(f.client_businesstype.value == ""){
		var ch = confirm("사업형태가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.client_businesstype.focus();
			return;
		}
	}else if(f.client_contact.value == ""){
		var ch = confirm("담당자 번호가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.client_contact.focus();
			return;
		}
	}else if(f.client_manager.value == ""){
		var ch = confirm("담당자가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.client_manager.focus();
			return;
		}
	}else if(f.client_fax.value == ""){
		var ch = confirm("fax가 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.client_fax.focus();
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

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("client_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

</script>
</div>
</body>
</html>