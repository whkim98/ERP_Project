<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d3/d33/inputInventoryAjax";
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
		procode.innerHTML += '<tr><td>지점코드</td><td>지점명</td><td>사업자등록번호</td><td>대표자</td><td>주소지</td><td>상세주소</td><td>재고담당자/직급</td><td>담당팀</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.inventory_no+")");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = map.comptype_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_registeredno;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_representative;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_addr1;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_addr2;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.employee1_name + "/" + map.employee2_position;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="8">목록이 없습니다.</td></tr>';
		}
	}
}
</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>구매 재고 관리(완제품)</h1>
		</div>
		<div>
			<div class="inputdivform2">
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
								<option value="company_addr1" ${param.type == 'company_addr1' ? 'selected' : '' }>주소지</option>
								<option value="comptype_code" ${param.type == 'comptype_code' ? 'selected' : '' }>지점코드</option>
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
						<td>지점코드</td>
						<td>지점명</td>
						<td>사업자등록번호</td>
						<td>대표자</td>
						<td>주소지</td>
						<td>상세주소</td>
						<td>재고담당자/직급</td>
						<td>담당팀</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="selectForm(${map.inventory_no})" class="filter">
						<td>${map.comptype_code }</td>
						<td>${map.company_name }</td>
						<td>${map.company_registeredno }</td>
						<td>${map.company_representative}</td>
						<td>${map.company_addr1}</td>
						<td>${map.company_addr2}</td>
						<td>${map.employee1_name}/${map.employee2_position}</td>
						<td>${map.team_name}</td>
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
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d3/d33/addInventory?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d3/d33/updateForm" id="content" method="post">
				<input type="hidden" name="inventory_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
		
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("inventory_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

</script>
</div>
</body>
</html>