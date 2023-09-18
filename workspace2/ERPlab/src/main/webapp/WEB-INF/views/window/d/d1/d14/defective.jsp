<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP_Defective List</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
</head>
<body>
<div>
	<table>
		<tr>
			<td>생산로트</td>
			<td>상품코드</td>
			<td>바코드</td>
			<td>품명</td>
		</tr>
		<c:if test="${list == null }">
			<td colspan="3">정보가 존재하지 않습니다.</td>
		</c:if>
		<c:forEach var="vo" items="${list }">
				<tr onclick="setParentText(${vo.requestproduct_no }, '${vo.product_code}', '${vo.product_name}')">
					<td>${vo.product_lot }</td>
					<td>${vo.goods_code}</td>
					<td>${vo.goods_barcode }</td>
					<td>${vo.goods_name}</td>
				</tr>
		</c:forEach>
	</table>
</div>

<script type="text/javascript">
	function setParentText(no, code, name){
    	opener.document.getElementById("requestproduct_no").value = no;
    	opener.document.getElementById("product_code").value = code;
    	opener.document.getElementById("product_name").value = name;
    	window.close();
    }
</script>
</body>
</html>