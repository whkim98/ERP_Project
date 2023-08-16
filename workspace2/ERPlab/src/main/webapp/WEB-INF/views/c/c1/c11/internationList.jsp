<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<table>
		<tr>
			<th>국가명</th>
			<th>거래처명</th>
			<th>거래처종류</th>
			<th>사업자등록번호</th>
			<th>법인등록번호</th>
			<th>대표자명</th>
			<th>사업형태</th>
			<th>업종코드</th>
			<th>업태명</th>
			<th>중분류</th>
			<th>세세분류명</th>
			<th>사업장</th>
			<th>상세주소</th>
			<th>우편주소</th>
			<th>대표번호</th>
			<th>팩스번호</th>
			<th>세금계산서이메일</th>
			<th>담당자명</th>
			<th>담당자연락처</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.country_name }</td>
			<td>${vo.client_name }</td>
			<td>${vo.clientsort_name }</td>
			<td>${vo.client_registeredno }</td>
			<td>${vo.client_corporatedno }</td>
			<td>${vo.client_representative }</td>
			<td>${vo.client_businesstype }</td>
			<td>${vo.businesstype_code }</td>
			<td>${vo.businesstype_name }</td>
			<td>${vo.businesstype_biotore }</td>
			<td>${vo.businesstype_subctgr }</td>
			<td>${vo.client_addr1 }</td>
			<td>${vo.client_addr2 }</td>
			<td>${vo.client_postal }</td>
			<td>${vo.client_directno }</td>
			<td>${vo.client_fax }</td>
			<td>${vo.client_email }</td>
			<td>${vo.client_manager }</td>
			<td>${vo.client_contact }</td>
			<td><input type="button" value="거래처삭제" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/delete?client_no=${vo.client_no }'"></td>
			<td><input type="button" value="세부항목 관리" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/typeinsertForm?client_no=${vo.client_no }'"></td>
		</tr>
		</c:forEach>
	</table>
	<input type="button" value="추가등록" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/addForm'">
</div>