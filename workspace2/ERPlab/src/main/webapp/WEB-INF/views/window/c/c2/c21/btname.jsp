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
<form action="${pageContext.request.contextPath}/a/a3/a32/searchcl" method="POST">
	<select name="btype">
		<option value="businesstype_name">업태</option>
	</select>
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="text" name="bnword" id="bnword" onkeyup="bnajax(this.value)" onblur="bnajax(this.value)">
	<input type="button" onclick="sub(this.form)" value="조회">
</form>
	<table>
		<tr>
			<td>업태</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td>정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText('${vo.businesstype_name}')">
					<td>${vo.businesstype_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(name){
    	opener.document.getElementById("businesstype_name").value = name;
    	window.close();
    }
	
	function bnajax(v){
		var type = document.getElementsByName("btype")[0].value;
		if(v == ''){
			v = null;
		}
		var url = "${pageContext.request.contextPath}/a/a4/a41/loanAjax";
		var param = "bnword="+v+"&btype="+type;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			if(data != ""){
				procode.innerHTML = '';
				procode.innerHTML += '<tr><td>업태</td><td>';
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML = '';
				procode.innerHTML += '<tr><td>업태</td><td>';
				procode.innerHTML += '<tr><td>목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>