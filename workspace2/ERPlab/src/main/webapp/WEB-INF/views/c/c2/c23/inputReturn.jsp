<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c23/returnAjax";
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
		procode.innerHTML += '<tr><td>코드</td><td>로트</td><td>바코드</td><td>품명</td><td>반품일자</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.return_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.return_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goodslot_lot;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goods_barcode;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goods_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.return_date;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
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
		<div class="dh_aligncenter">
			<h1>반품 관리</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="goods_name" ${param.type == 'goods_name' ? 'selected' : '' }>품명</option>
								<option value="goods_barcode" ${param.type == 'goods_barcode' ? 'selected' : '' }>바코드</option>
								<option value="goodssort_name" ${param.type == 'goodssort_name' ? 'selected' : '' }>구분</option>
								<option value="goodskind_name" ${param.type == 'goodskind_name' ? 'selected' : '' }>종류</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>제조사</option>
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
						<td>코드</td>
						<td>로트</td>
						<td>바코드</td>
						<td>품명</td>
						<td>반품일자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.return_no})" class="filter">
						<td>${map.return_code }</td>
						<td>${map.goodslot_lot }</td>
						<td>${map.goods_barcode }</td>
						<td>${map.goods_name }</td>
						<td>${map.return_date }</td>
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
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c23/inputReturn?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
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
							<input type="text" name="return_comment" id="return_comment" value="${inmap.return_comment }" maxlength="100">
						</div>
						
						<div>
							<label>날짜 </label>
							<input type="date" name="return_date" id="return_date" value="${inmap.return_date }">
						</div>
						
						<div>
							<label>수량 </label>
							<input type="text" name="return_qty" id="return_qty" value="${inmap.return_qty }" class="required" onkeypress="conculator(event, this.value)" onblur="conculator1(this.value)">
						</div>				
						
						<div>
							<label>제조사 </label>
							<input type="text" name="client_name" id="client_name" value="${inmap.client_name }" class="required" readonly="readonly">
						</div>	
						
						<div>
							<label>금액</label>
							<input type="text" name="return_price" id="return_price" value="${inmap.return_price }" class="required">
						</div>
						
						<div>
							<label>세액</label>
							<input type="text" name="return_tax" id="return_tax" value="${inmap.return_tax }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>반품 총액</label>
							<input type="text" name="return_total" id="return_total" value="${inmap.return_total }" class="required" readonly="readonly">
						</div>
						
						<c:if test="${login == 1 || login == 2 || login == 13 }">
						<div>
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei('${inmap.return_code }', ${inmap.return_no }, '${comcode_code }')">
						</div>
						</c:if>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/c/c2/c23/createReturn" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="client_no" id="client_no" value="17">
						<input type="hidden" name="goodslot_no" id="goodslot_no" value="1">
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
							<input type="text" name="client_name" id="client_name" class="required" readonly="readonly">
						</div>	
						
						<div>
							<label>사유 </label>
							<input type="text" name="return_comment" id="return_comment" maxlength="100">
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
							<input type="text" name="return_tax" id="return_tax" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>반품 총액</label>
							<input type="text" name="return_total" id="return_total" class="required" readonly="readonly">
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
<script type="text/javascript">

var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
var end = new Date(now_utc-timeOff).toISOString().split("-")[0];
document.getElementById("return_date").setAttribute("min", end+"-01-01");
document.getElementById("return_date").setAttribute("max", end+"-12-31");


function conculator(e, v){
	if(e.keyCode == 13){
		let lot = document.getElementById("goodslot_total").value;
		if(lot == ""){
			alert("제품을 먼저 선택해주세요.");
			return;
		}
		document.getElementById("return_price").value = Math.round(Number(v) * Number(lot));
		document.getElementById("return_tax").value = Math.round(Number(v) * 0.1);
		let tax = document.getElementById("return_tax").value; 
		let price = document.getElementById("return_price").value; 
		document.getElementById("return_total").value = Math.round(Number(price) + Number(tax));
	}
}

function conculator1(v){
	let lot = document.getElementById("goodslot_total").value;
	if(lot == ""){
		alert("제품을 먼저 선택해주세요.");
		return;
	}
	document.getElementById("return_price").value = Math.round(Number(v) * Number(lot));
	document.getElementById("return_tax").value = Math.round(Number(v) * 0.1);
	let tax = document.getElementById("return_tax").value; 
	let price = document.getElementById("return_price").value; 
	document.getElementById("return_total").value = Math.round(Number(price) + Number(tax));
}

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