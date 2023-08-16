<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<table>
		<tr>
			<th>수입채무코드</th>
			<th>거래처이름</th>
			<th>사업형태</th>
			<th>담당자명</th>
			<th>담당자번호</th>
			<th>상품명</th>
			<th>상품가격</th>
			<th>소비자가</th>
			<th>만기일</th>
			<th>채권만기도래일</th>
			<th>지급/미지급 여부</th>
			<c:forEach var="vo" items="${list }">
			<c:if test="${vo.importpay_paid != null}">
			<th>지급완료일자</th>
			</c:if>
			</c:forEach>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.importpay_code }</td>
			<td>${vo.client_name }</td>
			<td>${vo.client_businesstype }</td>
			<td>${vo.client_manager }</td>
			<td>${vo.client_contact }</td>
			<td>${vo.goods_name }</td>
			<td>${vo.goods_price }</td>
			<td>${vo.goods_customerprice }</td>
			<td>${vo.goods_expiry }</td>
			<td>${vo.importpay_expiry }</td>
			<td>
				<c:if test="${vo.importpay_payable == 0 }">
			  		미지급
				</c:if>
				<c:if test="${vo.importpay_payable == 1 }">
					 지급
				</c:if>
			</td>
			<td>
				<c:if test="${vo.importpay_paid != null}">
					${vo.importpay_paid }
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<input type="button" value="추가등록" onclick="location.href='${pageContext.request.contextPath }/internationalsales/export/insertForm'">
</div>