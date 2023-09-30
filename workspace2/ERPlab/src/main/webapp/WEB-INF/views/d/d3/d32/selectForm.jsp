<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
<div class="notosanskr">
	<div class="dh_aligncenter">
    	<h1>구매 매입 등록(완제품)</h1>
    </div>
    
    <div class="warning_box">
		<span class="red bigger">* </span>
		<div class="yellow_box"></div>
		<span class="red">는 필수 입력란입니다.</span>
	</div>
    
    <div>
        <c:if test="${inmap != null }">
        <form action="${pageContext.request.contextPath}/d/d3/d32/update">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
        	<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }">
        	<input type="hidden" name="employee2_no" id="employee2_no" value="${inmap.employee2_no }">
        	<input type="hidden" name="purchase_no" id="purchase_no" value="${inmap.purchase_no }">
        	<input type="hidden" name="purchase_type" id="purchase_type" value="0">
        	<input type="hidden" name="bs3_no11" id="bs3_no11" value="${cmap.bs3_no1 }">
        	<input type="hidden" name="bs3_no21" id="bs3_no21" value="${cmap.bs3_no2 }">
        	<input type="hidden" name="bs3_no12" id="bs3_no12">
        	<input type="hidden" name="bs3_no22" id="bs3_no22">
        <table>
        	<tr>
        		<th colspan="4">구매 등록</th>
        		<th colspan="3">거래처 정보</th>
        		<th><input type="button" value="조회" onclick="clList('${comcode_code}')"></th>
        		<th colspan="3">매입 담당자</th>
        		<th><input type="button" value="조회" onclick="coList('${comcode_code}')"></th>
        	</tr>
        	<tr>
        		<th>구매코드</th>
        		<td><input type="text" name="purchase_code" id="purchase_code" value="${inmap.purchase_code }" readonly="readonly" class="required"></td>
        		<th>매입 일자</th>
        		<td><input type="date" name="purchase_date" id="purchase_date" value="${inmap.purchase_date }" class="required"></td>
        		<th>거래처</th>
        		<td><input type="text" name="client_name" id="client_name" value="${cl.client_name }" onkeyup="searchcl(event, '${comcode_code}')" class="required"></td>
        		<th>사업자등록번호</th>
        		<td><input type="text" name="client_registeredno" id="client_registeredno" value="${cl.client_registeredno }" readonly="readonly"></td>
        		<th>사원 코드</th>
        		<td><input type="text" name="employee1_code" id="employee1_code" value="${inmap.employee1_code }" readonly="readonly" onclick="employee('${comcode_code}')" class="required"></td>
        		<th>이름</th>
        		<td><input type="text" name="employee1_name" id="employee1_name" value="${inmap.employee1_name }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>매입 내용</th>
        		<td colspan="3" rowspan="2"><input type="text" name="purchase_content" id="purchase_content" value="${inmap.purchase_content }"></td>
        		<th>대표자</th>
        		<td><input type="text" name="client_representative" id="client_representative" value="${cl.client_representative }" readonly="readonly"></td>
        		<th>전화번호</th>
        		<td><input type="text" name="client_directno" id="client_directno" value="${cl.client_directno }" readonly="readonly"></td>
        		<th>직급</th>
        		<td><input type="text" name="employee2_position" id="employee2_position" value="${inmap.employee2_position }" readonly="readonly"></td>
        		<th>전화번호</th>
        		<td><input type="text" name="employee2_extension" id="employee2_extension" value="${inmap.employee2_extension }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>매입 총액</th>
        		<th id="purchase_total">${inmap.purchase_total }</th>
        		<th>업태</th>
        		<td><input type="text" name="businesstype_name" id="businesstype_name1" value="${cl.businesstype_name }" readonly="readonly"></td>
        		<th>업종</th>
        		<td><input type="text" name="businesstype_subctgr" id="businesstype_subctgr1" value="${cl.businesstype_subctgr }" readonly="readonly"></td>
        		<th>팀</th>
        		<td><input type="text" name="team_name1" id="team_name1" value="${inmap.team_name1 }" readonly="readonly"></td>
        		<th></th>
        		<td></td>
        	</tr>
        	<tr class="wwww">
        		<th>담당팀</th>
        		<td>
	        		<div class="dddd">
	        			<input type="text" name="team_name" id="team_name" value="${inmap.team_name }" onkeyup="team(event, this.value)">
	        			<input type="button" onclick="searcht()" value="조회">
	        		</div>
        		</td>
        		<th></th>
        		<td></td>
        		<th>주소</th>
        		<td colspan="3">
	        		<div class="ffff">
	        			<div class="addr">
		        			<input type="text" name="client_addr1" id="client_addr1" value="${inmap.client_addr1 }" readonly="readonly">
		        		</div>
		        		<div class="sssss"> - </div>
		        		<div class="addr">
		        			<input type="text" name="client_addr2" id="client_addr2" value="${inmap.client_addr2 }" readonly="readonly">
	        			</div>
        			</div>
        		</td>
        		<th></th>
        		<td colspan="3">
        		</td>
        	</tr>
        	<tr>
        		<th colspan="2">차변</th>
        		<td colspan="2">
        			<select name="debtor_no" id="debtor_no" onchange="check12()" class="required">
        				<c:forEach var="vo1" items="${dlist }">
        					<option value="${vo1.debtor_no }" id="${vo1.bs3_no }" ${vo1.bs3_no == cmap.bs3_no1 ? 'selected' : '' }>${vo1.bs3_ctgr }</option>
        				</c:forEach>
        			</select>
        		</td>
        		<th colspan="2">대변</th>
        		<td colspan="2">
        			<select name="creditor_no" id="creditor_no" onchange="check22()" class="required">
        				<c:forEach var="vo2" items="${clist }">
        					<option value="${vo2.creditor_no }" id="${vo2.bs3_no }" ${vo2.bs3_no == cmap.bs3_no2 ? 'selected' : '' }>${vo2.bs3_ctgr }</option>
        				</c:forEach>
        			</select>
        		</td>
        	</tr>
         </table>
         
         <div>
         	<p>
               <input type="button" id="addRow" value="행추가">
               <input type="button" id="deleteRow" value="행삭제">
         	</p>
            <table id="itemTable">
                <tr id="itemTableTitle">
                    <th>수량</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>매입 수량</th>
                    <th>단가</th>
                    <th>세액</th>
                    <th>총액</th>
                    <th>품목삭제</th>
                </tr>
                <c:if test="${list != null }">
	                <c:forEach var="i" items="${list }" varStatus="status">
	                	<tr class="plist">
		                	<td>
		                		<input type="button" onclick="goodsList('${comcode_code}',${status.index })" value="search">
		                		<input type="hidden" name="goods_no" id="goods_no" value="${i.goods_no }">
		                	</td>
							<td>
								<input type="text" name="crlist1[${status.index }].goods_name" id="crlist1[${status.index }].goods_name" value="${i.goods_name }" readonly="readonly">
								<input type="hidden" name="plist1[${status.index }].goodslot_no" id="plist1[${status.index }].goodslot_no" value="${i.goodslot_no }" readonly="readonly">
							</td>
							<td><input type="text" name="crlist1[${status.index }].goods_code" id="crlist1[${status.index }].goods_code" value="${i.goods_code }" readonly="readonly"></td>
							<td><input type="text" name="crlist1[${status.index }].goods_barcode" id="crlist1[${status.index }].goods_barcode" value="${i.goods_barcode }" readonly="readonly"></td>
							<td>
								<input type="text" name="crlist1[${status.index }].goodssort_name" id="crlist1[${status.index }].goodssort_name" value="${i.goodssort_name } - ${i.goodskind_name}" readonly="readonly">
							</td>
							<td><input type="text" name="crlist1[${status.index }].goodsst_unit" id="crlist1[${status.index }].goodsst_unit" value="${i.goodsst_unit }" readonly="readonly"></td>
							<td><input type="text" name="crlist1[${status.index }].goodsst_size" id="crlist1[${status.index }].goodsst_size" value="${i.goodsst_size }" readonly="readonly"></td>
							<td>
								<input type="text" name="crlist1[${status.index }].client_name1" id="crlist1[${status.index }].client_name1" value="${i.client_name1}" readonly="readonly">
							</td>
							<td>
								<input type="text" name="crlist1[${status.index }].client_name2" id="crlist1[${status.index }].client_name2" value="${i.client_name2}" readonly="readonly">
							</td>
							<td><input type="text" name="crlist1[${status.index }].goodsst_ea" id="crlist1[${status.index }].goodsst_ea" value="${i.goodsst_ea }" readonly="readonly"></td>
							<td><input type="text" min="0" name="plist1[${status.index }].purchaseconnect_number" id="plist1[${status.index }].purchaseconnect_number" value="${i.purchaseconnect_number }" maxlength="4" class="required"></td>
							<td><input type="text" min="0" name="plist1[${status.index }].purchaseconnect_price" id="plist1[${status.index }].purchaseconnect_price" value="${i.purchaseconnect_price }" onblur="conculator12(${status.index },this.value)" onkeyup="conculator22(${status.index },event, this.value)" class="required"></td>
							<td><input type="text" name="plist1[${status.index }].purchaseconnect_tax" id="plist1[${status.index }].purchaseconnect_tax" value="${i.purchaseconnect_tax }" readonly="readonly"></td>
							<td>
								<input type="text" name="plist1[${status.index }].purchaseconnect_total" id="plist1[${status.index }].purchaseconnect_total" value="${i.purchaseconnect_total }" readonly="readonly">
								<input type="hidden" name="plist1[${status.index }].purchaseconnect_no" id="plist1[${status.index }].purchaseconnect_no" value="${i.purchaseconnect_no }">
							</td>
							<td>
								<input type="button" onclick="deleteGoods(${i.purchaseconnect_no},${i.purchase_no },${i.purchaseconnect_price },${i.purchaseconnect_tax },${i.purchaseconnect_total },'${i.purchase_code }',${i.purchaseconnect_number },${i.goodslot_no },${i.goods_no })" value="delete">
							</td>
						</tr>
	                </c:forEach>
                </c:if>
                <c:if test="${list == null }">
                	<tr><td colspan="15">목록이 없습니다.</td></tr>
                </c:if>
            </table>
        </div>
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 18}">
           <input type="button" value="update" onclick="sub(this.form)">
           <input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/d/d2/d22/delete?purchase_code=${inmap.purchase_code }&purchase_no=${inmap.purchase_no }&comcode_code=${comcode_code }&bs3_no1=${cmap.bs3_no1}&bs3_no2=${cmap.bs3_no2 }'">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d2/d22/inputPurchase?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
	</div>
            
    <div>
        <c:if test="${inmap == null }">
        <form action="${pageContext.request.contextPath}/d/d3/d32/createPurchase">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="team_no" id="team_no" value="17">
        	<input type="hidden" name="client_no" id="client_no" value="1">
        	<input type="hidden" name="employee2_no" id="employee2_no" value="1">
        	<input type="hidden" name="purchase_type" id="purchase_type" value="0">
        	<input type="hidden" name="bs3_no1" id="bs3_no1">
        	<input type="hidden" name="bs3_no2" id="bs3_no2">
        	<div>
	        <table>
        	<tr>
        		<th colspan="4">구매 등록</th>
        		<th colspan="3">거래처 정보</th>
        		<th><input type="button" value="조회" onclick="clList('${comcode_code}')"></th>
        		<th colspan="3">매입 담당자</th>
        		<th><input type="button" value="조회" onclick="employee('${comcode_code}')"></th>
        	</tr>
        	<tr>
        		<th>구매코드</th>
        		<td>
        			<input type="text" name="purchase_code" id="purchase_code" onblur="code(this.value)" class="required">
        			<h6 id="ocode" style="color:red;"></h6>
        		</td>
        		<th>매입 일자</th>
        		<td><input type="date" name="purchase_date" id="purchase_date" class="required"></td>
        		<th>거래처</th>
        		<td><input type="text" name="client_name" id="client_name" onkeyup="searchcl(event, '${comcode_code}')" class="required"></td>
        		<th>사업자등록번호</th>
        		<td><input type="text" name="client_registeredno" id="client_registeredno" readonly="readonly"></td>
        		<th>사원 코드</th>
        		<td><input type="text" name="employee1_code" id="employee1_code" readonly="readonly" onclick="employee('${comcode_code}')"></td>
        		<th>이름</th>
        		<td><input type="text" name="employee1_name" id="employee1_name" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th rowspan="2">매입 내용</th>
        		<td colspan="3" rowspan="2"><input type="text" name="purchase_content" id="purchase_content"></td>
        		<th>대표자</th>
        		<td><input type="text" name="client_representative" id="client_representative" readonly="readonly"></td>
        		<th>전화번호</th>
        		<td><input type="text" name="client_directno" id="client_directno" readonly="readonly"></td>
        		<th>직급</th>
        		<td><input type="text" name="employee2_position" id="employee2_position" readonly="readonly"></td>
        		<th>전화번호</th>
        		<td><input type="text" name="employee2_extension" id="employee2_extension" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>업태</th>
        		<td><input type="text" name="businesstype_name" id="businesstype_name1" readonly="readonly"></td>
        		<th>업종</th>
        		<td><input type="text" name="businesstype_subctgr" id="businesstype_subctgr1" readonly="readonly"></td>
        		<th>팀</th>
        		<td><input type="text" name="team_name1" id="team_name1" readonly="readonly"></td>
        		<th></th>
        		<td></td>
        	</tr>
        	<tr class="wwww">
        		<th>담당팀</th>
        		<td>
	        		<div class="dddd">
	        			<input type="text" name="team_name" id="team_name" onkeyup="team(event, this.value)">
	        			<input type="button" onclick="searcht()" value="조회">
	        		</div>
        		</td>
        		<th></th>
        		<td></td>
        		<th>주소</th>
        		<td colspan="3">
	        		<div class="ffff">
	        			<div class="addr">
		        			<input type="text" name="client_addr1" id="client_addr1" readonly="readonly">
		        		</div>
		        		<div class="sssss"> - </div>
		        		<div class="addr">
		        			<input type="text" name="client_addr2" id="client_addr2" readonly="readonly">
	        			</div>
        			</div>
        		</td>
        		<th></th>
        		<td colspan="3">
        		</td>
        	</tr>
        	<tr>
        		<th colspan="3">차변</th>
        		<td colspan="3">
        			<select name="debtor_no" id="debtor_no" onchange="check1()" class="required">
        				<option value="0">선택</option>
        				<c:forEach var="vo1" items="${dlist }">
        					<option value="${vo1.debtor_no }" id="${vo1.bs3_no }">${vo1.bs3_ctgr }</option>
        				</c:forEach>
        			</select>
        		</td>
        		<th colspan="3">대변</th>
        		<td colspan="3">
        			<select name="creditor_no" id="creditor_no" onchange="check2()" class="required">
        				<option value="0">선택</option>
        				<c:forEach var="vo2" items="${clist }">
        					<option value="${vo2.creditor_no }" id="${vo2.bs3_no }">${vo2.bs3_ctgr }</option>
        				</c:forEach>
        			</select>
        		</td>
        	</tr>
		        </table>
         	</div>
           
        <div>
            <p>
               <input type="button" id="addRow" value="행추가">
               <input type="button" id="deleteRow" value="행삭제">
            </p>
    
            <table id="itemTable">
                <tr id="itemTableTitle">
                	<th>조회</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>매입 수량</th>
                    <th>단가</th>
                    <th>세액</th>
                    <th>총액</th>
                    <th>품목삭제</th>
                </tr>
               	<tr id="procode" class="plist">
					<td>
						<input type="button" onclick="goodsList1('${comcode_code}',0)" value="search">
						<input type="hidden" name="goods_no" id="goods_no">
					</td>
					<td>
						<input type="text" name="crlist[0].goods_name" id="crlist[0].goods_name" readonly="readonly">
						<input type="hidden" name="plist[0].goodslot_no" id="plist[0].goodslot_no">
					</td>
					<td><input type="text" name="crlist[0].goods_code" id="crlist[0].goods_code" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goods_barcode" id="crlist[0].goods_barcode" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodssort_name" id="crlist[0].goodssort_name" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_unit" id="crlist[0].goodsst_unit" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_size" id="crlist[0].goodsst_size" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].client_name1" id="crlist[0].client_name1" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].client_name2" id="crlist[0].client_name2" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_ea" id="crlist[0].goodsst_ea" readonly="readonly"></td>
					<td><input type="text" min="0" name="plist[0].purchaseconnect_number" id="plist[0].purchaseconnect_number" maxlength="4" class="required"></td>
					<td><input type="text" min="0" name="plist[0].purchaseconnect_price" id="plist[0].purchaseconnect_price" onblur="conculator11(0,this.value)" onkeyup="conculator21(0,event, this.value)" class="required"></td>
					<td><input type="text" name="plist[0].purchaseconnect_tax" id="plist[0].purchaseconnect_tax" readonly="readonly"></td>
					<td><input type="text" name="plist[0].purchaseconnect_total" id="plist[0].purchaseconnect_total" readonly="readonly"></td>
					<td>
						<input type="button" onclick="clearRow(this)" value="delete">
					</td>
				</tr>
            </table>
            
        </div>
           
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 18}">
           <input type="button" value="save" id="register" onclick="sub(this.form)" disabled="disabled">
           <input type="reset" value="reset">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d2/d22/inputPurchase?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
