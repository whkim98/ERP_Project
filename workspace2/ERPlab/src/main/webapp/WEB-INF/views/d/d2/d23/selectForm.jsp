<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
<div class="notosanskr">
	<div class="dh_aligncenter">
    	<h1>구매 재고 등록(원부자재)</h1>
    </div>
    
    <div class="warning_box">
		<span class="red bigger">* </span>
		<div class="yellow_box"></div>
		<span class="red">는 필수 입력란입니다.</span>
	</div>
    
    <div>
        <c:if test="${inmap != null }">
        <form action="${pageContext.request.contextPath}/d/d2/d23/update">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="company_no" id="company_no" value="${inmap.company_no }">
        	<input type="hidden" name="inventory_no" id="inventory_no" value="${inmap.inventory_no }">
        	<input type="hidden" name="employee2_no" id="employee2_no" value="${inmap.employee2_no }">
        	<input type="hidden" name="team_no" id="team_no" value="${inmap.team_no }">
        	<input type="hidden" name="inventory_type" id="inventory_type" value="1">
        <table>
        	<tr>
        		<th colspan="6">재고 지점 등록(조회 버튼 클릭 후 해당 지점을 클릭하여 주세요)<input type="button" value="지점조회" onclick="coList('${comcode_code}')"></th>
        		<th colspan="4">재고 담당자<input type="button" value="사원조회" onclick="employee('${comcode_code}')"></th>
        	</tr>
        	<tr>
        		<th>지점명</th>
        		<td><input type="text" name="company_name" id="company_name" value="${inmap.company_name }" readonly="readonly" onclick="coList('${comcode_code}')" class="required"></td>
        		<th>대표</th>
        		<td><input type="text" name="company_representative" id="company_representative" value="${inmap.company_representative }" readonly="readonly"></td>
        		<th>형태</th>
        		<td ><input type="text" name="company_businesstype" id="company_businesstype" value="${inmap.company_businesstype }" readonly="readonly"></td>
        		<th>사원 코드</th>
        		<td><input type="text" name="employee1_code" id="employee1_code" value="${inmap.employee1_code }" readonly="readonly" onclick="employee('${comcode_code}')" class="required"></td>
        		<th>이름</th>
        		<td><input type="text" name="employee1_name" id="employee1_name" value="${inmap.employee1_name }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>주소</th>
        		<td><input type="text" name="company_addr1" id="company_addr1" value="${inmap.company_addr1 }" readonly="readonly"></td>
        		<th>상세주소</th>
        		<td><input type="text" name="company_addr2" id="company_addr2" value="${inmap.company_addr2 }" readonly="readonly"></td>
        		<th>용도</th>
        		<td><input type="text" name="company_use" id="company_use" value="${inmap.company_use }" readonly="readonly"></td>
        		<th>직급</th>
        		<td><input type="text" name="employee2_position" id="employee2_position" value="${inmap.employee2_position }" readonly="readonly"></td>
        		<th>전화번호</th>
        		<td><input type="text" name="employee2_extension" id="employee2_extension" value="${inmap.employee2_extension }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>사업자등록번호</th>
        		<td><input type="text" name="company_registeredno" id="company_registeredno" value="${inmap.company_registeredno }" readonly="readonly"></td>
        		<th>개업일</th>
        		<td><input type="date" name="company_opendate" id="company_opendate" value="${inmap.company_opendate }" readonly="readonly"></td>
        		<th>지점코드</th>
        		<td><input type="text" name="comptype_code" id="comptype_code" value="${inmap.comptype_code }" readonly="readonly"></td>
        		<th>재고 담당팀</th>
        		<td>
	        		<div class="dddd">
	        			<input type="text" name="team_name" id="team_name" value="${inmap.team_name }" onkeyup="team(event, this.value)">
	        			<input type="button" onclick="searcht()" value="조회">
	        		</div>
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
                    <th>제품조회</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>단가</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>재고수량</th>
                    <th>입고수량</th>
                    <th>사용여부</th>
                    <th>가용수량</th>
                    <th>입고일자</th>
                </tr>
                <c:forEach var="i" items="${ilist }" varStatus="status">
                	<tr class="plist">
	                	<td>
		                	<input type="button" onclick="goodsList('${comcode_code}',${status.index })" value="search">
		                </td>
						<td>
							<input type="text" name="crlist1[${status.index }].goods_name" id="crlist1[${status.index }].goods_name" value="${i.goods_name }" readonly="readonly">
							<input type="hidden" name="iclist1[${status.index }].goodslot_no" id="iclist1[${status.index }].goodslot_no" value="${i.goodslot_no }">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goods_code" id="crlist1[${status.index }].goods_code" value="${i.goods_code }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goods_barcode" id="crlist1[${status.index }].goods_barcode" value="${i.goods_barcode }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist1[${status.index }].goodssort_name" id="crlist1[${status.index }].goodssort_name" value="${i.goodssort_name } - ${i.goodskind_name}" readonly="readonly">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goodslot_total" id="crlist1[${status.index }].goodslot_total" value="${i.goodslot_total }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goodsst_unit" id="crlist1[${status.index }].goodsst_unit" value="${i.goodsst_unit }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goodsst_size" id="crlist1[${status.index }].goodsst_size" value="${i.goodsst_size }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist1[${status.index }].client_name1" id="crlist1[${status.index }].client_name1" value="${i.client_name1}" readonly="readonly">
						</td>
						<td>
							<input type="text" name="crlist1[${status.index }].client_name2" id="crlist1[${status.index }].client_name2" value="${i.client_name2}" readonly="readonly">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goodslot_qty" id="crlist1[${status.index }].goodslot_qty" value="${i.goodslot_qty }" readonly="readonly"></td>
						<td><input type="text" maxlength="4" min="0" name="iclist1[${status.index }].invenconnect_qty" id="iclist1[${status.index }].invenconnect_qty" value="${i.invenconnect_qty }" class="required"></td>
						<td>
							<select name="iclist1[${status.index }].invenconnect_usage" id="iclist1[${status.index }].invenconnect_usage" class="required">
								<option value="0" ${i.invenconnect_usage == 0 ? 'selected' : '' }>미사용</option>
								<option value="1" ${i.invenconnect_usage == 1 ? 'selected' : '' }>사용</option>
							</select>
						</td>
						<td><input type="text" maxlength="4" min="0" name="iclist1[${status.index }].invenconnect_availableqty" id="iclist1[${status.index }].invenconnect_availableqty" value="${i.invenconnect_availableqty }" class="required"></td>
						<td><input type="date" name="iclist1[${status.index }].invenconnect_date" id="iclist1[${status.index }].invenconnect_date" value="${i.invenconnect_date }" class="required"></td>
						<td>
							<input type="button" onclick="deleteGoods(${i.invenconnect_no},${i.inventory_no})" value="delete">
						</td>
					</tr>
                </c:forEach>
            </table>
        </div>
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
           <input type="button" value="update" onclick="sub(this.form)">
           <input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/d/d2/d23/delete?inventory_no=${inmap.inventory_no }&comcode_code=${comcode_code }'">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d2/d23/inputInventory?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
	</div>
            
    <div>
        <c:if test="${inmap == null }">
        <form action="${pageContext.request.contextPath}/d/d2/d23/createInventory">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="company_no" id="company_no">
        	<input type="hidden" name="employee2_no" id="employee2_no">
        	<input type="hidden" name="team_no" id="team_no" value="17">
        	<input type="hidden" name="inventory_type" id="inventory_type" value="1">
        	<div>
		        <table>
			       	<tr>
			     		<th colspan="6">재고 지점 등록(조회 버튼 클릭 후 해당 지점을 클릭하여 주세요)<input type="button" value="지점조회" onclick="coList('${comcode_code}')"></th>
			     		<th colspan="4">재고 담당자<input type="button" value="사원조회" onclick="employee('${comcode_code}')"></th>
			     	</tr>
			     	<tr>
			     		<th>지점명</th>
			     		<td><input type="text" name="company_name" id="company_name" readonly="readonly" onclick="coList('${comcode_code}')" class="required"></td>
			     		<th>대표</th>
			     		<td><input type="text" name="company_representative" id="company_representative" readonly="readonly"></td>
			     		<th>형태</th>
			     		<td ><input type="text" name="company_businesstype" id="company_businesstype" readonly="readonly"></td>
			     		<th>사원 코드</th>
			     		<td><input type="text" name="employee1_code" id="employee1_code" readonly="readonly" onclick="employee('${comcode_code}')" class="required"></td>
			     		<th>이름</th>
			     		<td><input type="text" name="employee1_name" id="employee1_name" readonly="readonly"></td>
			     	</tr>
			     	<tr>
			     		<th>주소</th>
			     		<td><input type="text" name="company_addr1" id="company_addr1" readonly="readonly"></td>
			     		<th>상세주소</th>
			     		<td><input type="text" name="company_addr2" id="company_addr2" readonly="readonly"></td>
			     		<th>용도</th>
			     		<td><input type="text" name="company_use" id="company_use" readonly="readonly"></td>
			     		<th>직급</th>
			     		<td><input type="text" name="employee2_position" id="employee2_position" readonly="readonly"></td>
			     		<th>전화번호</th>
			     		<td><input type="text" name="employee2_extension" id="employee2_extension" readonly="readonly"></td>
			     	</tr>
			     	<tr>
			     		<th>사업자등록번호</th>
			     		<td><input type="text" name="company_registeredno" id="company_registeredno" readonly="readonly"></td>
			     		<th>개업일</th>
			     		<td><input type="date" name="company_opendate" id="company_opendate" readonly="readonly"></td>
			     		<th>지점코드</th>
			     		<td><input type="text" name="comptype_code" id="comptype_code" readonly="readonly"></td>
			     		<th>재고 담당팀</th>
			     		<td>
				      		<div class="dddd">
				      			<input type="text" name="team_name" id="team_name" onkeyup="team(event, this.value)">
				      			<input type="button" onclick="searcht()" value="조회">
				      		</div>
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
                	<th>제품조회</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>단가</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>재고수량</th>
                    <th>입고수량</th>
                    <th>사용여부</th>
                    <th>가용수량</th>
                    <th>입고일자</th>
                </tr>
               	<tr id="procode" class="plist">
					<td>
						<input type="button" onclick="goodsList1('${comcode_code}',0)" value="search">
					</td>
					<td>
						<input type="text" name="crlist[0].goods_name" id="crlist[0].goods_name" readonly="readonly">
						<input type="hidden" name="iclist[0].goodslot_no" id="iclist[0].goodslot_no">
					</td>
					<td><input type="text" name="crlist[0].goods_code" id="crlist[0].goods_code" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goods_barcode" id="crlist[0].goods_barcode" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist[0].goodssort_name" id="crlist[0].goodssort_name" readonly="readonly">
					</td>
					<td><input type="text" name="crlist[0].goodslot_total" id="crlist[0].goodslot_total" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_unit" id="crlist[0].goodsst_unit" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_size" id="crlist[0].goodsst_size" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist[0].client_name1" id="crlist[0].client_name1" readonly="readonly">
					</td>
					<td>
						<input type="text" name="crlist[0].client_name2" id="crlist[0].client_name2" readonly="readonly">
					</td>
					<td><input type="text" name="crlist[0].goodslot_qty" id="crlist[0].goodslot_qty" readonly="readonly"></td>
					<td><input type="text" maxlength="4" min="0" name="iclist[0].invenconnect_qty" id="iclist[0].invenconnect_qty" class="required"></td>
					<td>
						<select name="iclist[0].invenconnect_usage" id="iclis[0].invenconnect_usage" class="required">
							<option value="0" selected="selected">미사용</option>
							<option value="1">사용</option>
						</select>
					</td>
					<td><input type="text" maxlength="4" min="0" name="iclist[0].invenconnect_availableqty" id="iclist[0].invenconnect_availableqty" class="required"></td>
					<td><input type="date" name="iclist[0].invenconnect_date" id="iclist[0].invenconnect_date" class="required"></td>
					<td>
						<input type="button" onclick="clearRow(this)" value="delete">
					</td>
				</tr>
            </table>
            
        </div>
           
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 17 || login == 18}">
           <input type="button" value="save" onclick="sub(this.form)">
           <input type="reset" value="reset">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d2/d23/inputInventory?comcode_code=${comcode_code }'">
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

