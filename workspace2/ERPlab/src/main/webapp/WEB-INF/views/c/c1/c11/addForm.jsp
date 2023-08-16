<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<form action="${pageContext.request.contextPath }/domesticsales/bond/insert" method="post">
	<table>
		<tr>
			<td>국가명</td>
			<td>
				<select name="country_no">
			  		<option value="1">미국</option>
			  		<option value="2">캐나다</option>
			  		<option value="3">버진아일랜드(미)</option>
			  		<option value="4">북마리아나제도</option>
			  		<option value="5">괌</option>
			  		<option value="6">아메리칸사모아</option>
			  		<option value="7">푸에르토리코</option>
			  		<option value="8">버뮤다</option>
			  		<option value="9">바하마</option>
			  		<option value="10">바베이도스</option>
			  		<option value="11">앵귈라</option>
			  		<option value="12">바부다</option>
			  		<option value="13">버진아일랜드</option>
			  		<option value="14">케이맨 제도</option>
			  		<option value="15">그레나다</option>
			  		<option value="16">케이커스제도</option>
			  		<option value="17">몬트세렛</option>
			  		<option value="18">신트마르턴</option>
			  		<option value="19">세인트루시아</option>
			  		<option value="20">도미니카 연방</option>
			  		<option value="21">세인트빈센트 그레나딘</option>
			  		<option value="22">도미니카 공화국</option>
			  		<option value="23">트리니다드 토바고</option>
			  		<option value="24">세인트키츠 네비스</option>
			  		<option value="25">일본</option>
			  		<option value="26">대한민국</option>
			  		<option value="27">베트남</option>
			  		<option value="28">조선민주주의인민공화국</option>
			  		<option value="29">홍콩</option>
			  		<option value="30">마카오</option>
			  		<option value="31">캄보디아</option>
			  		<option value="32">라오스</option>
			  		<option value="33">중화인민공화국</option>
			  		<option value="34">방글라데시</option>
			  		<option value="35">중화민국</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>거래처명</td>
			<td><input type="text" name="client_name" id="client_name"></td>
		</tr>
		<tr>
			<td>거래처종류</td>
			<td>
				<select name="clientsort_no">
					<option value="2">매출</option>
					<option value="1">매입</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>사업자등록번호</td>
			<td><input type="text" name="client_registeredno" id="client_registeredno"></td>
		</tr>
		<tr>
			<td>법인등록번호</td>
			<td><input type="text" name="client_corporatedno" id="client_corporatedno"></td>
		</tr>
		<tr>
			<td>대표자명</td>
			<td><input type="text" name="client_representative" id="client_representative"></td>
		</tr>
		<tr>
			<td>사업형태</td>
			<td><input type="text" name="client_businesstype" id="client_businesstype"></td>
		</tr>
		<tr>
			<td>사업장</td>
			<td><input type="text" name="client_addr1" id="client_addr1"><input type="text" name="client_addr2" id="client_addr2"><input type="text" name="client_postal" id="client_postal"></td>
		</tr>
		<tr>
			<td>대표번호</td>
			<td><input type="text" name="client_directno" id="client_directno"></td>
		</tr>
		<tr>
			<td>팩스번호</td>
			<td><input type="text" name="client_fax" id="client_fax"></td>
		</tr>
		<tr>
			<td>세금계산서이메일</td>
			<td><input type="text" name="client_email" id="client_email"></td>
		</tr>
		<tr>
			<td>담당자명</td>
			<td><input type="text" name="client_manager" id="client_manager"></td>
		</tr>
		<tr>
			<td>담당자연락처</td>
			<td><input type="text" name="client_contact" id="client_contact"></td>
		</tr>
		<tr>
			<td><input type="submit" value="입력"></td>
		</tr>
	</table>
	</form>
</div>