var end = new Date(now_utc-timeOff).toISOString().split("-")[0];
document.getElementById("purchase_date").setAttribute("min", end+"-01-01");
document.getElementById("purchase_date").setAttribute("max", end+"-12-31");

var pat = /^[0-9]{0,8}$/;

function sub(f){
	var list = document.getElementById("itemTable");
	var arr = null;
	let tr = list.getElementsByClassName("plist");
	for(let d = 0; d < tr.length; d++){
		arr = tr[d].getElementsByTagName("input");
		for(var b = 0; b < arr.length; b++){
			if(arr[b].value == ""){
				arr[b].focus();
				return;
			}
			if(!pat.test(arr.item(12).value)){
				arr.item(12).value = 0;
				arr.item(13).value = 0;
				arr.item(14).value = 0;
				alert("금액은 100,000,000미만, 숫자만 입력 가능합니다.");
				return;
			}
			if(Number(arr.item(11).value * arr.item(12).value) > 99999999){
				arr.item(14).value = 0;
				arr.item(13).value = 0;
				arr.item(12).value = 0;
				arr.item(11).value = 0;
				alert("한도가 초과됩니다.");
				return;
			}
			if(!pat.test(arr.item(11).value)){
				arr.item(11).value = 0;
				alert("숫자만 입력 가능합니다.");
				return;
			}
		}
	}
	
	if(document.getElementById("employee1_name").value == ""){
		f.employee1_name.focus();
		return;
	}else if(document.getElementById("client_name").value == ""){
		f.client_name.focus();
		return;
	}else if(document.getElementById("debtor_no").value == 0){
		f.debtor_no.focus();
		return;
	}else if(document.getElementById("creditor_no").value == 0){
		f.creditor_no.focus();
		return;
	}
	if(document.getElementById("creditor_no").value == document.getElementById("debtor_no").value){
		alert("계정과목이 같습니다.");
		f.creditor_no.focus();
		return;
	}
	
	if(document.getElementById("purchase_date").value == ""){
		var ch = confirm("구매 일자가 등록되지 않았습니다. 진행하시겠습니까?");
		if(ch){
			document.getElementById("purchase_date").value = today;
		}else {
			return;
		}
	}
	
	var ch = confirm("등록하시겠습니까?");
	if(ch){
		f.submit();
	}else {
		return;
	}
	
}


