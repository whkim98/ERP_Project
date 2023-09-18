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
		<option value="employee1_code" ${param.type == 'employee1_code' ? 'selected' : '' }>코드</option>
		<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>이름</option>
		<option value="employee2_position" ${param.type == 'employee2_position' ? 'selected' : '' }>직급</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>팀</option>
		<option value="dept_name" ${param.type == 'dept_name' ? 'selected' : '' }>부서</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>사원코드</td>
			<td>이름</td>
			<td>직급</td>
			<td>팀</td>
			<td>부서</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="5">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.employee2_no }, '${vo.employee1_name}', '${vo.employee2_position}', '${vo.employee1_code }', '${vo.employee2_extension }', '${vo.team_name }')">
					<td>${vo.employee1_code}</td>
					<td>${vo.employee1_name }</td>
					<td>${vo.employee2_position }</td>
					<td>${vo.team_name }</td>
					<td>${vo.dept_name }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, position, code, ext, tname){
    	opener.document.getElementById("employee2_no").value = no;
    	opener.document.getElementById("employee1_name").value = name;
    	opener.document.getElementById("employee2_position").value = position;
    	opener.document.getElementById("employee1_code").value = code;
    	opener.document.getElementById("employee2_extension").value = ext;
    	opener.document.getElementById("team_name1").value = tname;
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d2/d22/employeeAjax";
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
			procode.innerHTML += '<tr><td>사원코드</td><td>이름</td><td>직급</td><td>팀</td><td>부서</td><tr>';
			if(data != "")
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.employee2_no+",'"+map.employee1_name+"', '"+map.employee2_position+"', '"+map.employee1_code+"', '"+map.employee2_extension+"', '"+map.team_name+"')");
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
					newTd = document.createElement("td");
					newTd.innerHTML = map.team_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.dept_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
			}
		}
	
</script>
</body>
</html>