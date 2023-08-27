<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

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
    <h1>생산 의뢰서</h1>
    
    <div class="taxinvoice-lower">
        <c:if test="${inmap != null }">
        <form action="${pageContext.request.contextPath}/d/d1/d12/update">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="employee1_no" id="employee1_no" value="${inmap.employee1_no }">
        	<input type="hidden" name="client_no" id="client_no" value="${inmap.client_no }">
        	<input type="hidden" name="requestproduct_no" id="requestproduct_no" value="${inmap.requestproduct_no }">
        <table>
        	<tr>
        		<th>코드</th>
        		<td><input type="text" name="requestproduct_code" id="requestproduct_code" value="${inmap.requestproduct_code }" readonly="readonly" maxlength="30" class="required"></td>
        		<th>의뢰명</th>
        		<td><input type="text" name="requestproduct_name" id="requestproduct_name" value="${inmap.requestproduct_name }" class="required"></td>
        		<th>기간</th>
        		<td><input type="date" name="requestproduct_start" id="requestproduct_start" value="${inmap.requestproduct_start }"> - <input type="date" name="requestproduct_end" id="requestproduct_end" value="${inmap.requestproduct_end }"></td>
        	</tr>
        	<tr>
        		<th colspan="6" align="center">내용</th>
        	</tr>
        	<tr>
        		<td colspan="6"><input type="text" name="requestproduct_content" id="requestproduct_content" value="${inmap.requestproduct_content }" class="required"></td>
        	</tr>
        </table>
        
        <table class="taxinvoice-company">
            <tr id="b32-taxinvoice-supplier">
                <th rowspan="6">의뢰 거래처<input type="button" onclick="clList('${comcode_code}')" value="search"></th>
                <th>* 사업자등록번호</th>
                <td id="client_registeredno">${inmap.client_registeredno}</td>
                <th>국가명</th>
                <td id="country_name">${inmap.country_name}</td>

                <th rowspan="6">의뢰 담당자</th>
                <th>* 사원코드</th>
                <td><input type="text" value="${inmap.employee1_code}" name="employee1_code" id="employee1_code" onkeypress="searchecode(event, '${comcode_code}')"><input type="button" value="확인"/></td>
                <th>전화번호</th>
                <td id="employee1_phone">${inmap.employee1_phone }</td>
            </tr>
            
            <tr id="b32-taxinvoice-receiver">
                <th>* 상호</th>
                <td><input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')" value="${inmap.client_name }"></td>
                <th>* 성명</th>
                <td id="client_representative">${inmap.client_representative }</td>
                
                <th>성명</th>
                <td id="employee1_name">${inmap.employee1_name }</td>
                <th>직급</th>
                <td id="employee2_position">${inmap.employee2_position }</td>
            </tr>
            
            <tr>
                <th>업태</th>
                <td id="businesstype_name">${inmap.businesstype_name }</td>
                <th>종목</th>
                <td id="businesstype_subctgr">${inmap.businesstype_subctgr }</td>
                
                <th rowspan="2">이메일</th>
                <td rowspan="2" id="employee1_email">${inmap.employee1_email }</td>
                <th rowspan="2">부서</th>
                <td rowspan="2" id="team_name">${inmap.team_name }</td>
            </tr>
                 
            <tr>
                <th>이메일</th>
                <td colspan="3" id="client_email">${inmap.client_email}</td>
            </tr>
         </table>
         
         <div class="taxinvoice-contentItem">
         	<p>
               <input type="button" id="addRow" value="품목추가">
               <input type="button" id="deleteRow" value="품목삭제"> 품목은 최대 16개까지 추가, 삭제 가능
         	</p>
            <table class="taxinvoice-contentsBody" id="itemTable">
                <tr id="itemTableTitle">
                    <th>의뢰수량</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>소비자가</th>
                    <th>단위</th>
                    <th>사양</th>
                    <th>규격</th>
                    <th>포장</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>설명</th>
                </tr>
                <c:forEach var="i" items="${glist }" varStatus="status">
                	<tr>
	                	<td><input type="text" name="crlist[${status.index }].connectrequest_qty" id="crlist[${status.index }].connectrequest_qty" value="${i.connectrequest_qty }"></td>
						<td><input type="text" name="crlist[${status.index }].goods_code" id="crlist[${status.index }].goods_code" value="${i.goods_code }"></td>
						<td><input type="text" name="crlist[${status.index }].goods_barcode" id="crlist[${status.index }].goods_barcode" value="${i.goods_barcode }"></td>
						<td>
							<select name="crlist[${status.index }].goodskind_no" id="crlist[${status.index }].goodskind_no">
								<c:forEach var="sk" items="${sortkind }">
								<c:choose>
									<c:when test="${sk.goodskind_no == i.goodskind_no }">
										<option value="${sk.goodskind_no }" selected="selected">${sk.goodssort_name } - ${sk.goodskind_name }</option>
									</c:when>
									<c:otherwise>
										<option value="${sk.goodskind_no }">${sk.goodssort_name } - ${sk.goodskind_name }</option>
									</c:otherwise>
								</c:choose>
								</c:forEach>
							</select>
						</td>
						<td><input type="text" name="crlist[${status.index }].goods_customerprice" id="crlist[${status.index }].goods_customerprice" value="${i.goods_customerprice }"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_unit" id="crlist[${status.index }].goodsst_unit" value="${i.goodsst_unit }"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_spec" id="crlist[${status.index }].goodsst_spec" value="${i.goodsst_spec }"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_size" id="crlist[${status.index }].goodsst_size" value="${i.goodsst_size }"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_package" id="crlist[${status.index }].goodsst_package" value="${i.goodsst_package }"></td>
						<td>
							<input type="text" name="crlist[${status.index }].client_name1" id="crlist[${status.index }].client_name1" value="${i.client_name1}" onkeypress="searchcl1(event, '${comcode_code}',${status.index })">
							<input type="button" onclick="clList3('${comcode_code}',${status.index })" value="search">
						</td>
						<td>
							<input type="text" name="crlist[${status.index }].client_name2" id="crlist[${status.index }].client_name2" value="${i.client_name2}" onkeypress="searchcl2(event, '${comcode_code}',${status.index })">
							<input type="button" onclick="clList4('${comcode_code}',${status.index })" value="search">
						</td>
						<td><input type="text" name="crlist[${status.index }].goodsst_ea" id="crlist[${status.index }].goodsst_ea" value="${i.goodsst_ea }"></td>
						<td>
							<input type="text" name="crlist[${status.index }].goods_description" id="crlist[${status.index }].goods_description" value="${i.goods_description }">
							<input type="hidden" name="crlist[${status.index }].client_no1" id="crlist[${status.index }].client_no1" value="${i.client_no1 }">
	        				<input type="hidden" name="crlist[${status.index }].client_no2" id="crlist[${status.index }].client_no2" value="${i.client_no2 }">
	        				<input type="hidden" name="crlist[${status.index }].connectrequest_no" id="crlist[${status.index }].connectrequest_no" value="${i.connectrequest_no }">
	        				<input type="hidden" name="crlist[${status.index }].requestproduct_no" id="crlist[${status.index }].requestproduct_no" value="${i.requestproduct_no }">
						</td>
						<td><input type="button" onclick="deleteGoods(${i.requestproduct_no}, ${i.connectrequest_no })" value="delete"></td>
					</tr>
                </c:forEach>
            </table>
        </div>
        <div>
           <input type="button" value="update" onclick="sub(this.form)">
           <input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/d/d1/d12/delete?requestproduct_no=${inmap.requestproduct_no }&comcode_code=${comcode_code }'">
           <input type="button" value="PED" onclick="location.href='${pageContext.request.contextPath}/d/d1/d13/addPed?requestproduct_no=${inmap.requestproduct_no }&comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
	</div>
            
    <div>
        <c:if test="${inmap == null }">
        <form action="${pageContext.request.contextPath}/d/d1/d12/createRequestProduct">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="employee1_no" id="employee1_no" value="1">
        	<input type="hidden" name="client_no" id="client_no" value="17">
        	<div class="taxinvoice-body">
        <table>
        	<tr>
        		<th>코드</th>
        		<td><input type="text" name="requestproduct_code" id="requestproduct_code" maxlength="30" class="required" onblur="code(this.value)">
        		<h6 id="requestcode" style="color:red;"></h6></td>
        		<th>의뢰명</th>
        		<td><input type="text" name="requestproduct_name" id="requestproduct_name" class="required"></td>
        		<th>기간</th>
        		<td><input type="date" name="requestproduct_start" id="requestproduct_start"> - <input type="date" name="requestproduct_end" id="requestproduct_end"></td>
        	</tr>
        	<tr>
        		<th colspan="6" align="center">내용</th>
        	</tr>
        	<tr>
        		<td colspan="6"><input type="text" name="requestproduct_content" id="requestproduct_content" class="required"></td>
        	</tr>
        </table>
        
        <table class="taxinvoice-company">
            <tr id="b32-taxinvoice-supplier">
                <th rowspan="6">의뢰 거래처<input type="button" onclick="clList('${comcode_code}')" value="search"></th>
                <th>* 사업자등록번호</th>
                <td id="client_registeredno"></td>
                <th>국가명</th>
                <td id="country_name"></td>

                <th rowspan="6">의뢰 담당자</th>
                <th>* 사원코드</th>
                <td id="employee1_code"><input type="text" name="employee1_code" id="employee1_code" onkeypress="searchecode(event, '${comcode_code}')"></td>
                <th>전화번호</th>
                <td id="employee1_phone"></td>
            </tr>
            
            <tr id="b32-taxinvoice-receiver">
                <th>* 상호</th>
                <td><input type="text" name="client_name" id="client_name" onkeypress="searchcl(event, '${comcode_code}')"></td>
                <th>* 성명</th>
                <td id="client_representative"></td>
                
                <th>성명</th>
                <td id="employee1_name"></td>
                <th>직급</th>
                <td id="employee2_position"></td>
            </tr>
            
            <tr>
                <th>업태</th>
                <td id="businesstype_name"></td>
                <th>종목</th>
                <td id="businesstype_subctgr"></td>
                
                <th rowspan="2">이메일</th>
                <td rowspan="2" id="employee1_email"></td>
                <th rowspan="2">부서</th>
                <td rowspan="2" id="team_name"></td>
            </tr>
                 
            <tr>
                <th>이메일</th>
                <td colspan="3" id="client_email"></td>
            </tr>
                         
         </table>

         </div>
           
        <div class="taxinvoice-contentItem">
            <p>
               <input type="button" id="addRow" value="품목추가">
               <input type="button" id="deleteRow" value="품목삭제"> 품목은 최대 16개까지 추가, 삭제 가능
            </p>
    
            <table class="taxinvoice-contentsBody" id="itemTable">
                <tr id="itemTableTitle">
                    <th>의뢰수량</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>소비자가</th>
                    <th>단위</th>
                    <th>사양</th>
                    <th>규격</th>
                    <th>포장</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>설명</th>
                </tr>
               	<tr id="procode">
					<td><input type="text" name="crlist1[0].connectrequest_qty" id="crlist1[0].connectrequest_qty"></td>
					<td><input type="text" name="crlist1[0].goods_code" id="crlist1[0].goods_code"></td>
					<td><input type="text" name="crlist1[0].goods_barcode" id="crlist1[0].goods_barcode"></td>
					<td>
						<select name="crlist1[0].goodskind_no" id="crlist1[0].goodskind_no">
							<c:forEach var="sk" items="${sortkind }">
								<option value="${sk.goodskind_no }">${sk.goodssort_name } - ${sk.goodskind_name }</option>
							</c:forEach>
						</select>
					</td>
					<td><input type="text" name="crlist1[0].goods_customerprice" id="crlist1[0].goods_customerprice"></td>
					<td><input type="text" name="crlist1[0].goodsst_unit" id="crlist1[0].goodsst_unit"></td>
					<td><input type="text" name="crlist1[0].goodsst_spec" id="crlist1[0].goodsst_spec"></td>
					<td><input type="text" name="crlist1[0].goodsst_size" id="crlist1[0].goodsst_size"></td>
					<td><input type="text" name="crlist1[0].goodsst_package" id="crlist1[0].goodsst_package"></td>
					<td>
						<input type="text" name="crlist1[0].client_name1" id="crlist1[0].client_name1" onkeypress="searchcl3(event, '${comcode_code}',0)">
						<input type="button" onclick="clList3('${comcode_code}',0)" value="search">
					</td>
					<td>
						<input type="text" name="crlist1[0].client_name2" id="crlist1[0].client_name2" onkeypress="searchcl4(event, '${comcode_code}',0)">
						<input type="button" onclick="clList4('${comcode_code}',0)" value="search">
					</td>
					<td><input type="text" name="crlist1[0].goodsst_ea" id="crlist1[0].goodsst_ea"></td>
					<td>
						<input type="text" name="crlist1[0].goods_description" id="crlist1[0].goods_description">
						<input type="hidden" name="crlist1[0].client_no1" id="crlist1[0].client_no1" value="17">
        				<input type="hidden" name="crlist1[0].client_no2" id="crlist1[0].client_no2" value="17">
					</td>
					<td name="b32-clearRow"><input type="button" onclick="clearRow(this)" value="delete"></td>
				</tr>
            </table>
            
        </div>
           
        <div>
           <input type="button" value="save" onclick="sub(this.form)">
           <input type="reset" value="reset">
        </div>
        </form>
        </c:if>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
