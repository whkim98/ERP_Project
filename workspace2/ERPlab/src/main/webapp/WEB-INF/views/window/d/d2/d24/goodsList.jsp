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
		<option value="goods_name" ${param.type == 'goodslot_lot' ? 'selected' : '' }>로트번호</option>
		<option value="goods_name" ${param.type == 'goods_name' ? 'selected' : '' }>상품명</option>
		<option value="goods_barcode" ${param.type == 'goods_barcode' ? 'selected' : '' }>바코드</option>
		<option value="goodssort_name" ${param.type == 'goodssort_name' ? 'selected' : '' }>분류</option>
		<option value="goodskind_name" ${param.type == 'goodskind_name' ? 'selected' : '' }>종류</option>
		<option value="goodsst_spec" ${param.type == 'goodsst_spec' ? 'selected' : '' }>사양</option>
	</select>
	<input type="text" name="word" id="word" onkeyup="bnajax(this.value, '${comcode_code}',${purchase_no })" onblur="bnajax(this.value, '${comcode_code}',${purchase_no })">
	<input type="button" onclick="bnajax('', '${comcode_code}',${purchase_no })" value="전체목록">
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
				<tr onclick="setParentText(${vo.goodslot_no}, '${vo.goodslot_lot }', '${vo.goods_barcode }', '${vo.goods_name }', ${vo.purchaseconnect_price }, ${vo.purchaseconnect_number }, ${vo.purchaseconnect_no })">
					<td>${vo.goodslot_lot}</td>
					<td>${vo.goods_barcode}</td>
					<td>${vo.goods_name}</td>
					<td>${vo.client_name1}</td>
					<td>${vo.goodssort_name}</td>
					<td>${vo.goodskind_name}</td>
					<td>${vo.goodsst_spec}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, lot, barcode, name, price, qty, pno){
    	opener.document.getElementById("goodslot_no").value = no;
    	opener.document.getElementById("goodslot_lot").value = lot;
    	opener.document.getElementById("goods_barcode").value = barcode;
    	opener.document.getElementById("goods_name").value = name;
    	opener.document.getElementById("purchaseconnect_price").value = price;
    	opener.document.getElementById("purchaseconnect_number").value = qty;
    	opener.document.getElementById("purchaseconnect_no").value = pno;
    	opener.document.getElementById("producttest_lossrate").value = '';
    	opener.document.getElementById("producttest_lossprice").value = '';
    	opener.document.getElementById("producttest_losstax").value = '';
    	opener.document.getElementById("producttest_losstotal").value = '';
    	opener.document.getElementById("producttest_lossqty").value = '';
    	window.close();
    }
	
	function bnajax(v, code,no){
		var type = document.getElementsByName("btype")[0].value;
		if(v == ''){
			type = null;
			v = null;
		}
		var url = "${pageContext.request.contextPath}/d/d2/d24/goodsListAjax";
		var param = "bnword="+v+"&btype="+type+"&comcode_code="+code+"&purchase_no="+no;
		
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
					newTr.setAttribute("onclick", "setParentText("+map.goodslot_no+",'"+map.goodslot_lot+"','"+map.goods_barcode+"','"+map.goods_name+"',"+map.purchaseconnect_price+","+map.purchaseconnect_number+","+map.purchaseconnect_no+")");
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