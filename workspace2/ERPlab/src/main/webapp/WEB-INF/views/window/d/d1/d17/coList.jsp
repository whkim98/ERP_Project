<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Company List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<select name="type">
		<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체검색</option>
		<option value="company_name" ${param.type == 'company_name' ? 'selected' : '' }>상호</option>
		<option value="company_businesstype" ${param.type == 'company_businesstype' ? 'selected' : '' }>형태</option>
		<option value="company_use" ${param.type == 'company_use' ? 'selected' : '' }>용도</option>
		<option value="businesstype_name" ${param.type == 'businesstype_name' ? 'selected' : '' }>업태</option>
		<option value="businesstype_subctgr" ${param.type == 'businesstype_subctgr' ? 'selected' : '' }>업종</option>
		<option value="comptype_name" ${param.type == 'comptype_name' ? 'selected' : '' }>구분</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>상호</td>
			<td>사업자등록번호</td>
			<td>대표</td>
			<td>형태</td>
			<td>주소</td>
			<td>용도</td>
			<td>업태</td>
			<td>업종</td>
			<td>지점코드</td>
			<td>구분</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td colspan="10">정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.company_no },'${vo.company_name}','${vo.company_representative}', '${vo.company_businesstype }', '${vo.company_addr1 }', '${vo.company_addr2 }', '${vo.company_use }', '${vo.company_registeredno }', '${vo.businesstype_name }', '${vo.businesstype_subctgr }', '${vo.comptype_code }', '${vo.comptype_name }', '${vo.company_opendate }')">
					<td>${vo.company_name}</td>
					<td>${vo.company_registeredno}</td>
					<td>${vo.company_representative}</td>
					<td>${vo.company_businesstype}</td>
					<td>${vo.company_addr1} ${vo.company_addr2 }</td>
					<td>${vo.company_use}</td>
					<td>${vo.businesstype_name}</td>
					<td>${vo.businesstype_subctgr}</td>
					<td>${vo.comptype_code}</td>
					<td>${vo.comptype_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
function setParentText(no,name, rep, bt, addr1, addr2, use, rno, bname, bsub, code, cname, date){
	opener.document.getElementById("company_no").value = no;
	opener.document.getElementById("company_name").value = name;
	opener.document.getElementById("company_representative").value = rep;
	opener.document.getElementById("company_businesstype").value = bt;
	opener.document.getElementById("company_addr1").value = addr1;
	opener.document.getElementById("company_addr2").value = addr2;
	opener.document.getElementById("company_use").value = use;
	opener.document.getElementById("company_registeredno").value = rno;
	opener.document.getElementById("businesstype_name").value = bname;
	opener.document.getElementById("businesstype_subctgr").value = bsub;
	opener.document.getElementById("comptype_code").value = code;
	opener.document.getElementById("comptype_name").value = cname;
	opener.document.getElementById("company_opendate").value = date;
	window.close();
}
	
	function bnajax(v, code){
		var type = document.getElementsByName("type")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d17/coListAjax";
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
			procode.innerHTML += '<tr><td>상호</td><td>사업자등록번호</td><td>대표</td><td>형태</td><td>주소</td><td>용도</td><td>업태</td><td>업종</td><td>지점코드</td><td>구분</td><tr>';
			if(data != "")
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText('"+map.company_name+"','"+map.company_representative+"', '"+map.company_businesstype+"', '"+map.company_addr1+"', '"+map.company_addr2+"', '"+map.company_use+"', '"+map.company_registeredno+"', '"+map.businesstype_name+"', '"+map.businesstype_subctgr+"', '"+map.comptype_code+"', '"+map.comptype_name+"', '"+map.company_opendate+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.company_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.company_registeredno;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.company_businesstype;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.company_addr1 + " " + map.company_addr2;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.company_use;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.businesstype_subctgr;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.comptype_code;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.comptype_name;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="10">목록이 없습니다.</td></tr>';
			}
		}
	
</script>
</body>
</html>