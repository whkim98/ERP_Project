<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d2/d24/inputProductTestAjax";
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
		procode.innerHTML += '<tr><td>매입코드</td><td>평가날짜</td><td>평가등급</td><td>합/불여부</td><td>담당팀</td><td>거래처</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.producttest_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.purchase_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.producttest_date;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.producttest_grade;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.producttest_pnp == 0 ? '불합격' : '합격';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
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
		<div class="dh_aligncenter">
			<h1>재고 평가 관리(원부자재)</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="purchase_code" ${param.type == 'purchase_code' ? 'selected' : '' }>매입코드</option>
								<option value="producttest_grade" ${param.type == 'producttest_grade' ? 'selected' : '' }>평가등급</option>
								<option value="producttest_date" ${param.type == 'producttest_date' ? 'selected' : '' }>평가날짜</option>
								<option value="producttest_pnp" ${param.type == 'producttest_pnp' ? 'selected' : '' }>합/불</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
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
						<td>매입코드</td>
						<td>평가날짜</td>
						<td>평가등급</td>
						<td>합/불여부</td>
						<td>담당팀</td>
						<td>거래처</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.producttest_no})" class="filter">
						<td>${map.purchase_code }</td>
						<td>${map.producttest_date }</td>
						<td>${map.producttest_grade }</td>
						<td>${map.producttest_pnp == 0 ? '불합격' : '합격' }</td>
						<td>${map.team_name}</td>
						<td>${map.client_name}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
			<div class="dh_alignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d2/d24/inputProductTest?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d2/d24/updateForm" id="content" method="post">
				<input type="hidden" name="producttest_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/d/d2/d24/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="purchase_no" id="purchase_no" value="${inmap.purchase_no }">
						<input type="hidden" name="producttest_no" id="producttest_no" value="${inmap.producttest_no }">
						<input type="hidden" name="ptkind_no" id="ptkind_no" value="${inmap.ptkind_no }">
						<input type="hidden" name="goodslot_no" id="goodslot_no" value="${inmap.goodslot_no }">
						<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }">
						<input type="hidden" name="producttest_type" id="producttest_type" value="${inmap.producttest_type }">
						<input type="hidden" name="purchaseconnect_price" id="purchaseconnect_price" value="${inmap.purchaseconnect_price }">
						<input type="hidden" name="purchaseconnect_number" id="purchaseconnect_number" value="${inmap.purchaseconnect_number }">
						<input type="hidden" name="purchaseconnect_no" id="purchaseconnect_no" value="${inmap.purchaseconnect_no }">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						<div>
							<label>구매 코드 </label>
							<input type="text" name="purchase_code" id="purchase_code" maxlength="30" readonly="readonly" value="${inmap.purchase_code }" onclick="purchase('${comcode_code}')" class="required">
						</div>
						
						<div>
							<label>로트번호 </label>
							<input type="text" name="goodslot_lot" id="goodslot_lot" maxlength="30" readonly="readonly" value="${inmap.goodslot_lot }" onclick="purchasegoods()" class="required">
						</div>
						
						<div>
							<label>바코드 </label>
							<input type="text" name="goods_barcode" id="goods_barcode" maxlength="30" readonly="readonly" value="${inmap.goods_barcode }" class="required">
						</div>
						
						<div>
							<label>품명 </label>
							<input type="text" name="goods_name" id="goods_name" value="${inmap.goods_name }" readonly="readonly" class="required">
						</div>
						
						<div>
							<label>평가 종류 </label>
							<select name="ptkind_no" id="ptkind_no" class="required">
								<option value="0">선택</option>
								<c:forEach var="plist" items="${ptlist }">
									<option value="${plist.ptkind_no }" ${inmap.ptkind_no == plist.ptkind_no ? 'selected' : '' }>${plist.ptkind_type }</option>
								</c:forEach>
							</select>
						</div>
						
						<div>
							<label>손실률 </label>
							<input type="text" name="producttest_lossrate" id="producttest_lossrate" value="${inmap.producttest_lossrate }" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>손실 금액 </label>
							<input type="text" name="producttest_lossprice" id="producttest_lossprice" value="${inmap.producttest_lossprice }">
						</div>
						<div>
							<label>세액 </label>
							<input type="text" name="producttest_losstax" id="producttest_losstax" value="${inmap.producttest_losstax }">
						</div>
						<div>
							<label>손실 총액 </label>
							<input type="text" name="producttest_losstotal" id="producttest_losstotal" value="${inmap.producttest_losstotal }">
						</div>
						
						<div>
							<label>수량</label>
							<input type="text" name="producttest_lossqty" id="producttest_lossqty" value="${inmap.producttest_lossqty }">
						</div>	
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="producttest_content" id="producttest_content" value="${inmap.producttest_content }" class="required">
						</div>
						
						<div>
							<label>충당 가능 금액 </label>
							<input type="text" name="producttest_lossfull" id="producttest_lossfull" value="${inmap.producttest_lossfull }">
						</div>
						
						<div>
							<label>합/불 여부 </label>
							<select name="producttest_pnp">
								<option value="0" ${inmap.producttest_pnp == 0 ? 'selected' : '' }>불합격</option>
								<option value="1" ${inmap.producttest_pnp == 1 ? 'selected' : '' }>합격</option>
							</select>
						</div>
						
						<div>
							<label>최종 평가 등급 </label>
							<input type="text" name="producttest_grade" id="producttest_grade" value="${inmap.producttest_grade }" class="required" maxlength="30">
						</div>
						
						<div>
							<label>평가 담당팀 </label>
							<input type="text" name="team_name" id="team_name" onkeyup="team(event, this.value)" value="${inmap.team_name }">
							<input type="button" onclick="searcht()" value="조회">
						</div>
						
						<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
						<div>
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.producttest_no }, '${comcode_code }')">
						</div>
						</c:if>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/d/d2/d24/createProductTest" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="goodslot_no" id="goodslot_no">
						<input type="hidden" name="purchase_no" id="purchase_no">
						<input type="hidden" name="team_no" id="team_no" value="17">
						<input type="hidden" name="producttest_type" id="producttest_type" value="1">
						<input type="hidden" name="purchaseconnect_price" id="purchaseconnect_price">
						<input type="hidden" name="purchaseconnect_number" id="purchaseconnect_number">
						<input type="hidden" name="purchaseconnect_no" id="purchaseconnect_no">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>구매 코드 </label>
							<input type="text" name="purchase_code" id="purchase_code" class="required" readonly="readonly" onclick="purchase('${comcode_code}')">
						</div>
						
						<div>
							<label>로트번호 </label>
							<input type="text" name="goodslot_lot" id="goodslot_lot" class="required" readonly="readonly" onclick="purchasegoods()">
						</div>
						
						<div>
							<label>바코드 </label>
							<input type="text" name="goods_barcode" id="goods_barcode" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>품명 </label>
							<input type="text" name="goods_name" id="goods_name" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>평가 종류 </label>
							<select name="ptkind_no" class="required" id="ptkind_no">
								<option value="0">선택</option>
								<c:forEach var="plist" items="${ptlist }">
									<option value="${plist.ptkind_no }">${plist.ptkind_type }</option>
								</c:forEach>
							</select>
						</div>
						
						<div>
							<label>손실률 </label>
							<input type="text" name="producttest_lossrate" id="producttest_lossrate" onkeyup="conculator(event, this.value)" onblur="conculator1(this.value)" class="required">
						</div>
						
						<div>
							<label>손실 금액 </label>
							<input type="text" name="producttest_lossprice" id="producttest_lossprice" readonly="readonly">
						</div>
						<div>
							<label>세액 </label>
							<input type="text" name="producttest_losstax" id="producttest_losstax" readonly="readonly">
						</div>
						<div>
							<label>손실 총액 </label>
							<input type="text" name="producttest_losstotal" id="producttest_losstotal" readonly="readonly">
						</div>
						
						<div>
							<label>수량</label>
							<input type="text" name="producttest_lossqty" id="producttest_lossqty" readonly="readonly">
						</div>	
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="producttest_content" id="producttest_content" class="required">
						</div>
						
						<div>
							<label>충당 가능 금액 </label>
							<input type="text" name="producttest_lossfull" id="producttest_lossfull">
						</div>
						
						<div>
							<label>합/불 여부 </label>
							<select name="producttest_pnp">
								<option value="0" selected="selected">불합격</option>
								<option value="1">합격</option>
							</select>
						</div>
						
						<div>
							<label>최종 평가 등급 </label>
							<input type="text" name="producttest_grade" id="producttest_grade" class="required" maxlength="30">
						</div>
						
						<div>
							<label>평가 담당팀 </label>
							<input type="text" name="team_name" id="team_name" onkeyup="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
						</div>
						
						<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
						<div>
							<input type="button" id="register" value="save" onclick="sub(this.form)">
							<input type="reset" value="reset">
						</div>
						</c:if>
					</form>
				</c:otherwise>
			</c:choose>
			
		</div>
	
