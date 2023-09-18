<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Employee List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>이름</option>
		<option value="employee2_position" ${param.type == 'employee2_position' ? 'selected' : '' }>직급</option>
		<option value="employee1_code" ${param.type == 'employee1_code' ? 'selected' : '' }>사원코드</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>코드</td>
			<td>이름</td>
			<td>직급</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText('${vo.employee1_name}', ${vo.employee1_no }, '${vo.employee2_position }', '${vo.employee1_phone }')">
					<td>${vo.employee1_code}</td>
					<td>${vo.employee1_name }</td>
					<td>${vo.employee2_position }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(name, no, position, phone){
    	opener.document.getElementById("employee1_name").value = name;
    	opener.document.getElementById("employee1_no").value = no;
    	opener.document.getElementById("employee1_phone").value = phone;
    	opener.document.getElementById("employee2_position").value = position;
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a31/searchempAjax";
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
			procode.innerHTML += '<tr><td>코드</td><td>이름</td><td>직급</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText('"+map.employee1_name+"',"+map.employee1_no+",'"+map.employee2_position+"','"+map.employee1_phone+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.employee1_code;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.employee1_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.employee2_position;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>