<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d2/d22/inputPurchaseAjax";
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
		procode.innerHTML += '<tr><td>매입코드</td><td>담당자</td><td>담당팀</td><td>차변</td><td>대변</td><td>매입일자</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.purchase_no+",'"+map.purchase_code+"')");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.purchase_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.employee1_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.closing_debtor;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.closing_creditor;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.purchase_date;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="6">목록이 없습니다.</td></tr>';
		}
	}
}
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>구매 매입 관리(원부자재)</h1>
		</div>
		<div>
			<div class="inputdivform2">
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="purchase_code" ${param.type == 'purchase_code' ? 'selected' : '' }>코드</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
								<option value="purchase_date" ${param.type == 'purchase_date' ? 'selected' : '' }>매입일자</option>
								<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
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
						<td>매입코드</td>
						<td>담당자</td>
						<td>담당팀</td>
						<td>차변</td>
						<td>대변</td>
						<td>매입일자</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.purchase_no}, '${map.purchase_code }')" class="filter">
						<td>${map.purchase_code }</td>
						<td>${map.employee1_name}</td>
						<td>${map.team_name}</td>
						<td>${map.closing_debtor}</td>
						<td>${map.closing_creditor}</td>
						<td>${map.purchase_date }</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
			<div class="dh_inputalignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d2/d22/addForm?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d2/d22/updateForm" id="content" method="post">
				<input type="hidden" name="purchase_no">
				<input type="hidden" name="purchase_code">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
	
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, code){
	document.getElementsByName("purchase_no")[0].value = no;
	document.getElementsByName("purchase_code")[0].value = code;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
</div>
</body>
</html>