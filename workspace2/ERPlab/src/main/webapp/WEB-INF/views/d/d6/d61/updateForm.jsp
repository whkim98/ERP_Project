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
 
<form action="${pageContext.request.contextPath }/stock/update" method="POST" id="create">
	<input type="hidden" name="comcode_code" value="${comcode_code }">
	<input type="hidden" name="goods_no" value="${goods_no }">
	<input type="hidden" name="goodslot_no" value="${goodslot_no }">
	<h3>상품 등록 사항</h3>
	
	
	<div class="lotSet">
	<table id="lotTable">
		<tr>
			<th>상품코드</th>
			<td><input type="text" name="goods_code" value="${map.goods_code }"></td>
			<th>바코드</th>
			<td><input type="text" name="goods_barcode" value="${map.goods_barcode }"></td>
			<th>상품명</th>
			<td><input type="text" name="goods_name" value="${map.goods_name }"></td>
		</tr>
		<tr>
			<th>상품종류</th>
			<td>
				<select name="goodskind_no">
					<c:forEach var="vo" items="${list }">
						<option value="${vo.goodskind_no }" ${vo.goodskind_no == map.goodskind_no ? 'selected' : "" }>
							${vo.goodskind_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>소비자가</th>
			<td><input type="number" name="goods_customerprice" value="${map.goods_customerprice }"></td>
			<th>규격</th>
			<td>
				<select name="goodsst_no">
					<c:forEach var="vo" items="${gslist }">
						<option value="${vo.goodsst_no }" ${vo.goodsst_no == map.goodsst_no ? 'selected' : "" }>
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
						<option value="${vo.client_no }" ${vo.client_no == map.client_no1 ? 'selected' : "" }>
							${vo.client_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>책임판매업자</th>
			<td>
				<select name="client_no2">
					<c:forEach var="vo" items="${clist }">
						<option value="${vo.client_no }" ${vo.client_no == map.client_no2 ? 'selected' : "" }>
							${vo.client_name }
						</option>
					</c:forEach>
				</select>
			</td>
			<th>재고수량</th>
			<td><input type="number" name="goods_stockqty" value="${map.goods_stockqty }"></td>
		</tr>
		<tr>
			<th>상품재고등급</th>
			<td>
				<select name="goodslev_no">
					<c:forEach var="vo" items="${gllist }">
						<option value="${vo.goodslev_no }" ${vo.goodslev_no == map.goodslev_no ? 'selected' : "" }>
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
			<td colspan="6"><input type="text" name="goods_description" maxlength="500" value="${map.goods_description }"></td>
		</tr>
		
		<tr>
    		<td colspan="4" style="font-size: 15px; font-weight: bold;">상품로트정보</td>
  		</tr>
		
		<tr>
			<th>로트번호</th>
			<td><input type="text" name="goodslot_lot" value="${map.goodslot_lot }"></td>
			<th>로트별수량</th>
			<td><input type="number" name="goodslot_qty" value="${map.goodslot_qty }"></td>
			<th>제조일자</th>
			<td><input type="date" name="goodslot_production" value="${map.goodslot_production }"></td>
		</tr>
		<tr>
			<th>세액</th>
			<td><input type="number" name="goodslot_tax" value="${map.goodslot_tax }"></td>
			<th>원가</th>
			<td><input type="number" name="goodslot_price" value="${map.goodslot_price }"></td>
			<th>유통기한</th>
			<td><input type="date" name="goodslot_expiry" value="${map.goodslot_expiry }"></td>
		</tr>
	</table>
	</div>
	<div>
	    <input type="submit" value="수정">
  	</div>
                  
</form>



 
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>