</div>
<script type="text/javascript">

var pat = /^[0-9]{0,8}$/;

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no, code){
	location.href='${pageContext.request.contextPath }/d/d2/d24/delete?producttest_no='+no+'&comcode_code='+code;
}

function conculator(e, v){
	if(e.keyCode == 13){
		if(!pat.test(document.getElementById("producttest_lossrate").value)){
			alert("숫자만 입력 가능합니다.");
			document.getElementById("producttest_lossrate").value = '';
			document.getElementById("producttest_lossprice").value = '';
			document.getElementById("producttest_losstax").value = '';
			document.getElementById("producttest_losstotal").value = '';
			document.getElementById("producttest_lossqty").value = '';
			
			document.getElementById("producttest_lossrate").focus();
			return;
		}
		if(document.getElementById("producttest_lossrate").value > 99){
			alert("손실률은 100% 미만이어야 합니다.");
			document.getElementById("producttest_lossrate").value = '';
			document.getElementById("producttest_lossprice").value = '';
			document.getElementById("producttest_losstax").value = '';
			document.getElementById("producttest_losstotal").value = '';
			document.getElementById("producttest_lossqty").value = '';
			
			document.getElementById("producttest_lossrate").focus();
			return;
		}
		if(document.getElementById("goodslot_no").value == ""){
			alert("제품을 먼저 선택해주세요.");
			document.getElementById("producttest_lossrate").value = '';
			document.getElementById("producttest_lossprice").value = '';
			document.getElementById("producttest_losstax").value = '';
			document.getElementById("producttest_losstotal").value = '';
			document.getElementById("producttest_lossqty").value = '';
			
			document.getElementById("goodslot_lot").focus();
			return;
		}
		let pcp = document.getElementById("purchaseconnect_price").value;
		let pcq = document.getElementById("purchaseconnect_number").value;
		let pp = Number(pcp) * Number(pcq);
		document.getElementById("producttest_lossprice").value = Math.round(Number(pp) * (Number(v) * 0.01));
		document.getElementById("producttest_losstax").value = Math.round(Number(pp) * (Number(v) * 0.01) * 0.1);
		let tax = document.getElementById("producttest_losstax").value; 
		document.getElementById("producttest_losstotal").value = Math.round(Number(pp) * (Number(v) * 0.01) + Number(tax));
		document.getElementById("producttest_lossqty").value = Math.round(Number(pcq) * (Number(v) * 0.01));
	}
}

