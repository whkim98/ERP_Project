<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Purchase List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
		<option value="purchase_code" ${param.type == 'purchase_code' ? 'selected' : '' }>코드</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
		<option value="purchase_date" ${param.type == 'purchase_date' ? 'selected' : '' }>매입일자</option>
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>매입코드</td>
			<td>담당자</td>
			<td>담당팀</td>
			<td>차변</td>
			<td>대변</td>
			<td>매입일자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="6">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.purchase_no }, '${vo.purchase_code}')">
					<td>${vo.purchase_code }</td>
					<td>${vo.employee1_name}</td>
					<td>${vo.team_name}</td>
					<td>${vo.closing_debtor}</td>
					<td>${vo.closing_creditor}</td>
					<td>${vo.purchase_date }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, code){
    	opener.document.getElementById("purchase_no").value = no;
    	opener.document.getElementById("purchase_code").value = code;
    	
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d2/d24/purchaseAjax";
		var param = "word="+v+"&type="+type+"&comcode_code="+code;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>상호</td><td>사업자등록번호</td><td>대표</td><td>형태</td><td>주소</td><td>용도</td><td>업태</td><td>업종</td><td>지점코드</td><td>구분</td><td>';
			if(data != "")
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.purchase_no+", '"+map.purchase_code+"')");
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
</script>
</body>
</html>