// <주소 api>
function searchAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddr").value = extraAddr;
            
            } else {
                document.getElementById("company_addr2").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('company_postal').value = data.zonecode;
            document.getElementById("company_addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("company_addr2").focus();
        }
    }).open();
        customInput.style.display = "none";
}


const itemTable = document.getElementById('itemTable');

const addRowButton = document.getElementById('addRow');
const deleteRowButton = document.getElementById('deleteRow');

var j = 0;
addRowButton.addEventListener('click', function() {
    if (itemTable.rows.length <= 100) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
        
        for (let i = 0; i < 15; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="button" onclick="goodsList1(`${comcode_code}`,'+j+')" value="search"><input type="hidden" name="goods_no" id="goods_no"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_name" id="crlist['+j+'].goods_name" readonly="readonly"><input type="hidden" name="plist['+j+'].goodslot_no" id="plist['+j+'].goodslot_no"></td>';
            } else if (i === 2) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_code" id="crlist['+j+'].goods_code" readonly="readonly"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_barcode" id="crlist['+j+'].goods_barcode" readonly="readonly"></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodssort_name" id="crlist['+j+'].goodssort_name" readonly="readonly"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_unit" id="crlist['+j+'].goodsst_unit" readonly="readonly"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_size" id="crlist['+j+'].goodsst_size" readonly="readonly"></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name1" id="crlist['+j+'].client_name1" readonly="readonly"></td>';
            }  else if (i === 8){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name2" id="crlist['+j+'].client_name2" readonly="readonly"></td>';
            } else if (i === 9){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_ea" id="crlist['+j+'].goodsst_ea" readonly="readonly"></td>';
            } else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" min="0" name="plist['+j+'].purchaseconnect_number" id="plist['+j+'].purchaseconnect_number" maxlength="4" class="required"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" min="0" name="plist['+j+'].purchaseconnect_price" id="oclist['+j+'].purchaseconnect_price" onblur="conculator11('+j+',this.value)" onkeyup="conculator21('+j+',event, this.value)" class="required"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="plist['+j+'].purchaseconnect_tax" id="plist['+j+'].purchaseconnect_tax" readonly="readonly"></td>';
            } else if (i === 13){
                cells[i].innerHTML = '<td><input type="text" name="plist['+j+'].purchaseconnect_total" id="plist['+j+'].purchaseconnect_total" readonly="readonly"></td>';
            } else {
                cells[i].innerHTML = '<td><input type="button" onclick="clearRow(this)" value="delete"></td>';
            }
        }
        
        if(document.getElementById("crlist[0].goods_name")){
       		j += 1;
        }
        
        for(let u = 1; u < itemTable.getElementsByTagName("tr").length; u++){
            itemTable.getElementsByTagName("tr").item(u).setAttribute("class", "plist");
        }
        
    } else {
        alert('품목은 최대 100개까지 추가할 수 있습니다.');
    }
    
});


