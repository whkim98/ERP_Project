<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">

function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c21/clientAjax";
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
		<div class="dh_aligncenter">
			<h1>거래처 관리</h1>
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
			
			<div class="dh_overflow">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>거래처</td>
						<td>사업자등록번호</td>
						<td>구분</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.client_no})" class="filter" id="filter">
						<td>${map.client_name }</td>
						<td>${map.client_registeredno }</td>
						<td>${map.client_businesstype }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<c:if test="${login == 1 || login == 2 || login == 13 }">
			<div class="dh_alignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c21?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
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
							<input type="text" name="client_registeredno" id="client_registeredno" value="${inmap.client_registeredno }" maxlength="30" class="required" onkeyup="registeredno1(event, this.value)" onblur="registeredno(this.value)">
							<h6 id="registeredno" style="color:red;"></h6>
						</div>
						
						<div>
							<label>법인 등록번호</label>
							<input type="text" name="client_corporatedno" id="client_corporatedno" value="${inmap.client_corporatedno }" maxlength="30">
						</div>
						
						<div>
							<label>대표자 </label>
							<input type="text" name="client_representative" id="client_representative" value="${inmap.client_representative }" class="required" maxlength="30">
						</div>				
						
						<div>
							<label>사업형태 </label>
							<input type="text" name="client_businesstype" id="client_businesstype" value="${inmap.client_businesstype }" maxlength="30">
						</div>	
							
						<div>
							<label>업태 </label>
							<input type="text" name="businesstype_name" id="businesstype_name" readonly="readonly" value="${inmap.businesstype_name }" onclick="btname()" class="required">
							<label>업종 </label>
							<input type="text" name="businesstype_subctgr" id="businesstype_subctgr" readonly="readonly" value="${inmap.businesstype_subctgr }" onclick="btsubctgr()" class="required">
						</div>
						
						<div>
							<label>사업장 </label>
							<input type="text" name="client_addr1" id="client_addr1" value="${inmap.client_addr1 }" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>상세 주소</label>
							<input type="text" name="client_addr2" id="client_addr2" value="${inmap.client_addr2 }" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>우편 번호 </label>
							<input type="text" name="client_postal" id="client_postal" value="${inmap.client_postal }" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" value="${inmap.client_manager }" maxlength="30">
						</div>
						<div>
							<label>담당자번호 </label>
							<input type="text" name="client_contact" id="client_contact" value="${inmap.client_contact }" maxlength="30">
						</div>
						
						<div>
							<label>대표 번호 </label>
							<input type="text" name="client_directno" id="client_directno" value="${inmap.client_directno }" class="required" maxlength="30">
						</div>
						
						<div>
							<label>fax </label>
							<input type="text" name="client_fax" id="client_fax" value="${inmap.client_fax }" maxlength="30">
						</div>		
						
						<div>
							<label>이메일 </label>
							<input type="text" name="client_email" id="client_email" value="${inmap.client_email }" class="required" maxlength="30">
						</div>	
						<c:if test="${login == 1 || login == 2 || login == 13 }">
						<div>
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.client_no }, '${comcode_code }')">
						</div>
						</c:if>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c21/createClient" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="country_no" id="country_no" value="26">
						<input type="hidden" name="clientsort_no" id="clientsort_no" value="3">
						<input type="hidden" name="businesstype_no" id="businesstype_no" value="1">
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
							<input type="text" name="client_registeredno" id="client_registeredno" maxlength="30" class="required" onkeyup="registeredno1(event, this.value)" onblur="registeredno(this.value)">
							<h6 id="registeredno" style="color:red;"></h6>
						</div>
						
						<div>
							<label>법인 등록번호</label>
							<input type="text" name="client_corporatedno" id="client_corporatedno" maxlength="30">
						</div>
						
						<div>
							<label>대표자 </label>
							<input type="text" name="client_representative" id="client_representative" class="required" maxlength="30">
						</div>				
						
						<div>
							<label>사업형태 </label>
							<input type="text" name="client_businesstype" id="client_businesstype" maxlength="30">
						</div>	
							
						<div>
							<label>업태 </label>
							<input type="text" name="businesstype_name" id="businesstype_name" readonly="readonly" onclick="btsubctgr()" class="required">
							<label>업종 </label>
							<input type="text" name="businesstype_subctgr" id="businesstype_subctgr" readonly="readonly" onclick="btsubctgr()" class="required">
						</div>
						
						<div>
							<label>사업장 </label>
							<input type="text" name="client_addr1" id="client_addr1" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>상세 주소</label>
							<input type="text" name="client_addr2" id="client_addr2" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>우편 번호 </label>
							<input type="text" name="client_postal" id="client_postal" class="required" onclick="searchAddr()">
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="client_manager" id="client_manager" maxlength="30">
						</div>
						<div>
							<label>담당자번호 </label>
							<input type="text" name="client_contact" id="client_contact" maxlength="30">
						</div>
						
						<div>
							<label>대표 번호 </label>
							<input type="text" name="client_directno" id="client_directno" class="required" maxlength="30">
						</div>
						
						<div>
							<label>fax </label>
							<input type="text" name="client_fax" id="client_fax" maxlength="30">
						</div>		
						
						<div>
							<label>이메일 </label>
							<input type="text" name="client_email" id="client_email" class="required" maxlength="30">
						</div>	
						<c:if test="${login == 1 || login == 2 || login == 13 }">
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var regRno =  /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
	var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no, code){
	location.href='${pageContext.request.contextPath }/c/c2/c21/delete?client_no='+no+'&comcode_code='+code;
}


