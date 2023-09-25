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
			<td><input type="text" id="goods_code" name="goods_code" maxlength="30"></td>
			<th>바코드</th>
			<td><input type="text" id="goods_barcode" name="goods_barcode" maxlength="30"></td>
			<th>상품명</th>
			<td><input type="text" id="goods_name" name="goods_name" maxlength="100"></td>
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
			<td><input type="number" id="goods_customerprice" name="goods_customerprice"></td>
			
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
			<td><input type="number" id="goods_stockqty" name="goods_stockqty" value="0"></td>
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
		<th colspan="6">상품규격</th>
		</tr>
		<tr>
		<th>단위</th>
			<td><input type="text" id="goodsst_unit" name="goodsst_unit"></td>
		<th>상품사양</th>
		<td><input type="text" id="goodsst_spec" name="goodsst_spec"></td>
		<th>상품사이즈</th>
		<td><input type="text" id="goodsst_size" name="goodsst_size" placeholder="ex) 108*70*71"></td>
		</tr>
		<tr>
		<th>포장사이즈</th>
		<td><input type="text" id="goodsst_package" name="goodsst_package" placeholder="ex) 108*70*71"></td>
		<th>상품사입량</th>
		<td><input type="number" id="goodsst_ea" name="goodsst_ea"></td>
		<tr>
			<th colspan="6">상품설명</th>
		</tr>
		<tr>
			<td colspan="6"><input type="text" id="goods_description" name="goods_description" maxlength="500"></td>
		</tr>
		
		<tr>
    		<td colspan="4" style="font-size: 15px; font-weight: bold;">상품로트정보</td>
    		<td><input type="button" value="로트 추가" onclick="addLotRow()"></td>
	    	<td><input type="button" value="로트 추가 취소" onclick="removeLotRow()"></td>
  		</tr>
		
		<tr>
			<th>로트번호</th>
			<td><input type="text" id="goodslot_lot" name="goodslot_lot" maxlength="30"></td>
			<th>로트별수량</th>
			<td><input type="number" id="goodslot_qty" name="goodslot_qty"></td>
			<th>제조일자</th>
			<td><input type="date" name="goodslot_production"></td>
		</tr>
		<tr>
			<th>세액</th>
			<td><input type="number" id="goodslot_tax" name="goodslot_tax" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')"></td>
			<th>원가</th>
			<td><input type="number" id="goodslot_price" name="goodslot_price" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')"></td>
			<th>유통기한</th>
			<td><input type="date" name="goodslot_expiry"></td>
		</tr>
	</table>
	</div>
	<div>
    <input type="button" value="등록" onclick="validateAndSubmit()">
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
        <td><input type="text" id="goodslot_lot"` + lotIndex + ` name="goodslot_lot${lotIndex}"></td>
        <th>로트별수량</th>
        <td><input type="number" id="goodslot_qty${lotIndex}" name="goodslot_qty${lotIndex}"></td>
        <th>제조일자</th>
        <td><input type="date" id="goodslot_production${lotIndex}" name="goodslot_production${lotIndex}"></td>
      `;

      // 두 번째 로트 정보 행 추가
      row2.innerHTML = `
        <th>세액</th>
        <td><input type="number" id="goodslot_tax${lotIndex}" name="goodslot_tax${lotIndex}"></td>
        <th>원가</th>
        <td><input type="number" id="goodslot_price${lotIndex}" name="goodslot_price${lotIndex}"></td>
        <th>유통기한</th>
        <td><input type="date" id="goodslot_expiry${lotIndex}" name="goodslot_expiry${lotIndex}"></td>
      `;
    } else {
      alert("최대 3개의 로트 정보까지만 추가 가능합니다.");
    }
  }

  function removeLotRow() {
    if (lotIndex > 1) {
      const table = document.getElementById("lotTable");
      table.deleteRow(table.rows.length - 1); 
      table.deleteRow(table.rows.length - 1); 
      lotIndex--;
    } else {
      alert("최소한 한 개의 로트 정보가 필요합니다.");
    }
  }

//등록 버튼 클릭 시 실행되는 함수
  function validateAndSubmit() {
	
	const goodsCode = document.getElementById("goods_code").value;
	const goodsBarcode = document.getElementById("goods_barcode").value;
	const goodsName = document.getElementById("goods_name").value;
	const goodsStockqty = document.getElementById("goods_stockqty").value;
	const goodsstUnit = document.getElementById("goodsst_unit").value;
	const goodsstSpec = document.getElementById("goodsst_spec").value;
	const goodsstSize = document.getElementById("goodsst_size").value;
	const goodsstPackage = document.getElementById("goodsst_package").value;
	const goodsstEa = document.getElementById("goodsst_ea").value;
	const goodsCustomerprice = document.getElementById("goods_customerprice").value;
	
	
	
	console.log(goodsCode);
	console.log(goodsBarcode);
	
	if(goodsCode == ""){
		alert("상품코드를 입력해 주세요.");
		document.getElementById('goods_code').focus();
	    return false;
	}else if(goodsBarcode == ""){
		alert("바코드를 입력해 주세요.");
		document.getElementById('goods_barcode').focus();
		return false;
	}else if(goodsName == ""){
		alert("상품명을 입력해 주세요.");
		document.getElementById('goods_name').focus();
		return false;
	}else if(goodsCustomerprice == ""){
		alert("소비자가를 입력해 주세요.");
		document.getElementById("goods_customerprice").focus();
		return false;
	}else if(goodsStockqty <= 0){
		alert("재고수량을 입력해 주세요.")
		document.getElementById('goods_stockqty').focus();
		return false;
	}else if(goodsstUnit == ""){
		alert("단위를 입력해 주세요.");
		document.getElementById('goodsst_unit').focus();
		return false;
	}else if(goodsstSpec == ""){
		alert("상품사양을 입력해 주세요.");
		document.getElementById('goodsst_spec').focus();
		return false;
	}else if(goodsstSize == ""){
		alert("상품사이즈를 입력해 주세요.");
		document.getElementById('goodsst_size').focus();
		return false;
	}else if(goodsstPackage == ""){
		alert("포장사이즈를 입력해 주세요.");
		document.getElementById('goodsst_package').focus();
		return false;
	}else if(goodsstEa == ""){
		alert("상품 사입량을 입력해 주세요.");
		document.getElementById('goodsst_ea').focus();
		return false
	}
	
    let totalLotQty = 0;
    const lotQtyInput = document.getElementsByName("goodslot_qty");
    const goodslotProductionInput = document.getElementsByName("goodslot_production");
    const goodslotExpiryInput = document.getElementsByName("goodslot_expiry");

    var sum = 0;
    for (var h = 0; h < lotQtyInput.length; h++) {
      sum = Number(sum) + Number(lotQtyInput[h].value);
    }

    const stockQtyInput = document.getElementById("goods_stockqty");
    const stockQtyValue = parseInt(stockQtyInput.value) || 0;

    if (sum !== stockQtyValue) {
      alert("재고수량과 로트별수량의 합이 일치해야 합니다.");
      if (lotIndex >= 1) {
        const firstLotQtyInput = document.getElementById(`goodslot_qty1`);
        firstLotQtyInput.focus();
      }
      return false;
    }

    // 제조일자와 유통기한 비교
    for (var i = 0; i < lotQtyInput.length; i++) {
      const productionDate = new Date(goodslotProductionInput[i].value);
      const expiryDate = new Date(goodslotExpiryInput[i].value);

      if (expiryDate < productionDate) {
        alert("유통기한이 제조일자보다 빠릅니다. 유통기한을 다시 입력해 주세요.");
        goodslotExpiryInput[i].focus();
        return false;
      }
    }

    document.getElementById("create").submit();
  }


</script>




 
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>