<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d1/d15/inputEvAjax";
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
		procode.innerHTML += '<tr><td>생산코드</td><td>생산명</td><td>담당자</td><td>평가일자</td><td>평가상태</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.evaluation_no+","+map.requestproduct_no+","+(map.evaluemng_no == 0 ? 0 : map.evaluemng_no)+")");
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


function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

function team(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("팀명을 입력해주세요.");
			document.getElementById("team_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/a/a4/team";
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
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>작업 실적 관리</h1>
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
			
			<div class="dh_overflow">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>생산코드</td>
						<td>생산명</td>
						<td>담당자</td>
						<td>평가일자</td>
						<td>평가상태</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.evaluation_no}, ${map.requestproduct_no }, ${map.evaluemng_no == 0 ? 0 : map.evaluemng_no })" class="filter">
						<td>${map.product_code }</td>
						<td >${map.product_name}</td>
						<td>${map.employee1_name}</td>
						<td>${map.evaluation_date }</td>
						<td>${map.evaluation_status == 0 ? '미완' : '완료'}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
				
				<c:if test="${login == 1 || login == 2 || login == 17 }">
				<div class="dh_alignright">
					<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d15/add?comcode_code=${comcode_code }'" value="ADD">
				</div>
				</c:if>
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d15/updateForm" id="content" method="post">
				<input type="hidden" name="evaluation_no">
				<input type="hidden" name="requestproduct_no">
				<input type="hidden" name="evaluemng_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
		<div class="divform4">
			<hr class="hr">
		</div>
		
		<div id="add" class="divform3">
			<c:choose>
				<c:when test="${inmap != null }">
					<form action="${pageContext.request.contextPath }/d/d1/d15/update" method="POST" id="update">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="evaluemng_no" id="evaluemng_no" value="${inmap.evaluemng_no }">
						<input type="hidden" name="evaluation_no" id="evaluation_no" value="${inmap.evaluation_no }">
						<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
						
						<div>
							<label>생산코드 </label>
							<input type="text" name="product_code" id="product_code" value="${inmap.product_code }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" value="${inmap.product_name }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>서류상 종료 날짜 </label>
							<input type="date" name="evaluation_paperend" id="evaluation_paperend" value="${inmap.evaluation_paperend }" class="required" readonly="readonly">
						</div>
							
						<div>
							<label>실제 종료 날짜 </label>
							<input type="date" name="evaluation_actualend" id="evaluation_actualend" value="${inmap.evaluation_actualend }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="evaluation_content" id="evaluation_content" value="${inmap.evaluation_content }" readonly="readonly">
						</div>
						
						<div>
							<label>상태 </label>
							<input type="text" name="evaluation_status" id="evaluation_status" value="${inmap.evaluation_status == 1 ? '정상' : '미완' }" readonly="readonly">
						</div><br>
						
						<div>
							<table id="goodsList">
								<tr>
									<td>상품 코드</td>
									<td>바코드</td>
									<td>품명</td>
									<td>재고</td>
									<td>불량 사유</td>
									<td>불량 수량</td>
								</tr>
								<c:forEach var="vo" items="${dlist }">
									<tr>
										<td>${vo.goods_code }</td>
										<td>${vo.goods_barcode }</td>
										<td>${vo.goods_name }</td>
										<td>${vo.goodslot_qty }</td>
										<td>${vo.defective_comment }</td>
										<td>${vo.defective_number }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="employee1_name" id="employee1_name" value="${inmap.employee1_name }" onclick="employee('${comcode_code}')" readonly="readonly">
						</div>	
						
						<div>
							<label>직급 </label>
							<input type="text" name="employee2_position" id="employee2_position" value="${inmap.employee2_position }">
						</div>
						
						<div>
							<label>출고 상태 </label>
							<select name="evaluemng_outstatus" id="evaluemng_outstatus">
								<option value="0" ${inmap.evaluemng_outstatus == 0 ? 'selected' : '' }>출고</option>
								<option value="1" ${inmap.evaluemng_outstatus == 1 ? 'selected' : '' }>미출고</option>
								<option value="2" ${inmap.evaluemng_outstatus == 2 ? 'selected' : '' }>보류</option>
							</select>
						</div>
						
						<div>
							<label>작성일 </label>
							<input type="date" name="evaluemng_date" id="evaluemng_date" value="${inmap.evaluemng_date }">
						</div>
						
						<div>
							<label>담당팀 </label>
							<input type="text" name="team_name" id="team_name" value="${inmap.team_name }" onkeyup="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
						</div>
						
						<c:if test="${login == 1 || login == 2 || login == 17 }">
						<div>
							<input type="button" value="update" onclick="sub(this.form)">
							<input type="button" value="delete" onclick="deletei(${inmap.evaluemng_no }, '${comcode_code }')">
						</div>
						</c:if>
					</form>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath }/d/d1/d15/createEvaluemng" method="POST" id="create">
						<input type="hidden" name="comcode_code" value="${comcode_code }">
						<input type="hidden" name="evaluation_no" id="evaluation_no" value="${imap.evaluation_no }">
						<input type="hidden" name="team_no" id="team_no">
						<div class="warning_box">
							<span class="red bigger">* </span>
							<div class="yellow_box"></div>
							<span class="red">는 필수 입력란입니다.</span>
						</div>
							
						<div>
							<label>생산코드 </label>
							<input type="text" name="product_code" id="product_code" value="${imap.product_code }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>생산명 </label>
							<input type="text" name="product_name" id="product_name" value="${imap.product_name }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>서류상 종료 날짜 </label>
							<input type="date" name="evaluation_paperend" id="evaluation_paperend" value="${imap.evaluation_paperend }" class="required" readonly="readonly">
						</div>
							
						<div>
							<label>실제 종료 날짜 </label>
							<input type="date" name="evaluation_actualend" id="evaluation_actualend" value="${imap.evaluation_actualend }" class="required" readonly="readonly">
						</div>
						
						<div>
							<label>평가 내용 </label>
							<input type="text" name="evaluation_content" id="evaluation_content" value="${imap.evaluation_content }" readonly="readonly">
						</div>
						
						<div>
							<label>상태 </label>
							<input type="text" name="evaluation_status" id="evaluation_status" value="${imap.evaluation_status == 1 ? '정상' : '미완' }" readonly="readonly">
						</div><br>
						
						<div>
							<table id="goodsList">
								<tr>
									<td>상품 코드</td>
									<td>바코드</td>
									<td>품명</td>
									<td>재고</td>
									<td>불량 사유</td>
									<td>불량 수량</td>
								</tr>
								<c:forEach var="vo" items="${dlist }">
									<tr>
										<td>${vo.goods_code }</td>
										<td>${vo.goods_barcode }</td>
										<td>${vo.goods_name }</td>
										<td>${vo.goodslot_qty }</td>
										<td>${vo.defective_comment }</td>
										<td>${vo.defective_number }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<div>
							<label>담당자 </label>
							<input type="text" name="employee1_name" id="employee1_name" value="${imap.employee1_name }" readonly="readonly">
						</div>	
						
						<div>
							<label>직급 </label>
							<input type="text" name="employee2_position" id="employee2_position" value="${imap.employee2_position }" readonly="readonly">
						</div>
						
						<div>
							<label>출고 상태 </label>
							<select name="evaluemng_outstatus" id="evaluemng_outstatus">
								<option value="0">출고</option>
								<option value="1" selected="selected">미출고</option>
								<option value="2">보류</option>
							</select>
						</div>
						
						<div>
							<label>담당팀 </label>
							<input type="text" name="team_name" id="team_name" onkeyup="team(event, this.value)">
							<input type="button" onclick="searcht()" value="조회">
						</div>
						
						<c:if test="${login == 1 || login == 2 || login == 17 }">
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

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no, code){
	location.href='${pageContext.request.contextPath }/d/d1/d15/delete?evaluemng_no='+no+'&comcode_code='+code;
}


// submit 유효성 검사
function sub(f){
	var pat = /^[0-9]{0,8}$/;		// 정규식 > 1의 자리부터 9자리까지가 숫자인지 판단, 0도 입력 가능
	if(f.evaluemng_outstatus.value == ""){
		f.evaluemng_outstatus.focus();
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


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, rno, eno){
	if(eno == undefined){
		eno = 0;
	}
	document.getElementsByName("evaluation_no")[0].value = no;
	document.getElementsByName("requestproduct_no")[0].value = rno;
	document.getElementsByName("evaluemng_no")[0].value = eno;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
</div>
</body>
</html>