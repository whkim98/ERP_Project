<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Client List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="client_no" ${param.type == 'client_no' ? 'selected' : '' }>번호</option>
		<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>거래처명</option>
		<option value="client_manager" ${param.type == 'client_manager' ? 'selected' : '' }>담당자명</option>
		<option value="businesstype_name" ${param.type == 'businesstype_name' ? 'selected' : '' }>업태</option>
		<option value="businesstype_subctgr" ${param.type == 'businesstype_subctgr' ? 'selected' : '' }>종목</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>거래처명</td>
			<td>사업자등록번호</td>
			<td>담당자</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.client_no }, '${vo.client_name}', '${vo.client_registeredno }', '${vo.client_email }', '${vo.country_name }', '${vo.client_representative }', '${vo.businesstype_name }', '${vo.businesstype_subctgr }')">
					<td>${vo.client_name}</td>
					<td>${vo.client_registeredno }</td>
					<td>${vo.client_manager }</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, register, email, ctname, representative, bname, subctgr){
		console.log(no);
    	opener.document.getElementById("client_no").value = no;
    	opener.document.getElementById("client_name").value = name;
    	opener.document.getElementById("client_registeredno").innerText = register;
    	opener.document.getElementById("client_email").innerText = email;
    	opener.document.getElementById("country_name").innerText = ctname;
    	opener.document.getElementById("client_representative").innerText = representative;
    	opener.document.getElementById("businesstype_name").innerText = bname;
    	opener.document.getElementById("businesstype_subctgr").innerText = subctgr;
    	window.close();
    }
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d12/clListAjax";
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
			procode.innerHTML += '<tr><td>거래처</td><td>사업자등록번호</td><td>담당자</td><tr>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.client_no+",'"+map.client_name+"','"+map.client_registeredno+"','"+map.client_email+"','"+map.country_name+"','"+map.client_representative+"','"+map.businesstype_name+"','"+map.businesstype_subctgr+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.client_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.client_registeredno;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.client_manager;
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