function sub(f){
	
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	for(var b = 0; b < arr.length; b++){
		if(arr[b].value == ""){
			arr[b].focus();
			return;
		}
	}
	
	var pat = /^[0-9]{0,8}$/;
	if(f.requestproduct_name.value == ""){
		f.requestproduct_name.focus();
		return;
	}else if(f.requestproduct_start.value == ""){
		f.requestproduct_start.focus();
		return;
	}else if(f.requestproduct_end.value == ""){
		f.requestproduct_start.focus();
		return;
	}else if(f.client_name.value == ""){
		f.client_name.focus();
		return;
	}else if(f.employee1_code.value == ""){
		f.employee1_code.focus();
		return;
	}else if(f.requestproduct_content.value == ""){
		var ch = confirm("내용이 입력되지 않은 내용이 있습니다. 등록하시겠습니까?")
		if(ch){
			f.submit();
		}else {
			f.requestproduct_content.focus();
			return;
		}
		return;
	}else {
		var ch = confirm("등록하시겠습니까?");
		if(ch){
			f.submit();
		}else {
			return;
		}
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
    if (itemTable.rows.length <= 16) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
        j += 1;
        for (let i = 0; i < 14; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].connectrequest_qty" id="crlist1['+j+'].connectrequest_qty"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_code" id="crlist1['+j+'].goods_code"></td>';
            } else if (i === 2){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_barcode" id="crlist1['+j+'].goods_barcode"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td><select name="crlist1['+j+'].goodskind_no" id="crlist1['+j+'].goodskind_no"><c:forEach var="sk" items="${sortkind }"><option value="${sk.goodskind_no }">${sk.goodssort_name } - ${sk.goodskind_name }</option></c:forEach></select></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_customerprice" id="crlist1['+j+'].goods_customerprice"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_unit" id="crlist1['+j+'].goodsst_unit"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_spec" id="crlist1['+j+'].goodsst_spec"></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_size" id="crlist1['+j+'].goodsst_size"></td>';
            } else if (i === 8){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_package" id="crlist1['+j+'].goodsst_package"></td>';
            }  else if (i === 9){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].client_name1" id="crlist1['+j+'].client_name1" onkeypress="searchcl3(event, `${comcode_code}`, '+j+')"><input type="button" onclick="clList3(`${comcode_code}`,'+j+')" value="search"></td>';
            }  else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].client_name2" id="crlist1['+j+'].client_name2" onkeypress="searchcl4(event, `${comcode_code}`, '+j+')"><input type="button" onclick="clList4(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_ea" id="crlist1['+j+'].goodsst_ea"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_description" id="crlist1['+j+'].goods_description"></td><input type="hidden" name="crlist1['+j+'].client_no1" id="crlist1['+j+'].client_no1" value="17"><input type="hidden" name="crlist1['+j+'].client_no2" id="crlist1['+j+'].client_no2" value="17">';
            } else {
                cells[i].innerHTML = '<td name="b32-clearRow"><input type="button" onclick="clearRow(this)" value="delete"></td>';
            }
        }
    } else {
        alert('품목은 최대 16개까지 추가할 수 있습니다.');
    }
});