function conculator1(v){
	if(!pat.test(document.getElementById("producttest_lossrate").value)){
		alert("숫자만 입력 가능합니다.");
		document.getElementById("producttest_lossrate").value = '';
		document.getElementById("producttest_lossprice").value = '';
		document.getElementById("producttest_losstax").value = '';
		document.getElementById("producttest_losstotal").value = '';
		document.getElementById("producttest_lossqty").value = '';
		
		document.getElementById("producttest_lossrate").focus();
		return;
	}
	if(document.getElementById("producttest_lossrate").value > 99){
		alert("손실률은 100% 미만이어야 합니다.");
		document.getElementById("producttest_lossrate").value = '';
		document.getElementById("producttest_lossprice").value = '';
		document.getElementById("producttest_losstax").value = '';
		document.getElementById("producttest_losstotal").value = '';
		document.getElementById("producttest_lossqty").value = '';
		
		document.getElementById("producttest_lossrate").focus();
		return;
	}
	if(document.getElementById("goodslot_no").value == ""){
		alert("제품을 먼저 선택해주세요.");
		document.getElementById("producttest_lossrate").value = '';
		document.getElementById("producttest_lossprice").value = '';
		document.getElementById("producttest_losstax").value = '';
		document.getElementById("producttest_losstotal").value = '';
		document.getElementById("producttest_lossqty").value = '';
		
		document.getElementById("goodslot_lot").focus();
		return;
	}
	let pcp = document.getElementById("purchaseconnect_price").value;
	let pcq = document.getElementById("purchaseconnect_number").value;
	let pp = Number(pcp) * Number(pcq);
	document.getElementById("producttest_lossprice").value = Math.round(Number(pp) * (Number(v) * 0.01));
	document.getElementById("producttest_losstax").value = Math.round(Number(pp) * (Number(v) * 0.01) * 0.1);
	let tax = document.getElementById("producttest_losstax").value; 
	document.getElementById("producttest_losstotal").value = Math.round(Number(pp) * (Number(v) * 0.01) + Number(tax));
	document.getElementById("producttest_lossqty").value = Math.round(Number(pcq) * (Number(v) * 0.01));
}


	
// submit 유효성 검사
function sub(f){
	if(f.producttest_grade.value == ""){
		f.producttest_grade.focus();
		return;
	}
	if(f.producttest_lossrate.value == ""){
		f.producttest_lossrate.focus();
		return;
	}
	if(document.getElementById("ptkind_no").value == 0){
		alert("평가종류를 선택해주세요.");
		document.getElementById("ptkind_no").focus();
		return;
	}
	if(f.producttest_content.value == ""){
		let ch = confirm("평가내용이 입력되지 않았습니다. 계속 진행하시려면 확인을 눌러주세요");
		if(ch){
			
		}else {
			f.producttest_lossqty.focus();
			return;
		}
	}
	if(f.producttest_lossqty.value == ""){
		let ch = confirm("수량이 입력되지 않았습니다. 계속 진행하시려면 확인을 눌러주세요");
		if(ch){
			f.producttest_lossqty.value = 0;
		}else {
			f.producttest_lossqty.focus();
			return;
		}
	}
	if(!pat.test(f.producttest_lossqty.value)){
		alert("숫자만 입력 가능합니다.");
		f.producttest_lossqty.focus();
		return;
	}
	if(f.producttest_lossfull.value == ""){
		let ch = confirm("충당 가능 금액이 입력되지 않았습니다. 계속 진행하시려면 확인을 눌러주세요");
		if(ch){
			f.producttest_lossfull.value = 0;
		}else {
			f.producttest_lossfull.focus();
			return;
		}
	}
	if(!pat.test(f.producttest_lossfull.value)){
		alert("숫자만 입력 가능합니다.");
		f.producttest_lossfull.focus();
		return;
	}
	
	if(f.producttest_lossfull.value > f.producttest_losstotal.value){
		alert("충당 금액은 손실 총액을 초과할 수 없습니다.");
		f.producttest_lossfull.value = 0;
		f.producttest_lossfull.focus();
		return;
	}
	
	if(f.team_no.value == ""){
		f.team_name.focus();
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
	document.getElementsByName("producttest_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

function team(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("팀명을 입력해주세요.");
			document.getElementById("team_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d2/d21/team";
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

function purchase(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d24/purchase?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=1000");
}

function purchasegoods(){
	let cv = document.getElementById("purchase_no").value;
	if(cv == ""){
		alert("구매건을 먼저 선택해주세요.");
		document.getElementById("purchase_code").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d24/goodsList?purchase_no="+cv, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}


</script>
</div>
</body>
</html>