<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/dhlayout/header.jsp" %>

<div class="notosanskr">
	<div class="dh_aligncenter">
    	<h1>생산 의뢰서 등록</h1>
	</div>
	
	<div class="warning_box">
		<span class="red bigger">* </span>
		<div class="yellow_box"></div>
		<span class="red">는 필수 입력란입니다.</span>
	</div>
    
    <div>
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
        		<td><input type="text" name="requestproduct_name" id="requestproduct_name" value="${inmap.requestproduct_name }" class="required" maxlength="50"></td>
        		<th>기간</th>
        		<td><input type="date" name="requestproduct_start" id="requestproduct_start" value="${inmap.requestproduct_start }" onchange="startcheck(this.value)"> - <input type="date" name="requestproduct_end" id="requestproduct_end" value="${inmap.requestproduct_end }"></td>
        	</tr>
        	<tr>
        		<th colspan="6" align="center">내용</th>
        	</tr>
        	<tr>
        		<td colspan="6"><input type="text" name="requestproduct_content" id="requestproduct_content" value="${inmap.requestproduct_content }" class="required"></td>
        	</tr>
        </table>
        
        <table>
            <tr>
                <th rowspan="6">의뢰 거래처<input type="button" onclick="clList('${comcode_code}')" value="search"></th>
                <th>* 사업자등록번호</th>
                <td id="client_registeredno">${inmap.client_registeredno}</td>
                <th>국가명</th>
                <td id="country_name">${inmap.country_name}</td>

                <th rowspan="6">의뢰 담당자</th>
                <th>* 사원코드</th>
                <td><input type="text" value="${inmap.employee1_code}" name="employee1_code" id="employee1_code" onkeypress="searchecode(event, '${comcode_code}')" onblur="searchecode1('${comcode_code}')"></td>
                <th>전화번호</th>
                <td id="employee1_phone">${inmap.employee1_phone }</td>
            </tr>
            
            <tr>
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
                    <th>원가</th>
                    <th>단위</th>
                    <th>사양</th>
                    <th>규격</th>
                    <th>포장</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>설명</th>
                    <th>의뢰수량</th>
                </tr>
                <c:forEach var="i" items="${glist }" varStatus="status">
                	<tr class="plist">
	                	<td>
		                	<input type="button" onclick="goodsList1('${comcode_code}',${status.index })" value="search">
		                </td>
						<td><input type="text" name="crlist[${status.index }].goods_name" id="crlist[${status.index }].goods_name" value="${i.goods_name }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goods_code" id="crlist[${status.index }].goods_code" value="${i.goods_code }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goods_barcode" id="crlist[${status.index }].goods_barcode" value="${i.goods_barcode }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist[${status.index }].goodssort_name" id="crlist[${status.index }].goodssort_name" value="${i.goodssort_name } ${i.goodskind_name}" readonly="readonly">
							<input type="hidden" name="crlist[${status.index }].goodskind_no" id="crlist[${status.index }].goodskind_no" value="${i.goodskind_no }" readonly="readonly">
						</td>
						<td><input type="text" name="crlist[${status.index }].goodslot_price" id="crlist[${status.index }].goodslot_price" value="${i.goodslot_price }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_unit" id="crlist[${status.index }].goodsst_unit" value="${i.goodsst_unit }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_spec" id="crlist[${status.index }].goodsst_spec" value="${i.goodsst_spec }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_size" id="crlist[${status.index }].goodsst_size" value="${i.goodsst_size }" readonly="readonly"></td>
						<td><input type="text" name="crlist[${status.index }].goodsst_package" id="crlist[${status.index }].goodsst_package" value="${i.goodsst_package }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist[${status.index }].client_name1" id="crlist[${status.index }].client_name1" value="${i.client_name1}" readonly="readonly">
						</td>
						<td>
							<input type="text" name="crlist[${status.index }].client_name2" id="crlist[${status.index }].client_name2" value="${i.client_name2}" readonly="readonly">
						</td>
						<td><input type="text" name="crlist[${status.index }].goodsst_ea" id="crlist[${status.index }].goodsst_ea" value="${i.goodsst_ea }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist[${status.index }].goods_description" id="crlist[${status.index }].goods_description" value="${i.goods_description }" readonly="readonly">
							<input type="hidden" name="crlist[${status.index }].client_no1" id="crlist[${status.index }].client_no1" value="${i.client_no1 }">
	        				<input type="hidden" name="crlist[${status.index }].client_no2" id="crlist[${status.index }].client_no2" value="${i.client_no2 }">
	        				<input type="hidden" name="crlist[${status.index }].connectrequest_no" id="crlist[${status.index }].connectrequest_no" value="${i.connectrequest_no }">
	        				<input type="hidden" name="crlist[${status.index }].requestproduct_no" id="crlist[${status.index }].requestproduct_no" value="${i.requestproduct_no }">
						</td>
						<td><input type="text" name="crlist[${status.index }].connectrequest_qty" id="crlist[${status.index }].connectrequest_qty" value="${i.connectrequest_qty }"></td>
						<td><input type="button" onclick="deleteGoods(${i.requestproduct_no}, ${i.connectrequest_no })" value="delete"></td>
					</tr>
                </c:forEach>
            </table>
        </div>
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 17 }">
           <input type="button" value="update" onclick="sub(this.form)">
           <input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/d/d1/d12/delete?requestproduct_no=${inmap.requestproduct_no }&comcode_code=${comcode_code }'">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d1/d12/inputRequestProduct?comcode_code=${comcode_code }'">
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
        	<div>
        <table>
        	<tr>
        		<th>코드</th>
        		<td><input type="text" name="requestproduct_code" id="requestproduct_code" maxlength="30" class="required" onblur="code(this.value)">
        		<h6 id="requestcode" style="color:red;"></h6></td>
        		<th>의뢰명</th>
        		<td><input type="text" name="requestproduct_name" id="requestproduct_name" class="required" maxlength="50"></td>
        		<th>기간</th>
        		<td><input type="date" name="requestproduct_start" id="requestproduct_start" onchange="startcheck(this.value)"> - <input type="date" name="requestproduct_end" id="requestproduct_end"></td>
        	</tr>
        	<tr>
        		<th colspan="6" align="center">내용</th>
        	</tr>
        	<tr>
        		<td colspan="6"><input type="text" name="requestproduct_content" id="requestproduct_content" class="required"></td>
        	</tr>
        </table>
        
        <table>
            <tr>
                <th rowspan="6">의뢰 거래처<input type="button" onclick="clList('${comcode_code}')" value="search"></th>
                <th>* 사업자등록번호</th>
                <td id="client_registeredno"></td>
                <th>국가명</th>
                <td id="country_name"></td>

                <th rowspan="6">의뢰 담당자</th>
                <th>* 사원코드</th>
                <td id="employee1_code"><input type="text" name="employee1_code" id="employee1_code" onkeypress="searchecode(event, '${comcode_code}')" onblur="searchecode1('${comcode_code}')"></td>
                <th>전화번호</th>
                <td id="employee1_phone"></td>
            </tr>
            
            <tr>
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
                    <th>소비자가</th>
                    <th>단위</th>
                    <th>사양</th>
                    <th>규격</th>
                    <th>포장</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>설명</th>
                    <th>의뢰수량</th>
                </tr>
               	<tr id="procode" class="plist">
					<td>
						<input type="button" onclick="goodsList('${comcode_code}',0)" value="search">
					</td>
					<td><input type="text" name="crlist1[0].goods_name" id="crlist1[0].goods_name" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goods_code" id="crlist1[0].goods_code" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goods_barcode" id="crlist1[0].goods_barcode" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist1[0].goodssort_name" id="crlist1[0].goodssort_name" readonly="readonly">
						<input type="hidden" name="crlist1[0].goodskind_no" id="crlist1[0].goodskind_no">
					</td>
					<td><input type="text" name="crlist1[0].goodslot_price" id="crlist1[0].goodslot_price" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goodsst_unit" id="crlist1[0].goodsst_unit" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goodsst_spec" id="crlist1[0].goodsst_spec" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goodsst_size" id="crlist1[0].goodsst_size" readonly="readonly"></td>
					<td><input type="text" name="crlist1[0].goodsst_package" id="crlist1[0].goodsst_package" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist1[0].client_name1" id="crlist1[0].client_name1" readonly="readonly">
					</td>
					<td>
						<input type="text" name="crlist1[0].client_name2" id="crlist1[0].client_name2" readonly="readonly">
					</td>
					<td><input type="text" name="crlist1[0].goodsst_ea" id="crlist1[0].goodsst_ea" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist1[0].goods_description" id="crlist1[0].goods_description" readonly="readonly">
						<input type="hidden" name="crlist1[0].client_no1" id="crlist1[0].client_no1" value="17">
        				<input type="hidden" name="crlist1[0].client_no2" id="crlist1[0].client_no2" value="17">
					</td>
					<td><input type="text" name="crlist1[0].connectrequest_qty" id="crlist1[0].connectrequest_qty" class="required"></td>
					<td><input type="button" onclick="clearRow(this)" value="delete"></td>
				</tr>
            </table>
            
        </div>
        
	        <div>
	       		<c:if test="${login == 1 || login == 2 || login == 17 }">
	           <input type="button" value="save" onclick="sub(this.form)">
	           <input type="reset" value="reset">
				</c:if>
				<input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d1/d12/inputRequestProduct?comcode_code=${comcode_code }'">
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
document.getElementById("requestproduct_start").setAttribute("min", end+"-01-01");
document.getElementById("requestproduct_start").setAttribute("max", end+"-12-31");