deleteRowButton.addEventListener('click', function() {
    const rows = itemTable.getElementsByTagName('tr');
    
    if (itemTable.rows.length > 2) {
    	j -= 1;
        itemTable.deleteRow(itemTable.rows.length-1);
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

function searchcl(e, code){
	if(e.keyCode == 13){
		var clname = document.getElementById("client_name").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("client_name").focus();
			return;
		}
		console.log(clname);
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName, "POST");
	}
}
function clName(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		console.log(data);
		if(data != null){
			var data2 = JSON.parse(data);	// ajax로 받아온 데이터를 json으로 변형
		console.log(data2);
			document.getElementById("client_no").value = data2.client_no;
			document.getElementById("client_name").value = data2.client_name;
			document.getElementById("client_registeredno").innerText = data2.client_registeredno;
			document.getElementById("client_email").innerText = data2.client_email;
			document.getElementById("country_name").innerText = data2.country_name;
			document.getElementById("client_representative").innerText = data2.client_representative;
			document.getElementById("businesstype_name").innerText = data2.businesstype_name;
			document.getElementById("businesstype_subctgr").innerText = data2.businesstype_subctgr;
		}else {
			document.getElementById("client_no").value = 17;
			document.getElementById("client_name").value = '';
			document.getElementById("client_registeredno").innerText = '';
			document.getElementById("client_email").innerText = '';
			document.getElementById("country_name").innerText = '';
			document.getElementById("client_representative").innerText = '';
			document.getElementById("businesstype_name").innerText = '';
			document.getElementById("businesstype_subctgr").innerText = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}

var p = 0;

function searchcl1(e, code, n){
	if(e.keyCode == 13){
		var clname = document.getElementById("crlist["+n+"].client_name1").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("crlist["+n+"].client_name1").focus();
			return;
		}
		p = n;
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName1, "POST");
	}
}
function clName1(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("crlist["+p+"].client_no1").value = data2.client_no;
			document.getElementById("crlist["+p+"].client_name1").value = data2.client_name;
		}else {
			document.getElementById("crlist["+p+"].client_no1").value = 17;
			document.getElementById("crlist["+p+"].client_name1").value = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}

