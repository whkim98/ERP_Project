<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Goods List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<p>목록에 없는 제품은 물류팀에 문의해서 추가해주세요.</p>
	<select name="btype">
		<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체검색</option>
		<option value="goodslot_lot" ${param.type == 'goodslot_lot' ? 'selected' : '' }>로트번호</option>
		<option value="goods_name" ${param.type == 'goods_name' ? 'selected' : '' }>상품명</option>
		<option value="goods_barcode" ${param.type == 'goods_barcode' ? 'selected' : '' }>바코드</option>
		<option value="goodssort_name" ${param.type == 'goodssort_name' ? 'selected' : '' }>분류</option>
		<option value="goodskind_name" ${param.type == 'goodskind_name' ? 'selected' : '' }>종류</option>
		<option value="goodsst_spec" ${param.type == 'goodsst_spec' ? 'selected' : '' }>사양</option>
		<option value="client_name" ${param.type == 'client_name' ? 'selected' : '' }>제조사</option>
	</select>
	<input type="text" name="bnword" id="bnword" onkeyup="bnajax(this.value, '${comcode_code}')" onblur="bnajax(this.value, '${comcode_code}')">
	<input type="button" onclick="bnajax('', '${comcode_code}')" value="전체목록">
	<table id="procode">
		<tr>
			<td>로트</td>
			<td>바코드</td>
			<td>품명</td>
			<td>제조사</td>
			<td>분류</td>
			<td>종류</td>
			<td>사양</td>
		</tr>
		<c:if test="${list == null }">
			<tr>
				<td colspan="7">상품이 존재하지 않습니다. <br>물류관리에서 상품을 추가해주세요.</td>
			</tr>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText('${i}', '${vo.goods_code}', '${vo.goods_barcode }', '${vo.goods_name }', ${vo.goodskind_no }, ${vo.goodslot_price }, '${vo.goods_description }', ${vo.client_no1 }, ${vo.client_no2 }, '${vo.goodsst_unit }', '${vo.goodsst_spec }', '${vo.goodsst_size }', '${vo.goodsst_package }', ${vo.goodsst_ea }, '${vo.client_name1 }', '${vo.client_name2 }')">
					<td>${vo.goodslot_lot}</td>
					<td>${vo.goods_barcode}</td>
					<td>${vo.goods_name}</td>
					<td>${vo.client_name}</td>
					<td>${vo.goodssort_name}</td>
					<td>${vo.goodskind_name}</td>
					<td>${vo.goodsst_spec}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(h, code, barcode, name, gkno, cprice, dcp, cno1, cno2, unit, spec, size, pcg, ea, cname1, cname2){
    	opener.document.getElementById("crlist["+h+"].goods_code").value = code;
    	opener.document.getElementById("crlist["+h+"].goods_barcode").value = barcode;
    	opener.document.getElementById("crlist["+h+"].goods_name").value = name;
    	opener.document.getElementById("crlist["+h+"].goodskind_no").value = gkno;
    	opener.document.getElementById("crlist["+h+"].goodslot_price").value = cprice;
    	opener.document.getElementById("crlist["+h+"].goods_description").value = dcp;
    	opener.document.getElementById("crlist["+h+"].client_no1").value = cno1;
    	opener.document.getElementById("crlist["+h+"].client_no2").value = cno2;
    	opener.document.getElementById("crlist["+h+"].goodsst_unit").value = unit;
    	opener.document.getElementById("crlist["+h+"].goodsst_spec").value = spec;
    	opener.document.getElementById("crlist["+h+"].goodsst_size").value = size;
    	opener.document.getElementById("crlist["+h+"].goodsst_package").value = pcg;
    	opener.document.getElementById("crlist["+h+"].goodsst_ea").value = ea;
    	opener.document.getElementById("crlist["+h+"].client_name1").value = cname1;
    	opener.document.getElementById("crlist["+h+"].client_name2").value = cname2;
    	opener.document.getElementById("crlist["+h+"].connectrequest_qty").value = '';
    	window.close();
    }
	
	
	function bnajax(v, code){
		var type = document.getElementsByName("btype")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d12/goodsListAjax";
		var param = "bnword="+v+"&btype="+type+"&comcode_code="+code;
		
		sendRequest(url,param,getlist,"POST");
	}
	function getlist(){
		if(xhr.readyState==4 && xhr.status==200) {	
			var data = xhr.response;
			let procode = document.getElementById("procode");
			let newTr = document.createElement("tr");
			let newTd = document.createElement("td");
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td>로트</td><td>바코드</td><td>품명</td><td>제조사</td><td>분류</td><td>종류</td><td>사양</td><tr>';
			if(data != "")
				var data2 = JSON.parse(data);
				data2.forEach(function(map){
					newTr = document.createElement("tr");
					newTr.setAttribute("onclick", "setParentText('${i}','"+map.goods_code+"','"+map.goods_barcode+"','"+map.goods_name+"',"+map.goodskind_no+","+map.goods_customerprice+",'"+map.goods_description+"',"+map.client_no1+","+map.client_no2+",'"+map.goodsst_unit+"','"+map.goodsst_spec+"','"+map.goodsst_size+"','"+map.goodsst_package+"',"+map.goodsst_ea+",'"+map.client_name1+"','"+map.client_name2+"')");
					procode.appendChild(newTr);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goodslot_lot;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goods_barcode;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.goods_name;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML = map.client_name;
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
				procode.innerHTML += '<tr><td colspan="7">목록이 없습니다.</td></tr>';
			}
		}
	
</script>
</body>
</html>