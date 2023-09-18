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
	<select name="ctype">
		<option value="country_name" ${param.type == 'country_name' ? 'selected' : '' }>국가</option>
		<option value="country_code" ${param.type == 'country_code' ? 'selected' : '' }>코드</option>
	</select>
	<input type="text" name="cword" id="cword" onkeyup="cajax(this.value)" onblur="cajax(this.value)">
	<input type="button" onclick="cajax('')" value="전체목록">
	<table id="procode">
		<tr>
			<td>번호</td>
			<td>코드</td>
			<td>국가</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.country_no }, '${vo.country_name}')">
					<td>${vo.country_num}</td>
					<td>${vo.country_code }</td>
					<td>${vo.country_name }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("country_no").value = no;
    	opener.document.getElementById("country_name").value = name;
    	window.close();
    }
	
	function cajax(v){
		var type = document.getElementsByName("ctype")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/ctlistAjax";
		var param = "cword="+v+"&ctype="+type;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>번호</td><td>코드</td><td>국가</td></tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.country_no+", '"+map.country_name+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.country_num;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.country_code;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.country_name;
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