const itemTable = document.getElementById('itemTable');

for(let i = 0; i < itemTable.rows.length; i++){
	if(document.getElementById("iclist["+i+"].invenconnect_date")){
		document.getElementById("iclist["+i+"].invenconnect_date").setAttribute("min", end+"-01-01");
		document.getElementById("iclist["+i+"].invenconnect_date").setAttribute("max", end+"-12-31");
	}
	if(document.getElementById("iclist1["+i+"].invenconnect_date")){
		document.getElementById("iclist1["+i+"].invenconnect_date").setAttribute("min", end+"-01-01");
		document.getElementById("iclist1["+i+"].invenconnect_date").setAttribute("max", end+"-12-31");
	}
}


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
			if(!pat.test(arr.item(13).value)){
				arr.item(13).value = 0;
				alert("숫자만 입력 가능합니다.");
				return;
			}
			if(Number(arr.item(13).value) > Number(arr.item(12).value)){
				arr.item(13).value = 0;
				arr.item(13).focus();
				alert("가용량은 입고량을 초과할 수 없습니다.");
				return;
			}
			if(!pat.test(arr.item(12).value)){
				arr.item(12).value = 0;
				alert("숫자만 입력 가능합니다.");
				return;
			}
		}
	}
	
	if(document.getElementById("company_no").value == "" || document.getElementById("company_name").value == ""){
		f.company_name.focus();
		return;
	}
	if(document.getElementById("employee2_no").value == "" || document.getElementById("employee1_code").value == ""){
		f.employee1_code.focus();
		return;
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



const addRowButton = document.getElementById('addRow');
const deleteRowButton = document.getElementById('deleteRow');

var j = 0;
addRowButton.addEventListener('click', function() {
    if (itemTable.rows.length <= 100) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
       
        for (let i = 0; i < 16; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="button" onclick="goodsList1(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_name" id="crlist['+j+'].goods_name" readonly="readonly"><input type="hidden" name="iclist['+j+'].goodslot_no" id="iclist['+j+'].goodslot_no"></td>';
            } else if (i === 2) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_code" id="crlist['+j+'].goods_code" readonly="readonly"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_barcode" id="crlist['+j+'].goods_barcode" readonly="readonly"></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodssort_name" id="crlist['+j+'].goodssort_name" readonly="readonly"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodslot_total" id="crlist['+j+'].goodslot_total" readonly="readonly"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_unit" id="crlist['+j+'].goodsst_unit" readonly="readonly"></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_size" id="crlist['+j+'].goodsst_size" readonly="readonly"></td>';
            } else if (i === 8){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name1" id="crlist['+j+'].client_name1" readonly="readonly"></td>';
            }  else if (i === 9){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name2" id="crlist['+j+'].client_name2" readonly="readonly"></td>';
            } else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodslot_qty" id="crlist['+j+'].goodslot_qty" readonly="readonly"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" maxlength="4" min="0" name="iclist['+j+'].invenconnect_qty" id="iclist['+j+'].invenconnect_qty" class="required"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><select name="iclist['+j+'].invenconnect_usage" id="iclist['+j+'].invenconnect_usage" class="required"><option value="0" selected="selected">미사용</option><option value="1">사용</option></select></td>';
            } else if (i === 13){
                cells[i].innerHTML = '<td><input type="text" maxlength="4" min="0" name="iclist['+j+'].invenconnect_availableqty" id="iclist['+j+'].invenconnect_availableqty" class="required"></td>';
            } else if (i === 14){
                cells[i].innerHTML = '<td><input type="date" name="iclist['+j+'].invenconnect_date" id="iclist['+j+'].invenconnect_date" class="required"></td>';
            } else {
                cells[i].innerHTML = '<td name="b32-clearRow"><input type="button" onclick="clearRow(this)" value="delete"></td>';
            }
        }

        if(document.getElementById("crlist[0].goods_name")){
       		j += 1;
        }
        
        for(let u = 1; u < itemTable.getElementsByTagName("tr").length; u++){
            itemTable.getElementsByTagName("tr").item(u).setAttribute("class", "plist");
        }
        
        for(let i = 0; i < itemTable.rows.length; i++){
        	if(document.getElementById("iclist["+i+"].invenconnect_date")){
        		document.getElementById("iclist["+i+"].invenconnect_date").setAttribute("min", end+"-01-01");
        		document.getElementById("iclist["+i+"].invenconnect_date").setAttribute("max", end+"-12-31");
        	}
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




var t = 0;
function deleteGoods(ino, pno){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(arr.length == 0){
		alert("상품은 반드시 1개 이상이어야 합니다.");
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d2/d23/deleteGoods";
	var param = "invenconnect_no="+encodeURIComponent(ino)+"&inventory_no="+encodeURIComponent(pno);
	
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
			procode.innerHTML += '<tr><th>품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>단가</th><th>단위</th><th>규격</th><th>제조사</th><th>책임판매업자</th><th>재고수량</th><th>입고수량</th><th>사용여부</th><th>가용수량</th><th>입고일자</th></tr>';
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="goodsList(`${comcode_code}`,'+t+')" value="search">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_name+'" name="crlist1['+t+'].goods_name" id="crlist1['+t+'].goods_name"><input type="hidden" value="'+map.goodslot_no+'" name="iclist1['+t+'].goodslot_no" id="iclist1['+t+'].goodslot_no">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_code+'" name="crlist1['+t+'].goods_code" id="crlist1['+t+'].goods_code">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_barcode+'" name="crlist1['+t+'].goods_barcode" id="crlist1['+t+'].goods_barcode">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="crlist1['+t+'].goodssort_name" id="crlist1['+t+'].goodssort_name" value="'+map.goodssort_name+' - '+map.goodskind_name+'" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_total+'" name="crlist1['+t+'].goodslot_total" id="crlist1['+t+'].goodslot_total">';
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
				newTd.innerHTML = '<input type="text" value="'+map.client_name2+'" name="crlist1['+t+'].client_name2" id="crlist1['+t+'].client_name2">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_qty+'" name="crlist1['+t+'].goodslot_qty" id="crlist1['+t+'].goodslot_qty">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.invenconnect_qty+'" maxlength="4" min="0" name="iclist1['+t+'].invenconnect_qty" id="iclist1['+t+'].invenconnect_qty" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<select name="iclist1['+t+'].invenconnect_usage" id="iclist1['+t+'].invenconnect_usage" class="required"><option value="0" ${'+map.invenconnect_usage == 1 ? "selected" : ""+ '}>미사용</option><option value="1" ${'+map.invenconnect_usage == 1 ? "selected" : ""+ '}>사용</option></select>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.invenconnect_availableqty+'" maxlength="4" min="0" name="iclist1['+t+'].invenconnect_availableqty" id="iclist1['+t+'].invenconnect_availableqty" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="date" value="'+map.invenconnect_date+'" name="iclist1['+t+'].invenconnect_date" id="iclist1['+t+'].invenconnect_date" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="deleteGoods('+map.invenconnect_no+', '+map.inventory_no+')" value="delete">';
				newTr.appendChild(newTd);
				t = Number(t) + 1;
			});
			
			for(let i = 0; i < itemTable.rows.length; i++){
				if(document.getElementById("iclist1["+i+"].invenconnect_date")){
					document.getElementById("iclist1["+i+"].invenconnect_date").setAttribute("min", end+"-01-01");
					document.getElementById("iclist1["+i+"].invenconnect_date").setAttribute("max", end+"-12-31");
				}
			}
			
		}else {
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td colspan="13">목록이 없습니다.</td></tr>';
		}
	}
}

function goodsList(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d23/goodsList?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function goodsList1(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d23/goodsList1?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

function employee(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d23/employee?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

function coList(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d2/d23/coList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
</script>
</div>
</body>
</html>