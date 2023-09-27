<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_RequestProduct List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="requestproduct_code" ${param.type == 'requestproduct_code' ? 'selected' : '' }>의뢰코드</option>
		<option value="requestproduct_name" ${param.type == 'requestproduct_name' ? 'selected' : '' }>의뢰명</option>
		<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처명</option>
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>의뢰코드</td>
			<td>의뢰명</td>
			<td>거래처</td>
			<td>담당자</td>
		</tr>
		<c:if test="${list != null }">
			<c:forEach var="map" items="${list }">
			<tr onclick="setParentText(${map.requestproduct_no}, '${map.requestproduct_code }')" class="filter">
				<td>${map.requestproduct_code }</td>
				<td>${map.requestproduct_name }</td>
				<td>${map.client_name}</td>
				<td>${map.employee1_name}</td>
			</tr>
			</c:forEach>
		</c:if>
		<c:if test="${list == null }">
			<tr><td colspan="4">목록이 비어있습니다</td></tr>
		</c:if>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("requestproduct_no").value = no;
    	opener.document.getElementById("requestproduct_code").value = name;
    	var url = "${pageContext.request.contextPath }/d/d1/d11/checkRequest";
   		var param = "requestproduct_no="+encodeURIComponent(no);
   		
   		sendRequest(url,param,checkRno,"POST");

    }
	function checkRno(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.responseText;
			if(data != ""){	
				if(data == "생산 가능한 의뢰입니다."){
					opener.document.getElementById("checkRro").innerText = data;
					opener.document.getElementById("checkRro").style.color = "blue";
					opener.document.getElementById("register").disabled = false;
				}else {
					opener.document.getElementById("checkRro").innerText = data;
					opener.document.getElementById("checkRro").style.color = "red";
					opener.document.getElementById("register").disabled = true;
				}
			}
	    	window.close();
		}
	}
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d11/requestproductAjax";
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
			procode.innerHTML += '<tr><td>의뢰코드</td><td>의뢰명</td><td>거래처</td><td>담당자</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.requestproduct_no+",'"+map.requestproduct_code+"')");
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
				});
			}else {
				procode.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>