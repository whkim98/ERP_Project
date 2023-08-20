<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<select name="ctype">
		<option value="country_name">국가</option>
		<option value="country_code">코드</option>
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
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/ctlistajax";
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