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
	var url = "${pageContext.request.contextPath}/d/d1/d14/evAjax";
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
		procode.innerHTML += '<tr><td>생산코드</td><td>생산명</td><td>담당자</td><td>작성일</td><td>평가상태</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.evaluation_no+", "+map.requestproduct_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.product_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.product_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.employee1_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.evaluation_date;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.evaluation_status == 0 ? '미완' : '완료';
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">생산 실적 평가</h1>
		</div>
		<div class="divform2">
			<div>
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="evaluation_date" ${param.type == 'evaluation_date' ? 'selected' : '' }>작성일</option>
								<option value="product_code" ${param.type == 'product_code' ? 'selected' : '' }>생산코드</option>
								<option value="product_name" ${param.type == 'product_name' ? 'selected' : '' }>생산명</option>
								<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
								<option value="evaluation_status" ${param.type == 'evaluation_status' ? 'selected' : '' }>평가상태</option>
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
						<td>생산코드</td>
						<td>생산명</td>
						<td>담당자</td>
						<td>작성일</td>
						<td>평가상태</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.evaluation_no}, ${map.requestproduct_no })" class="filter">
						<td class="price">${map.product_code }</td>
						<td class="cont">${map.product_name}</td>
						<td>${map.employee1_name}</td>
						<td class="code">${map.evaluation_date }</td>
						<td>${map.evaluation_status == 0 ? '미완' : '완료'}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d14/inputEvaluation?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d14/updateForm" id="content" method="post">
				<input type="hidden" name="evaluation_no">
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
					<form action="${pageContext.request.contextPath }/d/d1/d14/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="evaluation_no" id="evaluation_no" value="${inmap.evaluation_no }">
						<input type="hidden" name="requestproduct_no" id="requestproduct_no" value="${inmap.requestproduct_no }">
						<input type="hidden" name="product_no" id="product_no" value="${inmap.product_no }">
						<input type="hidden" name="product_lot" id="product_lot" value="${inmap.product_lot }">
						<input type="hidden" name="employee2_no" id="employee2_no" value="${inmap.employee2_no }">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						
						<div>
							<label>생산코드 </label>
							<input type="text" name="product_code" id="product_code" value="${inmap.product_code }" class="required" onclick="selectProduct('${comcode_code}')" readonly="readonly">
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" value="${inmap.product_name }" class="required" readonly="readonly">
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
							<label>불량률 </label>
							<input type="text" name="evaluation_rate" id="evaluation_rate" value="${inmap.evaluation_rate }">
						</div>
						
						<table id="goodsList">
							<tr>
								<td>상품 코드</td>
								<td>바코드</td>
								<td>품명</td>
								<td>생산 수량</td>
								<td>불량 사유</td>
								<td>불량 수량</td>
							</tr>
						<c:forEach var="vo" items="${dlist }">
							<tr>
								<td>${vo.goods_code }</td>
								<td>${vo.goods_barcode }</td>
								<td>${vo.goods_name }</td>
								<td>${vo.goodslot_qty }</td>
								<td><input type="text" value="${vo.defective_comment }" name="defective_comment"></td>
								<td><input type="text" value="${vo.defective_number }" name="defective_number"></td>
							</tr>
						</c:forEach>
						</table>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="employee1_name" id="employee1_name" value="${inmap.employee1_name }" onclick="employee('${comcode_code}')">
						</div>	
						
						<div>
							<label>직급 </label>
							<input type="text" name="employee2_position" id="employee2_position" value="${inmap.employee2_position }">
						</div>	
						
						<div align="right">
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.evaluation_no }, '${comcode_code }', ${inmap.requestproduct_no })">
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/d/d1/d14/createEvaluation" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="employee2_no" id="employee2_no">
						<input type="hidden" name="requestproduct_no" id="requestproduct_no">
						<input type="hidden" name="product_no" id="product_no">
						<input type="hidden" name="product_lot" id="product_lot">
						<h3>생산 실적 평가</h3>
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						
						<div>
							<label>생산코드 </label>
							<input type="text" name="product_code" id="product_code" class="required" readonly="readonly" onclick="selectProduct('${comcode_code}')">
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>서류상 종료 날짜 </label>
							<input type="date" name="evaluation_paperend" id="evaluation_paperend" class="required">
						</div>
							
						<div>
							<label>실제 종료 날짜 </label>
							<input type="date" name="evaluation_actualend" id="evaluation_actualend" class="required">
						</div>
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="evaluation_content" id="evaluation_content">
						</div>
						
						<div>
							<label>상태 </label>
							<select name="evaluation_status" id="evaluation_status">
								<option value="0">미완료</option>
								<option value="1">정상 완료</option>
							</select>
						</div>
						
						<div>
							<label>불량률 </label>
							<input type="text" name="evaluation_rate" id="evaluation_rate">
							<input type="button" onclick="goodsList()" value="목록보기">
						</div>
						
						<table id="goodsList">
						</table>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="employee1_name" id="employee1_name" onclick="employee('${comcode_code}')">
						</div>	
						
						<div>
							<label>직급 </label>
							<input type="text" name="employee2_position" id="employee2_position">
						</div>	
						<div>
							<input type="button" id="register" value="save" onclick="sub(this.form)">
							<input type="reset" value="reset">
							<input type="button" value="불량 정보" onclick="defective('${comcode_code}')">
						</div>
					</form>
				</c:otherwise>
			</c:choose>
			
		</div>
	
</div>
<script type="text/javascript">

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no, code, rno){
	location.href='${pageContext.request.contextPath }/d/d1/d14/delete?evaluation_no='+no+'&comcode_code='+code+"&requestproduct_no="+rno;
}

	
// submit 유효성 검사
function sub(f, total){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.product_code.value == ""){
		f.product_code.focus();
		return;
	}else if(f.evaluation_paperend.value == ""){
		f.evaluation_paperend.focus();
		return;
	}else if(f.evaluation_actualend.value == ""){
		f.evaluation_actualend.focus();
		return;
	}else if(f.evaluation_content.value == ""){
		var ch = confirm("내용이 입력되지 않았습니다. 등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			f.evaluation_content.focus();
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
function selectForm(no, rno){
	document.getElementsByName("evaluation_no")[0].value = no;
	document.getElementsByName("requestproduct_no")[0].value = rno;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

function selectProduct(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d14/selectProduct?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=1000");
}

function employee(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d14/employee?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

function defective(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d14/defective?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}


function goodsList(){
	var no = document.getElementById("product_no").value;
	if(no == ""){
		alert("생산코드를 선택하여 주십시오.");
		document.getElementById("product_code").focus();
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d1/d14/goodsAjax";
	var param = "product_no="+encodeURIComponent(no);
	
	sendRequest(url,param,goodsCheck,"POST");
}
function goodsCheck(){
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
		newTd.innerHTML = '생산 수량';
		newTr.appendChild(newTd);
		newTd = document.createElement("td");
		newTd.innerHTML = '불량 사유';
		newTr.appendChild(newTd);
		newTd = document.createElement("td");
		newTd.innerHTML = '불량 수량';
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
				newTd.innerHTML = map.goodslot_qty;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="defective_comment">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="defective_number">';
				newTr.appendChild(newTd);
			});
		}else {
			g.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
</div>
</body>
</html>