if(document.getElementById("requestproduct_start").value != ""){
	document.getElementById("requestproduct_end").setAttribute("min", document.getElementById("requestproduct_start").value);
	document.getElementById("requestproduct_end").setAttribute("max", end+"-12-31");
}

function startcheck(v){
	document.getElementById("requestproduct_end").value = v;
	document.getElementById("requestproduct_end").setAttribute("min", v);
	document.getElementById("requestproduct_end").setAttribute("max", end+"-12-31");
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
			if(!pat.test(arr.item(14).value)){
				arr.item(14).value = 0;
				alert("숫자만 입력 가능합니다.");
				return;
			}
		}
	}
	
	if(f.requestproduct_code.value == ""){
		f.requestproduct_code.focus();
		return;
	}else if(f.requestproduct_name.value == ""){
		f.requestproduct_name.focus();
		return;
	}else if(f.requestproduct_start.value == ""){
		f.requestproduct_start.focus();
		return;
	}else if(f.requestproduct_end.value == ""){
		f.requestproduct_end.focus();
		return;
	}else if(f.client_name.value == ""){
		f.client_name.focus();
		return;
	}else if(f.employee1_no.value == ""){
		f.employee1_code.focus();
		return;
	}else if(f.requestproduct_content.value == ""){
		var ch = confirm("내용이 입력되지 않았습니다. 등록하시겠습니까?")
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
    if (itemTable.rows.length <= 100) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
        
        
        for (let i = 0; i < 16; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="button" onclick="goodsList(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_name" id="crlist1['+j+'].goods_name" readonly="readonly"></td>';
            } else if (i === 2) {
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_code" id="crlist1['+j+'].goods_code" readonly="readonly"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_barcode" id="crlist1['+j+'].goods_barcode" readonly="readonly"></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodssort_name" id="crlist1['+j+'].goodssort_name" readonly="readonly"><input type="hidden" name="crlist1['+j+'].goodskind_no" id="crlist1['+j+'].goodskind_no"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodslot_price" id="crlist1['+j+'].goodslot_price" readonly="readonly"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_unit" id="crlist1['+j+'].goodsst_unit" readonly="readonly"></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_spec" id="crlist1['+j+'].goodsst_spec" readonly="readonly"></td>';
            } else if (i === 8){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_size" id="crlist1['+j+'].goodsst_size" readonly="readonly"></td>';
            } else if (i === 9){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_package" id="crlist1['+j+'].goodsst_package" readonly="readonly"></td>';
            }  else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].client_name1" id="crlist1['+j+'].client_name1" readonly="readonly"></td>';
            }  else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].client_name2" id="crlist1['+j+'].client_name2" readonly="readonly"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goodsst_ea" id="crlist1['+j+'].goodsst_ea" readonly="readonly"></td>';
            } else if (i === 13){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].goods_description" id="crlist1['+j+'].goods_description" readonly="readonly"></td><input type="hidden" name="crlist1['+j+'].client_no1" id="crlist1['+j+'].client_no1" value="17"><input type="hidden" name="crlist1['+j+'].client_no2" id="crlist1['+j+'].client_no2" value="17"></td>';
            } else if (i === 14){
                cells[i].innerHTML = '<td><input type="text" name="crlist1['+j+'].connectrequest_qty" id="crlist1['+j+'].connectrequest_qty" class="required"></td>';
            } else {
                cells[i].innerHTML = '<td name="b32-clearRow"><input type="button" onclick="clearRow(this)" value="delete"></td>';
            }
        }
        
        if(document.getElementById("crlist1[0].goods_name")){
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

function searchcl(e, code){
	if(e.keyCode == 13){
		var clname = document.getElementById("client_name").value;
		if(clname == ""){
			alert("조회할 거래처명을 입력해주세요.");
			document.getElementById("client_name").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchcl";
		var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
		
		sendRequest(url, param, clName, "POST");
	}
}
function clName(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != null){
			var data2 = JSON.parse(data);	// ajax로 받아온 데이터를 json으로 변형
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


function searchecode(e, code){
	if(e.keyCode == 13){
		var ecode1 = document.getElementById("employee1_code").value;
		if(ecode1 == ""){
			alert("조회할 직원 코드를 입력해주세요.");
			document.getElementById("employee1_code").focus();
			return;
		}
		var url = "${pageContext.request.contextPath}/d/d1/d12/searchecode";
		var param = "employee1_code="+encodeURIComponent(ecode1);
		
		sendRequest(url, param, ecodec, "POST");
	}
}
function ecodec(){
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

function searchecode1(code){
	var ecode1 = document.getElementById("employee1_code").value;
	if(ecode1 == ""){
		alert("조회할 직원 코드를 입력해주세요.");
		document.getElementById("employee1_code").focus();
		return;
	}
	var url = "${pageContext.request.contextPath}/d/d1/d12/searchecode";
	var param = "employee1_code="+encodeURIComponent(ecode1);
	
	sendRequest(url, param, ecode1c, "POST");
}
function ecode1c(){
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

function goodsList(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/goodsList?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function goodsList1(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d12/goodsList1?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
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
				document.getElementById("requestcode").style.color = "red";
				document.getElementById("register").disabled = true;
			}
		}
	}
}

var t = 0;
function deleteGoods(rno, cno){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(list.getElementsByTagName("tr").length < 3){
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
			procode.innerHTML += '<tr><th>제품조회</th><th>상품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>원가</th><th>단위</th><th>사양</th><th>규격</th><th>포장</th><th>제조사</th><th>책임판매업자</th><th>사입량</th><th>설명</th><th>의뢰수량</th></tr>';
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="button" onclick="goodsList1(`${comcode_code}`,'+t+')" value="search"></td>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_name+'" name="crlist1['+t+'].goods_name" id="crlist1['+t+'].goods_name" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_code+'" name="crlist['+t+'].goods_code" id="crlist['+t+'].goods_code" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_barcode+'" name="crlist['+t+'].goods_barcode" id="crlist['+t+'].goods_barcode" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="crlist['+t+'].goodssort_name" id="crlist['+t+'].goodssort_name" value="'+map.goodssort_name+' '+map.goodskind_name+'" readonly="readonly"><input type="hidden" name="crlist['+t+'].goodskind_no" id="crlist['+t+'].goodskind_no" value="'+map.goodskind_no+'" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_price+'" name="crlist['+t+'].goodslot_price" id="crlist['+t+'].goodslot_price" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_unit+'" name="crlist['+t+'].goodsst_unit" id="crlist['+t+'].goodsst_unit" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_spec+'" name="crlist['+t+'].goodsst_spec" id="crlist['+t+'].goodsst_spec" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_size+'" name="crlist['+t+'].goodsst_size" id="crlist['+t+'].goodsst_size" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_package+'" name="crlist['+t+'].goodsst_package" id="crlist['+t+'].goodsst_package" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name1+'" name="crlist['+t+'].client_name1" id="crlist['+t+'].client_name1" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.client_name2+'" name="crlist['+t+'].client_name2" id="crlist['+t+'].client_name2" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_ea+'" name="crlist['+t+'].goodsst_ea" id="crlist['+t+'].goodsst_ea" readonly="readonly">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.goods_description+'" name="crlist['+t+'].goods_description" id="crlist['+t+'].goods_description" readonly="readonly"></td><input type="hidden" name="crlist['+t+'].client_no1" id="crlist['+t+'].client_no1" value="'+map.client_no1+'"><input type="hidden" name="crlist['+t+'].client_no2" id="crlist['+t+'].client_no2" value="'+map.client_no2+'"><input type="hidden" name="crlist['+t+'].connectrequest_no" id="crlist['+t+'].connectrequest_no" value="'+map.connectrequest_no+'"><input type="hidden" name="crlist['+t+'].requestproduct_no" id="crlist['+t+'].requestproduct_no" value="'+map.requestproduct_no+'">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.connectrequest_qty+'" name="crlist['+t+'].connectrequest_qty" id="crlist['+t+'].connectrequest_qty" class="required">';
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
