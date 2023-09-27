<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Product List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="product_code" ${param.type == 'product_code' ? 'selected' : '' }>생산코드</option>
		<option value="product_name" ${param.type == 'product_name' ? 'selected' : '' }>생상명</option>
		<option value="product_lot" ${param.type == 'product_lot' ? 'selected' : '' }>로트번호</option>
		<option value="requestproduct_name" ${param.type == 'requestproduct_name' ? 'selected' : '' }>의뢰명</option>
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>담당자</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>팀</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>생산코드</td>
			<td>생산명</td>
			<td>의뢰명</td>
			<td>담당자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="4">평가할 수 있는 생산목록이 없습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.requestproduct_no }, ${vo.product_no }, '${vo.product_code}', '${vo.product_name}', '${vo.product_lot}')">
					<td>${vo.product_code }</td>
					<td>${vo.product_name }</td>
					<td>${vo.requestproduct_name}</td>
					<td>${vo.employee1_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(rno, no, code, name, lot){
    	opener.document.getElementById("requestproduct_no").value = rno;
    	opener.document.getElementById("product_no").value = no;
    	opener.document.getElementById("product_code").value = code;
    	opener.document.getElementById("product_name").value = name;
    	opener.document.getElementById("product_lot").value = lot;
    	
   		var url = "${pageContext.request.contextPath }/d/d1/d14/checkProduct";
   		var param = "product_no="+encodeURIComponent(no);
   		
   		sendRequest(url,param,checkPno,"POST");

    }
	function checkPno(){
		if(xhr.readyState==4 && xhr.status==200) {
			var data = xhr.responseText;
			if(data != ""){	
				if(data == "평가 가능한 생산입니다."){
					opener.document.getElementById("checkPro").innerText = data;
					opener.document.getElementById("checkPro").style.color = "blue";
					opener.document.getElementById("register").disabled = false;
				}else {
					opener.document.getElementById("checkPro").innerText = data;
					opener.document.getElementById("checkPro").style.color = "red";
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
		var url = "${pageContext.request.contextPath}/d/d1/d14/selectProductAjax";
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
			procode.innerHTML += '<tr><td>생산코드</td><td>생산명</td><td>의뢰명</td><td>담당자</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.requestproduct_no+","+map.product_no+",'"+map.product_code+"','"+map.product_name+"','"+map.product_lot+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.product_code;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.product_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.requestproduct_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.employee1_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="4">평가할 수 있는 생산목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>