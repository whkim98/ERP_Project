<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<table>
		<tr>
			<th>업종코드</th>
			<th>업태명</th>
			<th>중분류</th>
			<th>세분류</th>
			<th>세세분류</th>
			<th>적용범위 및 기준</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.businesstype_code }</td>
			<td>${vo.businesstype_name }</td>
			<td>${vo.businesstype_biotore }</td>
			<td>${vo.businesstype_ctgr }</td>
			<td>${vo.businesstype_subctgr }</td>
			<td>${vo.businesstype_description }</td>
			<td><input type="button" value="선택" onclick="location.href='${pageContext.request.contextPath }/domesticsales/bond/typeinsert?businesstype_no=${vo.businesstype_no }&client_no=${client_no }'"></td>
		</tr>
		</c:forEach>
	</table>
</div>