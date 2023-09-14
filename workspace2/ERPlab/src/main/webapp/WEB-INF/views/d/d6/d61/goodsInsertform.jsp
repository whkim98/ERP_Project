 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
 
<style>
  th, td {
    padding: 5px; /* 원하는 패딩 크기로 조절하세요 */
    margin: 0; /* 외부 여백 제거 */
  }
</style>

<script>
function surf(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
   var goodslot_price = document.getElementsByName("goodslot_price").value;
   console.log(goodslot_price);
   var url = "${pageContext.request.contextPath}/stock/ajax";   // controller mapping

   console.log(v);
   var param = "comcode_code="+code+"&goodslot_price="+goodslot_price;      // 넘길 데이터
   console.log(param);
   sendRequest(url,param,getlist,"POST");
}
</script>
 
<form action="${pageContext.request.contextPath }/stock/insert" method="POST" id="create">
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<h3>상품 등록 사항</h3>
	
	
	<div class="lotSet">
	<table id="lotTable">
		<tr>
			<th>상품코드</th>
			<td><input type="text" name="goods_code"></td>
			<th>바코드</th>
			<td><input type="text" name="goods_barcode"></td>
			<th>상품명</th>
			<td><input type="text" name="goods_name"></td>
		</tr>
		<tr>
			<th>상품종류</th>
			<td>
				<select name="goodskind_no">
					<c:forEach var="vo" items="${list }">
						<option value="${vo.goodskind_no }">
							${vo.goodskind_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>소비자가</th>
			<td><input type="text" name="goods_customerprice"></td>
			<th>규격</th>
			<td>
				<select name="goodsst_no">
					<c:forEach var="vo" items="${gslist }">
						<option value="${vo.goodsst_no }">
							${vo.goodsst_size }
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th>제조사</th>
			<td>
				<select name="client_no1">
					<c:forEach var="vo" items="${clist }">
						<option value="${vo.client_no }">
							${vo.client_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>책임판매업자</th>
			<td>
				<select name="client_no2">
					<c:forEach var="vo" items="${clist }">
						<option value="${vo.client_no }">
							${vo.client_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>재고수량</th>
			<td><input type="number" name="goods_stockqty" value="0"></td>
		</tr>
		<tr>
			<th>상품재고등급</th>
			<td>
				<select name="goodslev_no">
					<c:forEach var="vo" items="${gllist }">
						<option value="${vo.goodslev_no }">
							${vo.goodslev_grade }: ${vo.goodslev_description }
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th colspan="6">상품설명</th>
		</tr>
		<tr>
			<td colspan="6"><input type="text" name="goods_description" maxlength="500"></td>
		</tr>
		
		<tr>
    		<td colspan="4" style="font-size: 15px; font-weight: bold;">상품로트정보</td>
    		<td><input type="button" value="로트 추가" onclick="addLotRow()"></td>
	    	<td><input type="button" value="로트 추가 취소" onclick="removeLotRow()"></td>
  		</tr>
		
		<tr>
			<th>로트번호</th>
			<td><input type="text" name="goodslot_lot"></td>
			<th>로트별수량</th>
			<td><input type="number" name="goodslot_qty"></td>
			<th>제조일자</th>
			<td><input type="date" name="goodslot_production"></td>
		</tr>
		<tr>
			<th>세액</th>
			<td><input type="number" name="goodslot_tax" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')"></td>
			<th>원가</th>
			<td><input type="number" name="goodslot_price" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')"></td>
			<th>유통기한</th>
			<td><input type="date" name="goodslot_expiry"></td>
		</tr>
	</table>
	</div>
	<div>
	    <input type="submit" value="등록">
  	</div>
                  
</form>

<script>
  let lotIndex = 1; // 로트 정보 행 인덱스
  const maxLotCount = 3; // 최대 로트 정보 개수

  function addLotRow() {
    if (lotIndex < maxLotCount) {
      lotIndex++;
      const table = document.getElementById("lotTable");
      const row1 = table.insertRow(table.rows.length); // 첫 번째 행 추가
      const row2 = table.insertRow(table.rows.length); // 두 번째 행 추가

      // 첫 번째 로트 정보 행 추가
      row1.innerHTML = `
        <th>로트번호</th>
        <td><input type="text" name="goodslot_lot${lotIndex}"></td>
        <th>로트별수량</th>
        <td><input type="number" name="goodslot_qty${lotIndex}"></td>
        <th>제조일자</th>
        <td><input type="date" name="goodslot_production${lotIndex}"></td>
      `;

      // 두 번째 로트 정보 행 추가
      row2.innerHTML = `
        <th>세액</th>
        <td><input type="number" name="goodslot_tax${lotIndex}"></td>
        <th>원가</th>
        <td><input type="number" name="goodslot_price${lotIndex}"></td>
        <th>유통기한</th>
        <td><input type="date" name="goodslot_expiry${lotIndex}"></td>
      `;
    } else {
      alert("최대 3개의 로트 정보까지만 추가 가능합니다.");
    }
  }

  function removeLotRow() {
    if (lotIndex > 1) {
      const table = document.getElementById("lotTable");
      table.deleteRow(table.rows.length - 1); // 마지막 행 삭제
      table.deleteRow(table.rows.length - 1); // 마지막 행 삭제
      lotIndex--;
    } else {
      alert("최소한 한 개의 로트 정보가 필요합니다.");
    }
  }
</script>


 
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>