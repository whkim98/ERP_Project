<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<table>
		<tr>
			<th>CI</th>
			<th>BL</th>
			<th>팀명</th>
			<th>거래처명</th>
			<th>매출일자</th>
			<th>상품명</th>
			<th>바코드</th>
			<th>소비자가</th>
			<th>재고수량</th>
			<th>재고위치</th>
			<th>수량</th>
			<th>단가</th>
			<th>세액</th>
			<th>합계</th>
			<th>거래조건</th>
			<th>결제조건</th>
			<th>결제구분</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.forsales_cino }</td>
			<td>${vo.forsales_blno }</td>
			<td>${vo.team_name }</td>
			<td>${vo.client_name }</td>
			<td>${vo.forsales_date }</td>
			<td>${vo.goods_name }</td>
			<td>${vo.goods_barcode }</td>
			<td>${vo.goods_customerprice }</td>
			<td>${vo.goods_stockqty }</td>
			<td>${vo.goods_location }</td>
			<td>${vo.forsales_qty }</td>
			<td>${vo.forsales_price }</td>
			<td>${vo.forsales_tax }</td>
			<td>${vo.forsales_total }</td>
			<td>${vo.incoterms_name }</td>
			<td>${vo.settletype_condition }</td>
			<td>${vo.settletype_type }</td>
		</c:forEach>
	</table>
	<input type="button" value="추가등록" onclick="location.href='${pageContext.request.contextPath }/internationalsales/export/insertForm'">
</div>