deleteRowButton.addEventListener('click', function() {
    const rows = itemTable.getElementsByTagName('tr');
    
    if (itemTable.rows.length > 2) {
    	if(itemTable.getElementsByClassName("plist").length == itemTable.rows.length-2){
    		return;
    	}else{
    		if(j > 0){
		        itemTable.deleteRow(itemTable.rows.length-1);
		    	j -= 1;
	        }else {
		        itemTable.deleteRow(itemTable.rows.length-1);
				return;
	        }
    	}
    } else {
        alert('품목은 1개 이하로 삭제할 수 없습니다.');
    }
});

function clearRow(button) {     
	const row = button.parentNode.parentNode;
    const inputs = row.querySelectorAll('input[type="text"]');
    for (let i = 0; i < inputs.length; i++) {
        inputs[i].value = '';
    }
}

function employee(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d3/d32/employee?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

var t = 0;
function deleteGoods(ono, odno, price, tax, total, code, qty, glno){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(list.getElementsByTagName("tr").length < 3){
		alert("상품은 반드시 1개 이상이어야 합니다.");
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d3/d32/deleteGoods";
	var param = "purchaseconnect_no="+encodeURIComponent(ono)+"&purchase_no="+encodeURIComponent(odno)+"&purchaseconnect_price="+encodeURIComponent(price)+"&purchaseconnect_tax="+encodeURIComponent(tax)+"&purchaseconnect_total="+encodeURIComponent(total)+"&purchase_code="+encodeURIComponent(code)+"&purchaseconnect_number="+encodeURIComponent(qty)+"&goodslot_no="+encodeURIComponent(glno);
	
	sendRequest(url,param,deleteGoodscheck,"POST");
}
function deleteGoodscheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		let procode = document.getElementById("itemTable");
		let newTr = document.createElement("tr");
		let newTd = document.createElement("td");
		if(data != ""){
			procode.innerHTML = '';
			procode.innerHTML += '<tr><th>품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>단위</th><th>규격</th><th>제조사</th><th>책임판매업자</th><th>매입수량</th><th>단가</th><th>세액</th><th>총액</th></tr>';
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="button" onclick="goodsList(`${comcode_code}`,'+t+')" value="search"><input type="hidden" name="goods_no" id="goods_no" value="'+map.goods_no+'"></td>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.goods_name+'" name="crlist1['+t+'].goods_name" id="crlist1['+t+'].goods_name" readonly="readonly"><input type="hidden" value="'+map.goodslot_no+'" name="plist1['+t+'].goodslot_no" id="plist1['+t+'].goodslot_no"></td>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_code+'" name="crlist1['+t+'].goods_code" id="crlist1['+t+'].goods_code">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_barcode+'" name="crlist1['+t+'].goods_barcode" id="crlist1['+t+'].goods_barcode">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.goodssort_name+' '+map.goodskind_name+'" name="crlist1['+t+'].goodssort_name" id="crlist1['+t+'].goodssort_name" readonly="readonly"></td>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_unit+'" name="crlist1['+t+'].goodsst_unit" id="crlist1['+t+'].goodsst_unit">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_size+'" name="crlist1['+t+'].goodsst_size" id="crlist1['+t+'].goodsst_size">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name1+'" name="crlist1['+t+'].client_name1" id="crlist1['+t+'].client_name1">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name2+'" name="crlist1['+t+'].client_name2" id="crlis1t['+t+'].client_name2">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_ea+'" name="crlist1['+t+'].goodsst_ea" id="crlist1['+t+'].goodsst_ea">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" min="0" name="plist1['+t+'].purchaseconnect_number" id="plist1['+t+'].purchaseconnect_number" value="'+map.purchaseconnect_number+'" maxlength="4" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" min="0" name="plist1['+t+'].purchaseconnect_price" id="plist1['+t+'].purchaseconnect_price" value="'+map.purchaseconnect_price+'" onblur="conculator11('+t+',this.value)" onkeyup="conculator21('+t+',event, this.value)" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="plist1['+t+'].purchaseconnect_tax" id="plist1['+t+'].purchaseconnect_tax" value="'+map.purchaseconnect_tax+'" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="plist1['+t+'].purchaseconnect_total" id="plist1['+t+'].purchaseconnect_total" value="'+map.purchaseconnect_total+'" readonly="readonly"><input type="hidden" name="plist1['+t+'].purchaseconnect_no" id="plist1['+t+'].purchaseconnect_no" value="'+map.purchaseconnect_no+'">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="deleteGoods('+map.purchaseconnect_no+','+map.purchase_no+','+map.purchaseconnect_price+','+map.purchaseconnect_tax+','+map.purchaseconnect_total+',`'+map.purchase_code+'`,'+map.purchaseconnect_number+','+map.goodslot_no+','+map.goods_no+')" value="delete">';
				newTr.appendChild(newTd);
				t = Number(t) + 1;
			});
		}else {
			procode.innerHTML = '';
			procode.innerHTML += '<tr><th>품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>단위</th><th>규격</th><th>제조사</th><th>책임판매업자</th><th>발주수량</th><th>단가</th><th>세액</th><th>총액</th></tr>';
			procode.innerHTML += '<tr><td colspan="13">목록이 없습니다.</td></tr>';
		}
	}
}

