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
	margin-left: auto;
	margin-right: auto;
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
	var url = "${pageContext.request.contextPath}/d/d1/d17/piListAjax";
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
		procode.innerHTML += '<tr><td>상호</td><td>사업자등록번호</td><td>대표</td><td>형태</td><td>주소</td><td>용도</td><td>업태</td><td>업종</td><td>지점코드</td><td>구분</td><td>상태</td></tr>';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				newTr.setAttribute("onclick", "selectForm("+map.receivable_no+","+map.bondbills_no+","+map.bs3_no1+","+map.bs3_no2+")");
				procode.appendChild(newTr);
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
				newTd.innerHTML = map.company_businesstype;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_addr1 + " " + map.company_addr2;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.company_use;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.businesstype_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.businesstype_subctgr;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.comptype_code;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.comptype_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = map.proinventory_statue == 0 ? '가용불가' : '가용중';
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '<tr><td colspan="11">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="notosanskr">
		<div align="center">
			<h1 style="font-size: 20pt;">수금</h1>
		</div>
		<div align="center">
			<div>
				<select name="type">
					<option value="all">전체검색</option>
					<option value="company_name">상호</option>
					<option value="company_businesstype">형태</option>
					<option value="company_use">용도</option>
					<option value="businesstype_name">업태</option>
					<option value="businesstype_subctgr">업종</option>
					<option value="comptype_name">구분</option>
				</select>
				<input type="text" name="word" id="word" onkeyup="surf(this.value, '${comcode_code}')" onblur="surf(this.value, '${comcode_code}')">
				<input type="button" onclick="surf('', '${comcode_code}')" value="전체목록">
			</div>
			
			<div style="overflow: scroll;">
				<table id="procode">
					<tr>
						<td>상호</td>
						<td>사업자등록번호</td>
						<td>대표</td>
						<td>형태</td>
						<td>주소</td>
						<td>용도</td>
						<td>업태</td>
						<td>업종</td>
						<td>지점코드</td>
						<td>구분</td>
						<td>상태</td>
					</tr>
					<c:if test="${list == null }">
						<tr>
							<td>정보가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="vo" items="${list }">
						<tr onclick="selectForm(${vo.proinventory_no})" class="filter">
							<td>${vo.company_name}</td>
							<td>${vo.company_registeredno}</td>
							<td>${vo.company_representative}</td>
							<td>${vo.company_businesstype}</td>
							<td>${vo.company_addr1} ${vo.company_addr2 }</td>
							<td>${vo.company_use}</td>
							<td>${vo.businesstype_name}</td>
							<td>${vo.businesstype_subctgr}</td>
							<td>${vo.comptype_code}</td>
							<td>${vo.comptype_name}</td>
							<td>${vo.proinventory_statue == 0 ? '가용불가' : '가용중'}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div align="right">
				<input type="button" onclick="location.href='${pageContext.request.contextPath }/d/d1/d17/add?comcode_code=${comcode_code }'" value="add">
			</div>
	
	<!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->	
			<form action="${pageContext.request.contextPath }/d/d1/d17/updateForm" id="content" method="post">
				<input type="hidden" name="proinventory_no">
				<input type="hidden" name="comcode_code" value="${comcode_code }">
			</form>
		
		</div>
	
</div>
<script type="text/javascript">

// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
	document.getElementsByName("proinventory_no")[0].value = no;
	
	document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
</div>
</body>
</html>