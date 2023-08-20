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
	<select name="btype">
		<option value="all">전체검색</option>
		<option value="goods_name">상품명</option>
		<option value="goods_barcode">바코드</option>
		<option value="goodssort_name">분류</option>
		<option value="goodskind_name">종류</option>
		<option value="goodsst_spec">사양</option>
	</select>
	<input type="text" name="bnword" id="bnword" onkeyup="bnajax(this.value)" onblur="bnajax(this.value)">
	<input type="button" onclick="bnajax('')" value="전체목록">
	<input type="hidden" value="${i }" id="i">
	<table id="procode">
		<tr>
			<td>바코드</td>
			<td>품명</td>
			<td>분류</td>
			<td>종류</td>
			<td>사양</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td>정보가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.goods_no}, '${vo.goods_name}',${i })">
					<td>${vo.goods_barcode}</td>
					<td>${vo.goods_name}</td>
					<td>${vo.goodssort_name}</td>
					<td>${vo.goodskind_name}</td>
					<td>${vo.goodsst_spec}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, name, i){
    	opener.document.getElementsByName("goods_no")[i].value = no;
    	opener.document.getElementsByName("goods_name")[i].value = name;
    	window.close();
    }
	
	function bnajax(v){
		var type = document.getElementsByName("btype")[0].value;
		if(v == ''){
			v = null;
		}
		var url = "${pageContext.request.contextPath}/c/c2/c21/goodslistajax";
		var param = "bnword="+v+"&btype="+type;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			let i = document.getElementById("i").value;
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>바코드</td><td>품명</td><td>분류</td><td>종류</td><td>사양</td><td>';
			if(data != ""){
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText("+map.goods_no+",'"+map.goods_name+"',"+i+")");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goods_barcode;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goods_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goodssort_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goodskind_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goodsst_spec;
					newTr.appendChild(newTd);
				});
			}else {
				procode.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
			}
		}
	}
</script>
</body>
</html>