<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Country List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="all">전체</option>
		<option value="receivable_cino" ${param.type == 'receivable_cino' ? 'selected' : '' }>코드</option>
		<option value="receivable_collected" ${param.type == 'receivable_collected' ? 'selected' : '' }>종류</option>
		<option value="receivable_expiry" ${param.type == 'receivable_expiry' ? 'selected' : '' }>적요</option>
		<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처</option>
	</select>
	<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')" onblur="surf('', '${comcode_code}')">
	<input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
	<table id="procode">
		<c:if test="${list != null }">
					<tr>
						<td>코드</td>
						<td>금액</td>
						<td>여부</td>
						<td>만기일</td>
					</tr>
					<c:forEach var="map" items="${list }">
					<tr onclick="setParentText(${map.receivable_no},'${map.receivable_cino }','${map.receivable_expiry}',${map.receivable_total },'${map.client_name }')" class="filter">
						<td>${map.receivable_cino }</td>
						<td>${map.receivable_total }</td>
						<td>${map.receivable_collected == 0 ? '미수금' : '수금' }</td>
						<td>${map.receivable_expiry}</td>
					</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == null }">
					<tr><td colspan="4">목록이 비어있습니다</td></tr>
				</c:if>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, cino, exp, total, cname){
    	opener.document.getElementById("receivable_no").value = no;
    	opener.document.getElementById("receivable_cino").value = cino;
    	opener.document.getElementById("receivable_expiry").value = exp;
    	opener.document.getElementById("receivable_total").value = total;
    	opener.document.getElementById("client_name").value = cname;
    	window.close();
    }
	
	function surf(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c22/receivableAjax";
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
			procode.innerHTML += '<tr><td>코드</td><td>금액</td><td>여부</td><td>만기일</td></tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.receivable_no+",'"+map.receivable_cino+"','"+map.receivable_expiry+"',"+map.receivable_total+",'"+map.client_name+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.receivable_cino;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.receivable_total;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.receivable_collected == 0 ? '미수금' : '수금' ;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.receivable_expiry;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>