function searchcl2(e, code, n){
	if(e.keyCode == 13){
		var clname = document.getElementById("crlist["+n+"].client_name2").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("crlist["+n+"].client_name2").focus();
			return;
		}
		p = n;
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName2, "POST");
	}
}
function clName2(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("crlist["+p+"].client_no2").value = data2.client_no;
			document.getElementById("crlist["+p+"].client_name2").value = data2.client_name;
		}else {
			document.getElementById("crlist["+p+"].client_no2").value = 17;
			document.getElementById("crlist["+p+"].client_name2").value = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}
function searchcl3(e, code, n){
	if(e.keyCode == 13){
		var clname = document.getElementById("crlist1["+n+"].client_name1").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("crlist1["+n+"].client_name1").focus();
			return;
		}
		p = n;
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName3, "POST");
	}
}
function clName3(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("crlist1["+p+"].client_no1").value = data2.client_no;
			document.getElementById("crlist1["+p+"].client_name1").value = data2.client_name;
		}else {
			document.getElementById("crlist1["+p+"].client_no1").value = 17;
			document.getElementById("crlist1["+p+"].client_name1").value = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}
function searchcl4(e, code, n){
	if(e.keyCode == 13){
		var clname = document.getElementById("crlist1["+n+"].client_name2").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("crlist1["+n+"].client_name2").focus();
			return;
		}
		p = n;
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName4, "POST");
	}
}
function clName4(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("crlist1["+p+"].client_no2").value = data2.client_no;
			document.getElementById("crlist1["+p+"].client_name2").value = data2.client_name;
		}else {
			document.getElementById("crlist1["+p+"].client_no2").value = 17;
			document.getElementById("crlist1["+p+"].client_name2").value = '';
			alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
		}
	}
}

