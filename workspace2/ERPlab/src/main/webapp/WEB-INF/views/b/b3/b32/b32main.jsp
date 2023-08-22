<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style>
	/* input type="number"일 떄 위/아래 화살표 버튼 제거*/
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    input[type="number"] {
        -moz-appearance: textfield; /* Firefox */
    }
</style>

<div class="taxinvoice-container">
    <h1>전자세금계산서</h1>
    
    <div class="taxinvoice-category">
        <input type="button" id="invoiceNormal" value="세금계산서(영세율포함)">
        <input type="button" id="invoiceFree" value="계산서(면세)">
    </div>
    <br>
        
    <div class="taxinvoice-upper">
        <table class="taxinvoice-type">
            <tr>
                <th>* 종류</th>
                <td>
                    <input type="radio" name="invoiceType" id="invoice-normal" value="normal">
                    <label for="invoice-normal">일반</label>
                
                    <input type="radio" name="invoiceType" id="invoice-zero" value="zero">
                    <label for="invoice-zero">영세율</label>
                
                    <input type="radio" name="invoiceType" id="invoicee-consign" value="consign">
                    <label for="invoicee-consign">위수탁</label>
                
                    <input type="radio" name="invoiceType" id="invoice-consignZero" value="consignZero">
                    <label for="invoice-consignZero">위수탁영세율</label>
                    
                    <button type="button" onclick="invoiceSelect()">선택</button>
                </td>
                
                <th>* 공급받는자구분</th>
                <td>
                    <input type="radio" name="receiverType" id="receiver-businessNum" value="businessNum">
                    <label for="receiver-businessNum">사업자등록번호</label>
                
                    <input type="radio" name="receiverType" id="receiver-personalNum" value="personalNum">
                    <label for="receiver-personalNum">주민등록번호</label>
                
                    <input type="radio" name="receiverType" id="receiver-foreigner" value="foreigner">
                    <label for="receiver-foreigner">외국인</label>
                    
                    <button type="button" onclick="receiverSelect()">선택</button>
                </td>
            </tr>
            <tr>
                <th colspan="4">* 위 '종류'와 '공급받는자 구분'을 변경하신 후 [선택]버튼을 누르시면 아래 서식이 변경됩니다.</th>
            </tr>
        </table>
        
    </div>
    
    <div class="taxinvoice-lower">
        <div class="taxinvoice-body">
        
        <table class="taxinvoice-company">
            <tr id="b32-taxinvoice-supplier">
                <th rowspan="6">공급자</th>
                <th>* 등록번호</th>
                <td>${erp_company.company_registeredno }123-45-67890</td>
                <th>종사업장 번호</th>
                <td>0</td>                

                <th rowspan="6">공급받는자</th>
                <th id="b32-taxinvoice-receiverNum">* 등록번호</th>
                <td id="b32-taxinvoice-receiverNumInput">000-00-00001 <input type="button" value="확인" /></td>
                <th>종사업장 번호</th>
                <td>0</td>                
            </tr>
            
            <tr id="b32-taxinvoice-receiver">
                <th>* 상호</th>
                <td>${erp_compnay.company_name }상호</td>
                <th>* 성명</th>
                <td>${erp_company.company_representative }대표자성명</td>
                
                <th id="b32-taxinovice-receiverType">* 상호</th>
                <td id="b32-taxinovice-receiverTypeInput">${erp_compnay.company_name }상호</td>
                <th id="b32-taxinovice-receiverName">* 성명</th>
                <td id="b32-taxinovice-receiverNameInput">${erp_company.company_representative }거래처대표</td>
            </tr>
            
            <tr>
                <th>사업장</th>
                <td colspan="3">
                    <input type="text" id="company_postal" placeholder="우편번호">
                    <input type="button" onclick="searchAddr()" value="우편번호 찾기"><br>
                    <input type="text" id="company_addr1" placeholder="주소"><br>
                    <input type="text" id="company_addr2" placeholder="상세주소">
                    <input type="text" id="extraAddr" placeholder="참고항목">
                </td>
                
                <th>사업장</th>
                <td colspan="3" id="b32-taxinvoice-receiverAddress"></td>
            </tr>
            
            <tr>
                <th>업태</th>
                <td>${erp_businesstype.businesstype_name }제조<button>업태변경</button></td>
                <th>종목</th>
                <td>${erp_businesstype.businesstype_subctgr }IT/전자기기</td>
                
                <th>업태</th>
                <td>${erp_businesstype.businesstype_name }도소매<button>업태변경</button></td>
                <th>종목</th>
                <td>${erp_businesstype.businesstype_subctgr }도소매업</td>
            </tr>      
                 
            <tr>	
                <th>이메일</th>
                <td colspan="3">
                    <input type="text"> @ 
                    <input type="text" id="emailInput1" placeholder="직접입력">
                    <select id="emailSelect1">
                        <option value="custom">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="nate.com">nate.com</option>
                    </select>
                </td>
    
                <th>이메일</th>
                <td colspan="3">
                    <input type="text"> @ 
                    <input type="text" id="emailInput2" placeholder="직접입력" >
                    <select id="emailSelect2" >
                        <option value="custom">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="nate.com">nate.com</option>
                    </select>
                </td>
            </tr>   
                         
        </table>

        
        <table class="taxinvoice-contentsHeader">
            <tr>
                <th>* 작성일자</th>
                <td><input type="date" id="invoiceDate" onchange="invoiceDateInput()" /> ※작성일자는 공급 연월일을 의미함</td>
                <th>비고</th>
                <td><input type="text" /></td>
            </tr>
            <tr>
                <th>합계금액</th>
                <td id="b32-invoiceTotal"></td>
                <th>공급가액</th>
                <td id="b32-supAmountTotal"></td>
                <th>세액</th>
                <td id="b32-taxAmountTotal"></td>
            </tr>
        </table>

   		</div>
           
        <div class="taxinvoice-contentItem">
        	<p>※아래 '품목'의 '월'은 상단 '작성일자'의 '월'이 자동 반영됩니다. 합계의 '계산' 버튼은 금액을 공급가액과 세액으로 계산할 수 있습니다.</p> 
            <p>
	            <input type="button" id="addRow" value="품목추가">
	            <input type="button" id="deleteRow" value="품목삭제"> 품목은 최대 16개까지 추가, 삭제 가능
            </p>
    
            <table class="taxinvoice-contentsBody" id="itemTable">
                <tr id="itemTableTitle">
                    <th>월</th>
                    <th>일</th>
                    <th>품목</th>
                    <th>규격</th>
                    <th>수량</th>
                    <th>단가</th>
                    <th>합계</th>
                    <th>공급가액</th>
                    <th>세액</th>
                    <th>비고</th>
                    <th>삭제</th>
                </tr>
                <tr id="itemTableCluases">
                    <td name="b32-month"></td>
                    <td name="b32-date"><input type="number" name="b32-dateInput"></td>
                    <td name="b32-item"><input type="text" name="b32-itemInput"></td>
                    <td name="b32-spec"><input type="text" name="b32-specInput"></td>
                    <td name="b32-qty"><input type="number" name="b32-qtyInput"></td>
                    <td name="b32-unitPrice"><input type="number" name="b32-unitPriceInput"></td>
                    <td name="b32-calculateTotal"><button onclick="calculateTotal(this)">계산</button></td>
                    <td name="b32-supPrice"></td>
                    <td name="b32-taxPrice"></td>
                    <td name="b32-remark"><input type="text" name="b32-remarkInput"></td>
                    <td name="b32-clearRow"><button onclick="clearRow(this)">삭제</button></td>
                </tr>
            </table>
            
            <table>
                <tr>
                    <th>현금</th>
                    <th>수표</th>
                    <th>어음</th>
                    <th>외상미수금</th>
                    <th rowspan="2">이 금액을 (</th>
                    <th><input type="radio" name="" id="" value=""><label for="">일반</label>
                    <th rowspan="2">) 함</th>
                </tr>
                
                <tr>
                    <td><input type="number" /></td>
                    <td><input type="number" /></td>
                    <td><input type="number" /></td>
                    <td><input type="number" /></td>
                    <th><input type="radio" name="" id="" value=""><label for="">영수</label>
                </tr>
            </table>
            
        </div>
           
        <div>
	        <button>저장</button>
	        <button>초기화</button>
        </div>
        
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

