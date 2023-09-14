 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script>
function updateQty(goodsNo, goodslotNo) {
    // 해당 로우의 클래스 이름을 생성
    var stockInput = document.querySelector(`.goods_stockqty-${goodslotNo}`);
    var stock = stockInput.value;
    
    alert(stock);
    
    const url = `${pageContext.request.contextPath}/stock/updateQty?goods_no=${goodsNo}&goodslot_no=${goodslotNo}&goods_stockqty=${stock}`;
    
    // 페이지 이동
    location.href = url;
}


</script>


 <div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">수출관리</h1>
      </div>
      <div class="divform2">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="goods_name" ${param.type == 'goods_name' ? 'selected' : '' }>상품명</option>
                        <option value="goodslot_lot" ${param.type == 'goodslot_lot' ? 'selected' : '' }>로트번호</option>
                     </select>
                  </td>
                  <td>
                     <input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
                     <input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
                  </td>
               </tr>
            </table>
         </div>
         
         <div>
         	<input type="button" value="ADD" onclick="location.href='${pageContext.request.contextPath}/stock/insertForm'">
         </div>
         <br>
         
         <div style="overflow: scroll;">
            <table id="procode">
            	<c:if test="${list != null }">
               		<tr>
						<th>상품명</th>
						<th>로트번호</th>
						<th>유통기한</th>
						<th>소비자가</th>
						<th>재고수량</th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
               <c:forEach var="vo" items="${list }">
			     <tr onclick="selectForm(${vo.goodslot_no})" class="filter" id="filter">
			   		<td>${vo.goods_name }</td>
					<td>${vo.goodslot_lot }</td>
					<td>${vo.goodslot_expiry }</td>
					<td>${vo.goods_customerprice }</td>
					<td><input type="number" name="goods_stockqty" value="${vo.goods_stockqty }" class="goods_stockqty-${vo.goodslot_no}"></td>
					<td><input type="button" value="수량입력" onclick="updateQty(${vo.goods_no }, ${vo.goodslot_no })"></td>
					<td><input type="button" value="UPDATE" onclick="location.href='${pageContext.request.contextPath}/stock/updateForm?goods_no=${vo.goods_no }&goodslot_no=${vo.goodslot_no }'">
					<td><input type="button" value="DELETE" onclick="location.href='${pageContext.request.contextPath}/stock/updateDelete?goods_no=${vo.goods_no }&goodslot_no=${vo.goodslot_no }'">
				</tr>
				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
         <%@ include file="/WEB-INF/views/layout/footer.jsp"%>