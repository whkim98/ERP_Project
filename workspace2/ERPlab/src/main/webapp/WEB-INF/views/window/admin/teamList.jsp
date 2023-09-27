<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Team List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="dept_name" ${param.type == 'dept_name' ? 'selected' : '' }>부서</option>
		<option value="team_code" ${param.type == 'team_code' ? 'selected' : '' }>코드</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>이름</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	
	<table id="procode">
		<tr>
			<td>부서</td>
			<td>팀명</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td colspan="2">정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
			<tr onclick="setParentText(${vo.team_no }, '${vo.team_name }', '${vo.dept_name }')">
				<td>${vo.dept_name}</td>
				<td>${vo.team_name}</td>
			</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("team_no").value = no;
    	opener.document.getElementById("team_name").value = name;
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/a/a4/searchtAjax";
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
			procode.innerHTML += '<tr><td>부서</td><td>팀명</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.team_no+",'"+map.team_name+"','"+map.dept_name+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.dept_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.team_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="2">목록이 없습니다.</td></tr>';
			}
		}
	}
	
	function setParentText(no, name, dname){
    	opener.document.getElementById("team_no").value = no;
    	opener.document.getElementById("team_name").value = name;
    	opener.document.getElementById("dept_name").value = dname;
    	window.close();
    }
</script>
</body>
</html>