function searchecode(e, code){
	if(e.keyCode == 13){
		var ecode1 = document.getElementById("employee1_code").value;
		console.log(ecode1);
		if(ecode == ""){
			alert("조회할 직원 코드를 입력해주세요.");
			document.getElementById("employee1_code").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchecode";
		var param = "employee1_code="+encodeURIComponent(ecode1);
		
		sendRequest(url, param, ecode, "POST");
	}
}
function ecode(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);	// ajax로 받아온 데이터를 json으로 변형
			document.getElementById("employee1_no").value = data2.employee1_no;
			document.getElementById("employee1_code").value = data2.employee1_code;
			document.getElementById("employee1_phone").innerText = data2.employee1_phone;
			document.getElementById("employee1_name").innerText = data2.employee1_name;
			document.getElementById("employee2_position").innerText = data2.employee2_position;
			document.getElementById("employee1_email").innerText = data2.employee1_email;
			document.getElementById("team_name").innerText = data2.team_name;
		}else {
			document.getElementById("employee1_no").value = 1;
			document.getElementById("employee1_code").value = '';
			document.getElementById("employee1_phone").innerText = '';
			document.getElementById("employee1_name").innerText = '';
			document.getElementById("employee2_position").innerText = '';
			document.getElementById("employee1_email").innerText = '';
			document.getElementById("team_name").innerText = '';
			alert("조회된 직원이 없거나 중복된 코드입니다. 조회 버튼을 클릭하여 직원을 선택해주세요.");
		}
	}
}


function clList(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}
function clList1(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/clList1?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}
function clList2(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/clList2?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}
function clList3(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/clList3?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}
function clList4(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/clList4?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=500, height=500");
}