function goodsList(code, h){
	let cv = document.getElementById("client_name").value;
	if(cv == ""){
		alert("거래처를 먼저 선택해주세요.");
		document.getElementById("client_name").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/d/d3/d32/goodsList?comcode_code="+code+"&i="+h+"&client_name="+cv, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function goodsList1(code, h){
	let cv = document.getElementById("client_name").value;
	if(cv == ""){
		alert("거래처를 먼저 선택해주세요.");
		document.getElementById("client_name").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/d/d3/d32/goodsList1?comcode_code="+code+"&i="+h+"&client_name="+cv, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d3/d31/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function team(e, name){
	if(e.keyCode == 13){
		if(name == ""){
			alert("팀명을 입력해주세요.");
			document.getElementById("team_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d3/d31/team";
		var param = "team_name=" + encodeURIComponent(name);
		
		sendRequest(url, param, teamname, "POST");
	}
}
function teamname(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("team_name").value = data2.team_name;
			document.getElementById("team_no").value = data2.team_no;
		}else {
			document.getElementById("team_name").value = '';
			alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
		}
	}
}

function searchcl(e, code){
	if(e.keyCode == 13){
		var clname = document.getElementById("client_name").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("client_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d3/d31/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName, "POST");
	}
}
function clName(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);	// ajax로 받아온 데이터를 json으로 변형
			document.getElementById("client_no").value = data2.client_no;
			document.getElementById("client_name").value = data2.client_name;
			document.getElementById("client_registeredno").value = data2.client_registeredno;
	    	document.getElementById("client_representative").value = data2.client_representative;
	    	document.getElementById("client_directno").value = data2.client_directno;
	    	document.getElementById("businesstype_name1").value = data2.businesstype_name;
	    	document.getElementById("businesstype_subctgr1").value = data2.businesstype_subctgr;
	    	document.getElementById("client_addr1").value = data2.client_addr1;
	    	document.getElementById("client_addr2").value = data2.client_addr2;
		}else {
			document.getElementById("client_name").value = '';
			document.getElementById("client_registeredno").value = '';
			document.getElementById("client_representative").value = '';
	    	document.getElementById("client_directno").value = '';
	    	document.getElementById("businesstype_name1").value = '';
	    	document.getElementById("businesstype_subctgr1").value = '';
	    	document.getElementById("client_addr1").value = '';
	    	document.getElementById("client_addr2").value = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}

function conculator11(k,v){
	document.getElementById("plist["+k+"].purchaseconnect_tax").value = Math.round(Number(v) * 0.1);
	let tax = document.getElementById("plist["+k+"].purchaseconnect_tax").value; 
	document.getElementById("plist["+k+"].purchaseconnect_total").value = Math.round(Number(v) + Number(tax));
}
function conculator21(k, e, v){
	if(e.keyCode == 13){
		document.getElementById("plist["+k+"].purchaseconnect_tax").value = Math.round(Number(v) * 0.1);
		let tax = document.getElementById("plist["+k+"].purchaseconnect_tax").value; 
		document.getElementById("plist["+k+"].purchaseconnect_total").value = Math.round(Number(v) + Number(tax));
	}
}

function conculator12(k,v){
	document.getElementById("plist1["+k+"].purchaseconnect_tax").value = Math.round(Number(v) * 0.1);
	let tax = document.getElementById("plist1["+k+"].purchaseconnect_tax").value; 
	document.getElementById("plist1["+k+"].purchaseconnect_total").value = Math.round(Number(v) + Number(tax));
}
function conculator22(k, e, v){
	if(e.keyCode == 13){
		document.getElementById("plist1["+k+"].purchaseconnect_tax").value = Math.round(Number(v) * 0.1);
		let tax = document.getElementById("plist1["+k+"].purchaseconnect_tax").value; 
		document.getElementById("plist1["+k+"].purchaseconnect_total").value = Math.round(Number(v) + Number(tax));
	}
}

function code(v){
	var url = "${pageContext.request.contextPath }/d/d3/d32/getPurchaseCode";
	var param = "purchase_code="+encodeURIComponent(v);
	
	sendRequest(url,param,codecheck,"POST");
}
function codecheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				document.getElementById("ocode").innerText = data;
				document.getElementById("ocode").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("ocode").innerText = data;
				document.getElementById("ocode").style.color = "red";
				document.getElementById("register").disabled = true;
			}
		}
	}
}