// <공급자>

document.addEventListener('DOMContentLoaded', function() {
    const invoiceTypeRadio = document.getElementById('invoice-normal');
    invoiceTypeRadio.checked = true; // 해당 라디오 버튼을 선택되도록 설정
});

function invoiceSelect(){
    
}

// <공급받는자>

document.addEventListener('DOMContentLoaded', function() {
    const businessNumRadio = document.getElementById('receiver-businessNum');
    businessNumRadio.checked = true; // 해당 라디오 버튼을 선택되도록 설정
});

function receiverSelect() {
    const receiverType = document.querySelector('input[name="receiverType"]:checked').value;
    const foreignerRadio = document.getElementById('receiver-foreigner');
    const receiverTypeCell = document.getElementById('b32-taxinovice-receiverType');
    const receiverTypeInputCell = document.getElementById('b32-taxinovice-receiverTypeInput');
    const receiverNumberInputCell = document.getElementById('b32-taxinvoice-receiverNameInput');
    const receiverNameInputCell = document.getElementById('b32-taxinovice-receiverNameInput');
    const receiverAddress = document.getElementById('b32-taxinvoice-receiverAddress');

    if (receiverType === 'businessNum') {
    	document.getElementById('b32-taxinvoice-receiverNum').innerText = '* 등록번호';
        receiverTypeCell.style.display = 'table-cell';
        receiverTypeInputCell.style.display = 'table-cell';
        receiverNameInputCell.style.display = 'table-cell';

    } else if (receiverType === 'personalNum') {
    	document.getElementById('b32-taxinvoice-receiverNum').innerText = '* 주민등록번호';
    	receiverNumberInputCell.innerHTML = '<input type="text" id="receivernNumberInput">';
        receiverTypeCell.style.display = 'none'; // 상호 라벨과 셀을 숨김
        receiverTypeInputCell.style.display = 'none'; // 입력 필드를 숨김
        receiverNameInputCell.innerHTML = '<input type="text" id="receiverNameInput">';
    } else {
        alert('외국인일 경우 외국인등록번호 또는 여권번호를 작성일자 오른쪽 비고란에 입력하십시오.');
    	document.getElementById('b32-taxinvoice-receiverNum').innerText = '* 주민등록번호';
        document.getElementById('b32-taxinvoice-receiverNumInput').innerText = '999999-9999999';
        receiverTypeCell.style.display = 'none'; // 상호 라벨과 셀을 숨김
        receiverTypeInputCell.style.display = 'none'; // 입력 필드를 숨김
        receiverNameInputCell.innerHTML = '<input type="text" id="receiverNameInput">';
		receiverAddress.innerHTML = '<input type="text" id="receiverAddressInput">';
    }

}


