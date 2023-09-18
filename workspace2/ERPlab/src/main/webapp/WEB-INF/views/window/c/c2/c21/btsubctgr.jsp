<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Businesstype List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="btype">
		<option value="businesstype_subctgr" ${param.type == 'businesstype_subctgr' ? 'selected' : '' }>업종</option>
		<option value="businesstype_ctgr" ${param.type == 'businesstype_ctgr' ? 'selected' : '' }>분류</option>
	</select>
	<input type="text" name="bword" id="bword" onkeyup="bsajax(this.value)" onblur="bsajax(this.value)">
	<input type="button" onclick="bsajax('')" value="전체목록">
	<table id="procode">
		<tr>
			<td>업태</td>
			<td>분류</td>
			<td>업종</td>
			<td>설명</td>
		</tr>
		<c:if test="${list == null }">
		<tr>
			<td colspan="4">정보가 존재하지 않습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.businesstype_no }, '${vo.businesstype_subctgr}', '${vo.businesstype_name }')">
					<td>${vo.businesstype_name}</td>
					<td>${vo.businesstype_ctgr}</td>
					<td>${vo.businesstype_subctgr }</td>
					<td>${vo.businesstype_description }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, name2){
    	opener.document.getElementById("businesstype_no").value = no;
    	opener.document.getElementById("businesstype_name").value = name2;
    	opener.document.getElementById("businesstype_subctgr").value = name;
    	window.close();
    }
	
	function bsajax(v){
		var type = document.getElementsByName("btype")[0].value;
		if(v == ''){
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/btsubctgrajax";
		var param = "bword="+v+"&btype="+type;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>업태</td><td>분류</td><td>업종</td><td>설명</td></tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.businesstype_no+", '"+map.businesstype_subctgr+"', '"+map.businesstype_name+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_ctgr;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_subctgr;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_description;
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