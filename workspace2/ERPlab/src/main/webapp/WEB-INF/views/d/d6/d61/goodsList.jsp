 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />

<script>
function updateQty(goodsNo, goodslotNo, code) {
    
    alert(goodsNo);
    
    var row = event.target.closest("tr");
    
    var stockInput = row.querySelector('.goodslot_qty');
    
    var stockQty = stockInput.value;
    
    var param = "?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&goodslot_qty=" + stockQty + "&comcode_code=" + code
    
    alert(stockQty)

    const url = `${pageContext.request.contextPath}/stock/updateQty`;
 	location.href = url + param;

}

function updateForm(goodsNo, goodslotNo, code){
	alert(goodsNo);
	var param = "?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&comcode_code=" + code;
	
	const url = `${pageContext.request.contextPath}/stock/updateForm`;
	
	location.href =  url + param;
	
}

function deleteForm(goodsNo, goodslotNo, code){
	var param = "?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&comcode_code=" + code;
	
	const url = `${pageContext.request.contextPath}/stock/delete`;
	
	location.href = url + param;
}

function disposeForm(goodsNo, code){
	var param = "?goods_no=" + goodsNo + "&comcode_code=" + code;
	
	const url = `${pageContext.request.contextPath}/stock/dispose`;
	
	location.href = url + param;
}

function selectForm(no){
	   document.getElementsByName("goodslot_no")[0].value = no;
	   document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}

function surf(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
	   var type = document.getElementsByName("type")[0].value;
	   console.log(type);
	   console.log(code);
	   console.log(v);
	   var url = "${pageContext.request.contextPath}/stock/ajax";   // controller mapping
	   if(v == ''){
	      type = null;
	      v = null;
	   }
	   console.log(v);
	   console.log(url);
	   var param = "comcode_code="+code+"&word="+v+"&type="+type;      // 넘길 데이터
	   console.log(param);
	   sendRequest(url,param,getlist,"POST");
	}
	
function getlist() {
    if (xhr.readyState == 4 && xhr.status == 200) {
        var data = xhr.response;
        let procode = document.getElementById("procode"); // list가 들어갈 테이블 id
        let newTr, newTd;

        procode.innerHTML = ''; // 테이블 비우기
        procode.innerHTML += '<tr><td>상품명</td><td>로트번호</td><td>유통기한</td><td>소비자가</td><td>재고수량</td><td></td><td></td><td></td></tr>';
        
        let co = document.getElementById('com').value;
        
        if (data != "") {
            var data2 = JSON.parse(data);
            data2.forEach(function (map) {
                newTr = document.createElement("tr");
                newTr.setAttribute("onclick", "selectForm(" + map.goodslot_no + ")");
                procode.appendChild(newTr);

                // 상품명
                newTd = document.createElement("td");
                newTd.innerHTML = map.goods_name;
                newTr.appendChild(newTd);

                // 로트번호
                newTd = document.createElement("td");
                newTd.innerHTML = map.goodslot_lot;
                newTr.appendChild(newTd);

                // 유통기한
                newTd = document.createElement("td");
                newTd.innerHTML = map.goodslot_expiry;
                newTr.appendChild(newTd);

                // 소비자가
                newTd = document.createElement("td");
                newTd.innerHTML = map.goods_customerprice;
                newTr.appendChild(newTd);

                // 재고수량 input과 버튼
                newTd = document.createElement("td");

                // input 엘리먼트 생성
                var inputElement = document.createElement("input");
                inputElement.type = "text";
                inputElement.name = "goodslot_qty";
                inputElement.value = map.goodslot_qty;
                inputElement.className = "goodslot_qty";

                // "수량입력" 버튼
                var button1 = document.createElement("input");
                button1.type = "button";
                button1.value = "수량입력";
                button1.onclick = function () {
                    updateQty(map.goods_no, map.goodslot_no, co);
                };

                newTd.appendChild(inputElement);
                newTd.appendChild(button1);
                newTr.appendChild(newTd);

                // "UPDATE" 버튼
                newTd = document.createElement("td");
                var button2 = document.createElement("input");
                button2.type = "button";
                button2.value = "UPDATE";
                button2.onclick = function () {
                	updateForm(map.goods_no, map.goodslot_no, co);
                };
                newTd.appendChild(button2);
                newTr.appendChild(newTd);

                // "DELETE" 버튼
                newTd = document.createElement("td");
                var button3 = document.createElement("input");
                button3.type = "button";
                button3.value = "DELETE";
                button3.onclick = function () {
                    deleteForm(map.goods_no, map.goodslot_no, co);
                };
                newTd.appendChild(button3);
                newTr.appendChild(newTd);
                
                // "폐기처리" 버튼
                newTd = document.createElement("td");
                var button4 = document.createElement("input");
                button4.type = "button";
                button4.value = "폐기처리";
                button4.onclick = function () {
                    disposeForm(map.goods_no, co);
                };
                newTd.appendChild(button4);
                newTr.appendChild(newTd);
            });
        } else {
            procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
        }
    }
}