// <이메일>
const emailInput1 = document.getElementById('emailInput1');
const emailSelect1 = document.getElementById('emailSelect1');

// 텍스트 박스에 값 입력 시, <select> 요소를 "직접입력"으로 선택
emailInput1.addEventListener('input', function() {
    emailSelect1.value = 'custom';
});

// <select> 요소가 변경될 때, 텍스트 박스의 값을 초기화
emailSelect1.addEventListener('change', function() {
    if (emailSelect1.value === 'custom') {
        emailInput1.value = '';
    } else {
        emailInput1.value = emailSelect1.value;
    }
});

const emailInput2 = document.getElementById('emailInput2');
const emailSelect2 = document.getElementById('emailSelect2');

// 텍스트 박스에 값 입력 시, <select> 요소를 "직접입력"으로 선택
emailInput2.addEventListener('input', function() {
    emailSelect2.value = 'custom';
});

// <select> 요소가 변경될 때, 텍스트 박스의 값을 초기화
emailSelect2.addEventListener('change', function() {
    if (emailSelect2.value === 'custom') {
        emailInput2.value = '';
    } else {
        emailInput2.value = emailSelect2.value;
    }
});


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


// <세금계산서>

const itemTable = document.getElementById('itemTable');

// 세금계산서 일자
// 오늘 날짜까지만 선택 가능하도록 제한
document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.getElementById('invoiceDate');
    const currentDate = new Date();
    const currentDateString = currentDate.toISOString().substr(0, 10);
    
    dateInput.setAttribute('max', currentDateString);
    
});

// 선택한 날짜가 하단의 [월] 열에 자동 입력되도록 하는 함수
function invoiceDateInput() {
    const dateInput = document.getElementById('invoiceDate');
    const selectedDate = new Date(dateInput.value);
    
    const rows = itemTable.getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const monthCell = rows[i].cells[0];
        const monthValue = selectedDate.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더함
        monthCell.innerText = monthValue;
    }
}


// <세금계산서 품목>

