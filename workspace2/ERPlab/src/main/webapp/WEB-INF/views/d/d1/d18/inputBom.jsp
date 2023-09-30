<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" charset="UTF-8">
function surf(v, code){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/d/d1/d18/itemListAjaxF";
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
		procode.innerHTML += '<tr><td>상품코드</td><td>바코드</td><td>품명</td><td>단위</td><td>규격</td><td>평균 원가</td><td>등급</td><td>제조사</td><td>책임판매업자</td><td>종류</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.goods_no+")");
				procode.appendChild(newTr);
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
				newTd.innerHTML = map.goodsst_unit;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goodsst_size;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goodslot_total;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goodslev_grade;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name1;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.client_name2;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.goodskind_name;
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="10">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div class="dh_aligncenter">
			<h1>BOM</h1>
		</div>
		<div>
			<div class="inputdivform2">
				<table>
					<tr>
						<td>
							<select name="type">
								<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
								<option value="goods_code" ${param.type == 'goods_code' ? 'selected' : '' }>코드</option>
								<option value="goods_barcode" ${param.type == 'goods_barcode' ? 'selected' : '' }>바코드</option>
								<option value="goods_name" ${param.type == 'goods_name' ? 'selected' : '' }>품명</option>
								<option value="client_name1" ${param.type == 'client_name1' ? 'selected' : '' }>제조사</option>
								<option value="goodskind_name" ${param.type == 'goodskind_name' ? 'selected' : '' }>종류</option>
								<option value="goodslev_grade" ${param.type == 'goodslev_grade' ? 'selected' : '' }>등급</option>
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
						<td>상품코드</td>
						<td>바코드</td>
						<td>품명</td>
						<td>단위</td>
						<td>규격</td>
						<td>평균 원가</td>
						<td>등급</td>
						<td>제조사</td>
						<td>책임판매업자</td>
						<td>종류</td>
					</tr>
					<c:forEach var="map" items="${list }">
						<tr onclick="selectForm(${map.goods_no})" class="filter">
							<td>${map.goods_code }</td>
							<td>${map.goods_barcode }</td>
							<td>${map.goods_name}</td>
							<td>${map.goodsst_unit}</td>
							<td>${map.goodsst_size}</td>
							<td>${map.goodslot_total}</td>
							<td>${map.goodslev_grade}</td>
							<td>${map.client_name1}</td>
							<td>${map.client_name2}</td>
							<td>${map.goodskind_name}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td>목록이 비어있습니다</td></tr>
				</c:if>
				</table>
			</div>
			
			<c:if test="${login == 1 || login == 2 || login == 17 || login == 7 || login == 8}">
			<div class="dh_inputalignright">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d18/addForm?comcode_code=${comcode_code }'" value="ADD">
			</div>
			</c:if>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d18/updateForm" id="content" method="post">
				<input type="hidden" name="goods_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
	
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no, code){
	document.getElementsByName("goods_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}

</script>
</div>
</body>
</html>