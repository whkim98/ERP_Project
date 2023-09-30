<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/c/c2/c25/localsalesAjax";
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
		procode.innerHTML += '<tr><td>CI Number</td><td>거래처</td><td>담당팀</td><td>결제 조건</td><td>총 메출액</td><td>만기일</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.localsales_no+",'"+map.localsales_cino+"')");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.localsales_cino;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.settletype_condition;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.localsales_total;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.localsales_date;
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
			<h1>매출 현황</h1>
		</div>
		<div>
			<div class="inputdivform2">
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="localsales_cino" ${param.type == 'localsales_cino' ? 'selected' : '' }>CI Number</option>
								<option value="settletype_condition" ${param.type == 'settletype_condition' ? 'selected' : '' }>결제 조건</option>
								<option value="settletype_type" ${param.type == 'settletype_type' ? 'selected' : '' }>결제 구분</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
								<option value="localsales_date" ${param.type == 'localsales_date' ? 'selected' : '' }>날짜</option>
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
			
			<div class="dh_inputoverflow">
				<table id="procode">
				<c:if test="${list != null }">
					<tr>
						<td>CI Number</td>
						<td>거래처</td>
						<td>담당팀</td>
						<td>결제 조건</td>
						<td>총 매출액</td>
						<td>날짜</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.localsales_no}, '${map.localsales_cino }')" class="filter">
						<td>${map.localsales_cino }</td>
						<td>${map.client_name }</td>
						<td>${map.team_name }</td>
						<td>${map.settletype_condition }</td>
						<td>${map.localsales_total }</td>
						<td>${map.localsales_date }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 13 }">
			<div class="dh_inputalignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/c/c2/c25/addForm?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/c/c2/c25/updateForm" id="content" method="post">
				<input type="hidden" name="localsales_no">
				<input type="hidden" name="localsales_cino">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
	
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, cino){
	document.getElementsByName("localsales_no")[0].value = no;
	document.getElementsByName("localsales_cino")[0].value = cino;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>