</script>




 <div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">통합재고관리</h1>
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
         <input type="hidden" id="com" value="${comcode_code }">
            <table id="procode">
            	<c:if test="${list != null }">
               		<tr>
               			<th>로트번호</th>
						<th>상품명</th>
						<th>유통기한</th>
						<th>소비자가</th>
						<th>폐기여부</th>
						<th>로트별수량</th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
               <c:forEach var="vo" items="${list }">
			<tr onclick="selectForm(${vo.goodslot_no})" class="filter" id="filter">
			    <td>${vo.goodslot_lot}</td>
			    <td>${vo.goods_name}</td>
			    <td>${vo.goodslot_expiry}</td>
			    <td>${vo.goods_customerprice}</td>
			    <c:if test="${vo.goodslev_no == 4 }">
			    <td>O</td>
			    </c:if>
			    <c:if test="${vo.goodslev_no != 4 }">
			    <td>X</td>
			    </c:if>
			    <td><input type="number" class="goodslot_qty" name="goodslot_qty" value="${vo.goodslot_qty}"></td>
			    <td><input type="button" value="수량입력" onclick="updateQty(${vo.goods_no}, ${vo.goodslot_no}, '${comcode_code }')"></td>
			    <c:if test="${vo.goodslev_no != 4 }">
			    <td><input type="button" value="폐기처리" onclick="confirmDispose('${vo.goods_no}', '${vo.goodslot_no}', '${comcode_code}')"></td>
			    </c:if>
			    <c:if test="${vo.goodslev_no == 4 }">
			    <td><input type="button" value="폐기취소" onclick="confirmReverseDispose('${vo.goods_no}', '${vo.goodslot_no}', '${comcode_code}')"></td>
			    </c:if>
			    <td><input type="button" value="UPDATE" onclick="location.href='${pageContext.request.contextPath}/stock/updateForm?goods_no=${vo.goods_no}&goodslot_no=${vo.goodslot_no}&goodsst_no=${vo.goodsst_no }&comcode_code=${comcode_code }'"></td>
			    <td><input type="button" value="DELETE" onclick="checkDelete('${vo.goods_no}', '${vo.goodslot_no }', '${comcode_code }')">
			</tr>

				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
         
         <script type="text/javascript">
         function confirmDispose(goodsNo, goodslotNo, comcodeCode) {
             // 확인 대화상자를 표시하고 사용자가 확인을 누르면 이동할 URL을 설정합니다.
             var confirmMessage = "폐기하시겠습니까?";
             if (confirm(confirmMessage)) {
                 var redirectUrl = "${pageContext.request.contextPath}/stock/dispose?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&comcode_code=" + comcodeCode;
                 window.location.href = redirectUrl; // 주어진 URL로 이동합니다.
             }
         }
         
         function confirmReverseDispose(goodsNo, goodslotNo, comcodeCode) {
             // 확인 대화상자를 표시하고 사용자가 확인을 누르면 이동할 URL을 설정합니다.
             var confirmMessage = "폐기취소시 'A: 새제품' 등급으로 돌아갑니다.";
             if (confirm(confirmMessage)) {
                 var redirectUrl = "${pageContext.request.contextPath}/stock/reverseDispose?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&comcode_code=" + comcodeCode;
                 window.location.href = redirectUrl; // 주어진 URL로 이동합니다.
             }
         }
         
         function checkDelete(goodsNo, goodslotNo, comcodeCode){
        	 var confirmMessage = "삭제하시겠습니까?";
        	 if(confirm(confirmMessage)){
        		 var redirectUrl = "${pageContext.request.contextPath}/stock/delete?goods_no=" + goodsNo + "&goodslot_no=" + goodslotNo + "&comcode_code=" + comcodeCode;
        		 window.location.href = redirectUrl;
        	 }
         }
         </script>
         
         <%@ include file="/WEB-INF/views/layout/footer.jsp"%>