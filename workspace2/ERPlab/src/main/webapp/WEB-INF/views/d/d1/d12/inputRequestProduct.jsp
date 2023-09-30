<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		procode.innerHTML += '<tr><td>코드</td><td>이름</td><td>거래처</td><td>담당자</td><td>시작</td><td>마감</td></tr>';
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
				newTd = document.createElement("td");
				newTd.innerHTML = map.requestproduct_start;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.requestproduct_end;
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
			<h1>생산 의뢰 관리</h1>
		</div>
		<div>
			<div class="inputdivform2">
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
								<option value="employee1_name" ${param.type == 'closing_date' ? 'selected' : '' }>담당자</option>
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
						<td>코드</td>
						<td>의뢰명</td>
						<td>거래처</td>
						<td>담당자</td>
						<td>시작</td>
						<td>마감</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.requestproduct_no})" class="filter">
						<td>${map.requestproduct_code }</td>
						<td>${map.requestproduct_name }</td>
						<td>${map.client_name}</td>
						<td>${map.employee1_name}</td>
						<td>${map.requestproduct_start}</td>
						<td>${map.requestproduct_end}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td colspan="6">목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 17 }">
			<div class="dh_inputalignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d12/addRequestProduct?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d12/updateForm" id="content" method="post">
				<input type="hidden" name="requestproduct_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("requestproduct_no")[0].value = no;
	
	document.getElementById("content").submit();
}


</script>
</div>
</body>
</html>