document.addEventListener('DOMContentLoaded', function() {
        // 페이지 로드 시 3번 품목추가 버튼을 클릭하는 코드
        const addRowButton = document.getElementById('addRow');
        for (let i = 0; i < 3; i++) {
            addRowButton.click();
        }
    });

const addRowButton = document.getElementById('addRow');
const deleteRowButton = document.getElementById('deleteRow');

addRowButton.addEventListener('click', function() {
    if (itemTable.rows.length <= 16) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];

        for (let i = 0; i < 11; i++) {
            cells.push(newRow.insertCell(i));
            
            if (i === 0) {
                cells[i].innerHTML = '<td name="b32-month">'+itemTable.rows[1].cells[0].innerHTML+'</td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td name="b32-date"><input type="number" name="b32-dateInput"></td>';
            } else if (i === 2){
                cells[i].innerHTML = '<td name="b32-item"><input type="text" name="b32-itemInput"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td name="b32-spec"><input type="text" name="b32-specInput"></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td name="b32-qty"><input type="number" name="b32-qtyInput"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td name="b32-unitPrice"><input type="number" name="b32-unitPriceInput"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td name="b32-calculateTotal"><button onclick="calculateTotal(this)">계산</button></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td name="b32-supPrice"></td>';
            } else if (i === 8){
                cells[i].innerHTML = '<td name="b32-taxPrice"></td>';
            } else if (i === 9){
                cells[i].innerHTML = '<td name="b32-remark"><input type="text" name="b32-remarkInput"></td>';
            } else {
                cells[i].innerHTML = '<td name="b32-clearRow"><button onclick="clearRow(this)">삭제</button></td>';
            }
        }
    } else {
        alert('품목은 최대 16개까지 추가할 수 있습니다.');
    }
});

var invoiceTotal = 0;
var supAmountTotal = 0;
var taxAmountTotal = 0;

deleteRowButton.addEventListener('click', function() {
    const rows = itemTable.getElementsByTagName('tr');
    
    if (itemTable.rows.length > 5) {
        const supPrice = Number(rows[rows.length - 1].cells[7].innerText);
        const taxPrice = Number(rows[rows.length - 1].cells[8].innerText);
        
        supAmountTotal -= supPrice;
        document.getElementById('b32-supAmountTotal').innerText = supAmountTotal;
        taxAmountTotal -= taxPrice;
        document.getElementById('b32-taxAmountTotal').innerText = taxAmountTotal;
        invoiceTotal = supAmountTotal + taxAmountTotal;
        document.getElementById('b32-invoiceTotal').innerText = invoiceTotal;
        
        itemTable.deleteRow(itemTable.rows.length-1);
    } else {
        alert('품목은 4개 이하로 삭제할 수 없습니다.');
    }
});

function clearRow(button) {     
    const row = button.parentNode.parentNode;
    
    const supPrice = Number(row.cells[7].innerText);
    const taxPrice = Number(row.cells[8].innerText);
    
    supAmountTotal -= supPrice;
    document.getElementById('b32-supAmountTotal').innerText = supAmountTotal;
    taxAmountTotal -= taxPrice;
    document.getElementById('b32-taxAmountTotal').innerText = taxAmountTotal;
    invoiceTotal = supAmountTotal + taxAmountTotal;
    document.getElementById('b32-invoiceTotal').innerText = invoiceTotal;
    
    row.cells[7].innerText = '';
    row.cells[8].innerText = '';
    
    const inputs = row.getElementsByTagName('input');
    for (let i = 0; i < inputs.length; i++) {
        inputs[i].value = '';
    }
}

function calculateTotal(button) {
    const row = button.parentNode.parentNode;
    const quantity = Number(row.cells[4].querySelector('input').value);
    const unitPrice = Number(row.cells[5].querySelector('input').value);
    
    const total = Math.round(quantity * unitPrice);
    supAmountTotal -= Number(row.cells[7].innerText);
    row.cells[7].innerText = total;
    supAmountTotal += total;
    document.getElementById('b32-supAmountTotal').innerText = supAmountTotal;

    const taxRate = 0.1;
    const taxAmount = Math.round(total * taxRate);
    taxAmountTotal -= Number(row.cells[8].innerText);
    row.cells[8].innerText = taxAmount;
    taxAmountTotal += taxAmount;
    document.getElementById('b32-taxAmountTotal').innerText = taxAmountTotal;

    invoiceTotal = supAmountTotal + taxAmountTotal;
    document.getElementById('b32-invoiceTotal').innerText = invoiceTotal;
}


</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    