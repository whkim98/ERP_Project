<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d3/d31/inputOrderAjax";
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
		procode.innerHTML += '<tr><td>발주코드</td><td>신청일</td><td>상태</td><td>승인여부</td><td>담당팀</td><td>거래처</td><td>마감일</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.order_no+",'"+map.order_code+"')");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.order_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.order_odate;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.order_status;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.order_approval;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.order_end;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="6">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
<%-- <c:if test="${login != 1 || login != 17 }">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		location.href="${pageContext.request.contextPath }/index";
	</script>
</c:if> --%>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>발주 관리(완제품)</h1>
		</div>
		<div>
			<div class="inputdivform2">
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all">전체</option>
								<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>코드</option>
								<option value="order_code" ${param.type == 'order_code' ? 'selected' : '' }>생산명</option>
								<option value="company_name" ${param.type == 'company_name' ? 'selected' : '' }>의뢰명</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당자</option>
								<option value="order_odate" ${param.type == 'order_odate' ? 'selected' : '' }>신청일</option>
								<option value="order_end" ${param.type == 'order_end' ? 'selected' : '' }>마감일</option>
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
						<td>발주코드</td>
						<td>신청일</td>
						<td>상태</td>
						<td>승인여부</td>
						<td>담당팀</td>
						<td>거래처</td>
						<td>마감일</td>
					</tr>
					<c:forEach var="map" items="${list }">
						<tr onclick="selectForm(${map.order_no}, '${map.order_code }')" class="filter">
							<td>${map.order_code }</td>
							<td>${map.order_odate }</td>
							<td>${map.order_status}</td>
							<td>${map.order_approval}</td>
							<td>${map.team_name}</td>
							<td>${map.client_name}</td>
							<td>${map.order_end}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 18}">
			<div class="dh_inputalignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d3/d31/addForm?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d3/d31/updateForm" id="content" method="post">
				<input type="hidden" name="order_no">
				<input type="hidden" name="order_code">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
	
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, code){
	document.getElementsByName("order_no")[0].value = no;
	document.getElementsByName("order_code")[0].value = code;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

</script>
</div>
</body>
</html>