<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<p>목록에 없는 제품은 물류팀에 문의해서 추가해주세요.</p>
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
	
</script>
</body>
</html>