function code(v){
	var url = "${pageContext.request.contextPath }/d/d1/d12/getRequestCode";
	var param = "requestproduct_code="+encodeURIComponent(v);
	
	sendRequest(url,param,codecheck,"POST");
}
function codecheck(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data != ""){	
			if(data == "사용 가능한 코드입니다."){
				document.getElementById("requestcode").innerText = data;
				document.getElementById("requestcode").style.color = "blue";
				document.getElementById("register").disabled = false;
			}else {
				document.getElementById("requestcode").innerText = data;
				document.getElementById("register").disabled = true;
				document.getElementById("requestproduct_code").focus();	
			}
		}
	}
}

var t = 0;
function deleteGoods(rno, cno){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(arr.length == 0){
		alert("상품은 반드시 1개 이상이어야 합니다.");
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d1/d12/deleteGoods";
	var param = "requestproduct_no="+encodeURIComponent(rno)+"&connectrequest_no="+encodeURIComponent(cno);
	
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
			procode.innerHTML += '<tr><th>의뢰수량</th><th>상품코드</th><th>바코드</th><th>종류</th><th>소비자가</th><th>단위</th><th>사양</th><th>규격</th><th>포장</th><th>제조사</th><th>책임판매업자</th><th>사입량</th><th>설명</th></tr>';
			var data2 = JSON.parse(data);
			console.log(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.connectrequest_qty+'" name="crlist['+t+'].connectrequest_qty" id="crlist['+t+'].connectrequest_qty">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_code+'" name="crlist['+t+'].goods_code" id="crlist['+t+'].goods_code">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_barcode+'" name="crlist['+t+'].goods_barcode" id="crlist['+t+'].goods_barcode">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<select name="crlist['+t+'].goodskind_no" id="crlist['+t+'].goodskind_no"><c:forEach var="sk" items="${param.sortkind }"><c:choose><c:when test="${sk.goodskind_no == '+map.goodskind_no+' }"><option value="${sk.goodskind_no }" selected="selected">${sk.goodssort_name } - ${sk.goodskind_name }</option></c:when><c:otherwise><option value="${sk.goodskind_no }">${sk.goodssort_name } - ${sk.goodskind_name }</option></c:otherwise></c:choose></c:forEach></select>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_customerprice+'" name="crlist['+t+'].goods_customerprice" id="crlist['+t+'].goods_customerprice">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_unit+'" name="crlist['+t+'].goodsst_unit" id="crlist['+t+'].goodsst_unit">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_spec+'" name="crlist['+t+'].goodsst_spec" id="crlist['+t+'].goodsst_spec">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_size+'" name="crlist['+t+'].goodsst_size" id="crlist['+t+'].goodsst_size">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_package+'" name="crlist['+t+'].goodsst_package" id="crlist['+t+'].goodsst_package">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name1+'" name="crlist['+t+'].client_name1" id="crlist['+t+'].client_name1" onkeypress="searchcl1(event, `${comcode_code}`, '+t+')"><input type="button" onclick="clList1(`${comcode_code}`,'+t+')" value="search">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name2+'" name="crlist['+t+'].client_name2" id="crlist['+t+'].client_name2" onkeypress="searchcl2(event, `${comcode_code}`, '+t+')"><input type="button" onclick="clList2(`${comcode_code}`,'+t+')" value="search">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_ea+'" name="crlist['+t+'].goodsst_ea" id="crlist['+t+'].goodsst_ea">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.goods_description+'" name="crlist['+t+'].goods_description" id="crlist['+t+'].goods_description"></td><input type="hidden" name="crlist['+t+'].client_no1" id="crlist['+t+'].client_no1" value="'+map.client_no1+'"><input type="hidden" name="crlist['+t+'].client_no2" id="crlist['+t+'].client_no2" value="'+map.client_no2+'"><input type="hidden" name="crlist['+t+'].connectrequest_no" id="crlist['+t+'].connectrequest_no" value="'+map.connectrequest_no+'"><input type="hidden" name="crlist['+t+'].requestproduct_no" id="crlist['+t+'].requestproduct_no" value="'+map.requestproduct_no+'">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="deleteGoods('+map.requestproduct_no+', '+map.connectrequest_no+')" value="delete">';
				newTr.appendChild(newTd);
				t = Number(t) + 1;
			});
		}else {
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td colspan="13">목록이 없습니다.</td></tr>';
		}
	}
}

</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>