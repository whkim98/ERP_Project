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
	<select name="cstype">
		<option value="clientsort_name">종류</option>
	</select>
	<input type="text" name="csword" id="csword" onkeyup="csajax(this.value)" onblur="csajax(this.value)">
	<input type="button" onclick="csajax('')" value="전체목록">
	<table id="procode">
		<tr>
			<td>종류</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td>정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.clientsort_no }, '${vo.clientsort_name}')">
					<td>${vo.clientsort_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name){
    	opener.document.getElementById("clientsort_no").value = no;
    	opener.document.getElementById("clientsort_name").value = name;
    	window.close();
    }
	
	function csajax(v){
		var type = document.getElementsByName("cstype")[0].value;
		if(v == ''){
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/cslistajax";
		var param = "csword="+v+"&cstype="+type;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>종류</td><td>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.clientsort_no+", '"+map.clientsort_name+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.clientsort_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td>목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>