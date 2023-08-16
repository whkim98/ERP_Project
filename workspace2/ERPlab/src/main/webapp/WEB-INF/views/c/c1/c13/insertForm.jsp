<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/internationalsales/export/insert" method="post">
	<table>
		<tr>
			<td>팀명</td>
			<td>
				<select name="team_no">
			  		<option value="3">경영기획팀</option>
			  		<option value="4">전략기획팀</option>
			  		<option value="6">회계팀</option>
			  		<option value="7">재무팀</option>
			  		<option value="8">인사팀</option>
			  		<option value="9">총무팀</option>
			  		<option value="11">해외영업팀</option>
			  		<option value="12">국내영업팀</option>
			  		<option value="13">매장영업팀</option>
			  		<option value="14">영업관리팀</option>
			  		<option value="16">생산팀</option>
			  		<option value="17">구매팀</option>
			  		<option value="18">품질관리팀</option>
			  		<option value="19">물류팀</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>거래처명</td>
			<td>
				<select name="client_no">
					<c:forEach var="vo" items="${list }">
						<option value="${vo.client_no }">${vo.client_name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>매출일자</td>
			<td><input type="text" name="forsales_date"></td>
		</tr>
		<tr>
			<td>상품명, 바코드</td>
			<td>
				<select name="goods_no">
					<c:forEach var="vo" items="${glist }">
						<option value="${vo.goods_no }">${vo.goods_name }, ${vo.goods_barcode }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>수량</td>
			<td><input type="number" name="forsales_qty"></td>
		</tr>
		<tr>
			<td>단가</td>
			<td><input type="number" name="forsales_price"></td>
		</tr>
		<tr>
			<td>세액</td>
			<td><input type="number" name="forsales_tax"></td>
		</tr>
		<tr>
			<td>합계</td>
			<td><input type="number" name="forsales_total"></td>
		</tr>
		<tr>
		 	<td>거래조건</td>
			<td>
				<select name="incoterms_no">
						<option value="1">EWX</option>
						<option value="2">FCA</option>
						<option value="3">FAS</option>
						<option value="4">FOB</option>
						<option value="5">CFR</option>
						<option value="6">CIF</option>
						<option value="7">CPT</option>
						<option value="8">CIP</option>
						<option value="9">DAP</option>
						<option value="10">DPU</option>
						<option value="11">DDP</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>결제조건, 결제구분</td>
			<td>
				<select name="settletype_no">
					<option value="1">선입금, 현금</option>
					<option value="2">선입금, 매출채권</option>
					<option value="3">선입금, 환어음</option>
					<option value="4">선입금, L/C</option>
					<option value="5">선입금, etc</option>
					<option value="6">후입금, 현금</option>
					<option value="7">후입금, 매출채권</option>
					<option value="8">후입금, 환어음</option>
					<option value="9">후입금, L/C</option>
					<option value="10">후입금, etc</option>
					<option value="11">선지급, 현금</option>
					<option value="12">선지급, 매출채권</option>
					<option value="13">선지급, 환어음</option>
					<option value="14">선지급, L/C</option>
					<option value="15">선지급, etc</option>
					<option value="16">후지급, 현금</option>
					<option value="17">후지급, 매출채권</option>
					<option value="18">후지급, 환어음</option>
					<option value="19">후지급, L/C</option>
					<option value="20">후지급, etc</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>