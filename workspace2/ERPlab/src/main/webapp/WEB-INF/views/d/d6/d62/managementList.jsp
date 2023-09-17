 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />

<div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">입출고관리</h1>
      </div>

         
         <div style="overflow: scroll;">
         <input type="hidden" id="com" value="${comcode_code }">
            <table id="procode">
            	<c:if test="${flist != null }">
               		<tr>
						<th>고유코드</th>
						<th>팀</th>
						<th>거래처</th>
						<th>상품명</th>
						<th>금액</th>
						<th>수량</th>
						<th>매출일자</th>
						<th>출고일자</th>
						<th>입고일자</th>
					</tr>
               <c:forEach var="vo" items="${flist }">
				<tr onclick="selectForm(${vo.goodslot_no})" class="filter" id="filter">
			    <td>${vo.forsales_blno}</td>
			    <td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td></td>
			    <td>${vo.forsales_date}</td>
			    <td></td>
				</tr>
				</c:forEach>
				<c:forEach var="vo" items="${ilist }">
				<tr>
				<td>${vo.import_blno }</td>
				<td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td>${vo.import_date}</td>
			    <td></td>
			    <td></td>
				</tr>
				</c:forEach>
				<c:forEach var="vo" items="${llist }">
				<tr>
				<td>${vo.localsales_cino }</td>
				<td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td>${vo.localsales_date}</td>
			    <td></td>
			    <td></td>
				</tr>
				</c:forEach>
				<c:forEach var="vo" items="${slist }">
				<tr>
				<td>${vo.storesales_code }</td>
				<td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td>${vo.storesales_date}</td>
			    <td></td>
			    <td></td>
				</tr>
				</c:forEach>
				<c:forEach var="vo" items="${olist }">
				<tr>
				<td>${vo.online_code }</td>
				<td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td>${vo.online_date}</td>
			    <td></td>
			    <td></td>
				</tr>
				</c:forEach>
				<c:forEach var="vo" items="${plist }">
				<tr>
				<td>${vo.purchase_code }</td>
				<td>${vo.team_name}</td>
			    <td>${vo.client_name}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goods_customerprice}</td>
			    <td>${vo.goods_stockqty}</td>
			    <td></td>
			    <td></td>
			    <td>${vo.purchase_date }</td>
				</tr>
				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
            </c:if>
            </table>
         </div>]
         <%@ include file="/WEB-INF/views/layout/footer.jsp"%>