//bs3_no 세팅
function check1(){
	let t = document.getElementById("debtor_no");	// debtor_no 불러옴
	let arr = document.querySelectorAll("#debtor_no > option");	// debtor_no의 옵션 태그들 nodelist로 불러옴
	let bs3_no1 = document.getElementById("bs3_no1");	// bs3_no1 불러옴
	arr.forEach(function(e, i, array) {
		if(t.value == e.value){		// 위에서 선언한 debtor_no를 불러온 값과 option태그들의 value값을 for문으로 전부 검사
			bs3_no1.value = e.id;	// value가 같으면 해당 옵션태그의 id를 bs3_no1에 저장
		}					// check 메소드 전부 동일
	});
}
function check2(){
	let t = document.getElementById("creditor_no");
	let arr = document.querySelectorAll("#creditor_no > option");
	let bs3_no2 = document.getElementById("bs3_no2");
	arr.forEach(function(e, i, array) {
		if(t.value == e.value){
			bs3_no2.value = e.id;
		}
	});
}

function check12(){
	let t = document.getElementById("debtor_no");
	let arr = document.querySelectorAll("#debtor_no > option");
	let bs3_no1 = document.getElementById("bs3_no12");
	arr.forEach(function(e, i, array) {
		if(t.value == e.value){
			bs3_no1.value = e.id;
		}
	});
}
function check22(){
	let t = document.getElementById("creditor_no");
	let arr = document.querySelectorAll("#creditor_no > option");
	let bs3_no2 = document.getElementById("bs3_no22");
	arr.forEach(function(e, i, array) {
		if(t.value == e.value){
			bs3_no2.value = e.id;
		}
	});
}

</script>
</div>
</body>
</html>