// 사업자등록번호 UNIQUE 검사 AJAX
function registeredno(v){
	if(v == ""){
		alert("공백은 불가합니다.");
		return;
	}
	if(!regRno.test(v)){
		alert("알맞은 사업자등록번호 형식이 아닙니다.");
		document.getElementById("client_registeredno").value = "";
		return;
	}
	var url = "${pageContext.request.contextPath }/c/c2/c21/registeredno";
	var param = "client_registeredno="+encodeURIComponent(v);			
	
	sendRequest(url,param,registerednocheck,"POST");	
}
function registerednocheck(){	
	if(xhr.readyState==4 && xhr.status==200) {		
		var data = xhr.responseText;	
		if(data != ""){		
			if(data == "사용 가능한 사업자등록번호입니다."){		
				document.getElementById("registeredno").innerText = data;
				document.getElementById("registeredno").style.color = "blue";
				document.getElementById("register").disabled = false;		
			}else {
				document.getElementById("registeredno").innerText = data;
				document.getElementById("registeredno").style.color = "red";
				document.getElementById("register").disabled = true;		
			}
		}
	}
}

function registeredno1(e,v){
	if(e.keyCode == 13){
		if(v == ""){
			alert("공백은 불가합니다.");
			return;
		}
		if(!regRno.test(v)){
			alert("알맞은 사업자등록번호 형식이 아닙니다.");
			document.getElementById("client_registeredno").value = "";
			return;
		}
		var url = "${pageContext.request.contextPath }/c/c2/c21/registeredno";
		var param = "client_registeredno="+encodeURIComponent(v);			
		
		sendRequest(url,param,registerednocheck1,"POST");	
	}
}
function registerednocheck1(){	
	if(xhr.readyState==4 && xhr.status==200) {		
		var data = xhr.responseText;	
		if(data != ""){		
			if(data == "사용 가능한 사업자등록번호입니다."){		
				document.getElementById("registeredno").innerText = data;
				document.getElementById("registeredno").style.color = "blue";
				document.getElementById("register").disabled = false;		
			}else {
				document.getElementById("registeredno").innerText = data;
				document.getElementById("registeredno").style.color = "red";
				document.getElementById("register").disabled = true;		
			}
		}
	}
}


// submit 유효성 검사
function sub(f){
	let regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
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
	}
	
	if(!regRno.test(f.client_registeredno.value)){
		alert("알맞은 사업자등록번호 형식이 아닙니다.");
		f.client_registeredno.focus();
		return;
	}
	if(!regex.test(f.client_email.value)){
		alert("알맞은 E-Mail 형식이 아닙니다.");
		f.client_email.focus();
		return;
	}
	if(!regExp.test(f.client_directno.value)){
		alert("알맞은 전화번호 형식이 아닙니다.");
		f.client_directno.focus();
		return;
	}
	
	var ch = confirm("등록하시겠습니까?");
	if(ch){
		f.submit();
	}else {
		return;
	}
	
}

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("client_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

//<주소 api>
function searchAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("client_addr2").value = extraAddr;
            
            } else {
                document.getElementById("client_addr2").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('client_postal').value = data.zonecode;
            document.getElementById("client_addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("client_addr2").focus();
        }
    }).open();
        customInput.style.display = "none";
}

</script>
</div>
</body>
</html>