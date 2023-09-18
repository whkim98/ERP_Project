<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Project List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="project_no" ${param.type == 'project_no' ? 'selected' : '' }>번호</option>
		<option value="project_name" ${param.type == 'project_name' ? 'selected' : '' }>프로젝트</option>
		<option value="project_status" ${param.type == 'project_status' ? 'selected' : '' }>상태</option>
		<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>담당팀</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>프로젝트명</td>
			<td>예산</td>
			<td>내용</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.project_no }, '${vo.project_name}', ${vo.project_budget }, '${vo.project_content }', '${vo.project_start }', '${vo.project_end }')">
					<td>${vo.project_name}</td>
					<td>${vo.project_budget }</td>
					<td>${vo.project_content }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, budget, content, start, end){
    	opener.document.getElementById("project_no").value = no;
    	opener.document.getElementById("project_name").value = name;
    	opener.document.getElementById("project_budget").value = budget;
    	opener.document.getElementById("project_content").value = content;
    	opener.document.getElementById("project_start").value = start;
    	opener.document.getElementById("project_end").value = end;
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/a/a3/a32/prListAjax";
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
			procode.innerHTML += '<tr><td>프로젝트</td><td>예산</td><td>비고</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.project_no+",'"+map.project_name+"',"+map.project_budget+",'"+map.project_content+"','"+map.project_start+"','"+map.project_end+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.project_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.project_budget;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.project_content;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
			}
		}
	}
	
	function sub(f){
		if(document.getElementById("word").value == ""){
			alert("조회 내용을 입력해주세요.");
			document.getElementById("word").focus()
		}else {
			f.submit();
		}
	}
</script>
</body>
</html>