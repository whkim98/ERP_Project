<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<!--  <link rel="stylesheet" href="/css/a/a_company.css" />-->
<style type="text/css">
.notosanskr * { 
 font-family: 'Noto Sans KR', sans-serif;
 font-size:10px;

}

.notosanskr{ 
 	margin-top: 70px;
}



input#search {
background:url(/image/search-glass.png);
background-repeat: no-repeat;
width:20px;
height:20px;
border: 0;
}

</style>

<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
	<div class="taxinvoice-container">
    <h1>공정 재고 관리</h1>
    
    <div class="taxinvoice-lower">
        <c:if test="${inmap != null }">
        <form action="${pageContext.request.contextPath}/d/d1/d17/update">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="company_no" id="company_no" value="${inmap.company_no }">
        	<input type="hidden" name="proinventory_no" id="proinventory_no" value="${inmap.proinventory_no }">
        <table>
        	<tr>
        		<th>회사명</th>
        		<td id="company_name">${inmap.company_name }</td>
        		<th>대표</th>
        		<td id="company_representative">${inmap.company_representative }</td>
        		<th>형태</th>
        		<td id="company_businesstype">${inmap.company_businesstype }</td>
        	</tr>
        	<tr>
        		<th>주소</th>
        		<td id="company_addr1">${inmap.company_addr1 }</td>
        		<th>상세주소</th>
        		<td id="company_addr2">${inmap.company_addr2 }</td>
        		<th>용도</th>
        		<td id="company_use">${inmap.company_use }</td>
        	</tr>
        	<tr>
        		<th>사업자등록번호</th>
        		<td id="company_registeredno">${inmap.company_registeredno }</td>
        		<th>업태</th>
        		<td id="businesstype_name">${inmap.businesstype_name }</td>
        		<th>업종</th>
        		<td id="businesstype_subctgr">${inmap.businesstype_subctgr }</td>
        	</tr>
        	<tr>
        		<th>개업일</th>
        		<td id="company_opendate">${inmap.company_opendate }</td>
        		<th>지점코드</th>
        		<td id="comptype_code">${inmap.comptype_code }</td>
        		<th>구분</th>
        		<td id="comptype_name">${inmap.comptype_name }</td>
        	</tr>
        	<tr align="center">
        		<td colspan="6"><input type="button" value="회사조회" onclick="coList('${comcode_code}')"></td>
        	</tr>
         </table>
         
         <div class="taxinvoice-contentItem">
         	<p>
               <input type="button" id="addRow" value="품목추가">
               <input type="button" id="deleteRow" value="품목삭제">
         	</p>
            <table class="taxinvoice-contentsBody" id="itemTable">
                <tr id="itemTableTitle">
                    <th>수량</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>원가</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>재고</th>
                    <th>실재고</th>
                    <th>사용여부</th>
                    <th>입고일</th>
                </tr>
                <c:forEach var="i" items="${plist }" varStatus="status">
                	<tr class="plist">
	                	<td>
		                	<input type="button" onclick="goodsList('${comcode_code}',${status.index })" value="search">
		                	<input type="text" name="crlist1[${status.index }].goodslot_qty" id="crlist1[${status.index }].goodslot_qty" value="${i.goodslot_qty }" readonly="readonly">
		                </td>
						<td>
							<input type="text" name="crlist1[${status.index }].goods_name" id="crlist1[${status.index }].goods_name" value="${i.goods_name }" readonly="readonly">
							<input type="hidden" name="crlist1[${status.index }].goodslot_no" id="crlist1[${status.index }].goodslot_no" value="${i.goodslot_no }" readonly="readonly">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goods_code" id="crlist1[${status.index }].goods_code" value="${i.goods_code }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goods_barcode" id="crlist1[${status.index }].goods_barcode" value="${i.goods_barcode }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist1[${status.index }].goodssort_name" id="crlist1[${status.index }].goodssort_name" value="${i.goodssort_name } - ${i.goodskind_name}" readonly="readonly">
							<input type="hidden" name="crlist1[${status.index }].goodskind_no" id="crlist1[${status.index }].goodskind_no" value="${i.goodskind_no }">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goodslot_price" id="crlist1[${status.index }].goodslot_price" value="${i.goodslot_price }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goodsst_unit" id="crlist1[${status.index }].goodsst_unit" value="${i.goodsst_unit }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].goodsst_size" id="crlist1[${status.index }].goodsst_size" value="${i.goodsst_size }" readonly="readonly"></td>
						<td>
							<input type="text" name="crlist1[${status.index }].client_name1" id="crlist1[${status.index }].client_name1" value="${i.client_name1}" readonly="readonly">
							<input type="button" onclick="clList1('${comcode_code}',${status.index })" value="search">
						</td>
						<td>
							<input type="text" name="crlist1[${status.index }].client_name2" id="crlist1[${status.index }].client_name2" value="${i.client_name2}" readonly="readonly">
							<input type="button" onclick="clList2('${comcode_code}',${status.index })" value="search">
						</td>
						<td><input type="text" name="crlist1[${status.index }].goodsst_ea" id="crlist1[${status.index }].goodsst_ea" value="${i.goodsst_ea }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].invenlot_qty" id="crlist1[${status.index }].invenlot_qty" value="${i.invenlot_qty }" readonly="readonly"></td>
						<td><input type="text" name="crlist1[${status.index }].invenlot_recode" id="crlist1[${status.index }].invenlot_recode" value="${i.invenlot_recode }" readonly="readonly"></td>
						<td>
							<select name="crlist1[${status.index }].invenlot_availability" id="crlist1[${status.index }].invenlot_availability">
								<option value="">선택</option>
								<option value="0" ${i.invenlot_availability == 0 ? 'selected' : '' }>사용</option>
								<option value="1" ${i.invenlot_availability == 1 ? 'selected' : '' }>미사용</option>
							</select>
						</td>
						<td><input type="date" name="crlist1[${status.index }].invenlot_date" id="crlist1[${status.index }].invenlot_date" value="${i.invenlot_date }" readonly="readonly"></td>
						<td>
							<input type="button" onclick="deleteGoods(${i.invenlot_no},${i.proinventory_no})" value="delete">
							<input type="hidden" name="crlist1[${status.index }].client_no1" id="crlist1[${status.index }].client_no1" value="${i.client_no1 }">
	        				<input type="hidden" name="crlist1[${status.index }].client_no2" id="crlist1[${status.index }].client_no2" value="${i.client_no2 }">
						</td>
					</tr>
                </c:forEach>
            </table>
        </div>
        <div>
           <input type="button" value="update" onclick="sub(this.form)">
           <input type="button" value="delete" onclick="location.href='${pageContext.request.contextPath}/d/d1/d17/delete?proinventory_no=${inmap.proinventory_no }&comcode_code=${comcode_code }'">
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d1/d17/inputProinventory?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
	</div>
            
    <div>
        <c:if test="${inmap == null }">
        <form action="${pageContext.request.contextPath}/d/d1/d17/createProinventory">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="company_no" id="company_no" value="1">
        	<div class="taxinvoice-body">
		        <table>
		        	<tr>
		        		<th>회사명</th>
		        		<td id="company_name"></td>
		        		<th>대표</th>
		        		<td id="company_representative"></td>
		        		<th>형태</th>
		        		<td id="company_businesstype"></td>
		        	</tr>
		        	<tr>
		        		<th>주소</th>
		        		<td id="company_addr1"></td>
		        		<th>상세주소</th>
		        		<td id="company_addr2"></td>
		        		<th>용도</th>
		        		<td id="company_use"></td>
		        	</tr>
		        	<tr>
		        		<th>사업자등록번호</th>
		        		<td id="company_registeredno"></td>
		        		<th>업태</th>
		        		<td id="businesstype_name"></td>
		        		<th>업종</th>
		        		<td id="businesstype_subctgr"></td>
		        	</tr>
		        	<tr>
		        		<th>개업일</th>
		        		<td id="company_opendate"></td>
		        		<th>지점코드</th>
		        		<td id="comptype_code"></td>
		        		<th>구분</th>
		        		<td id="comptype_name"></td>
		        	</tr>
		        	<tr align="center">
		        		<td colspan="6"><input type="button" value="회사조회" onclick="coList('${comcode_code}')"></td>
		        	</tr>
		        </table>
         	</div>
           
        <div class="taxinvoice-contentItem">
            <p>
               <input type="button" id="addRow" value="품목추가">
               <input type="button" id="deleteRow" value="품목삭제">
            </p>
    
            <table class="taxinvoice-contentsBody" id="itemTable">
                <tr id="itemTableTitle">
                    <th>수량</th>
                    <th>상품명</th>
                    <th>상품코드</th>
                    <th>바코드</th>
                    <th>종류</th>
                    <th>원가</th>
                    <th>단위</th>
                    <th>규격</th>
                    <th>제조사</th>
                    <th>책임판매업자</th>
                    <th>사입량</th>
                    <th>재고</th>
                    <th>실재고</th>
                    <th>사용여부</th>
                    <th>입고일</th>
                </tr>
               	<tr id="procode">
					<td>
						<input type="text" name="crlist[0].goodslot_qty" id="crlist[0].goodslot_qty">
						<input type="button" onclick="goodsList1('${comcode_code}',0)" value="search">
					</td>
					<td>
						<input type="text" name="crlist[0].goods_name" id="crlist[0].goods_name">
						<input type="hidden" name="crlist[0].goodslot_no" id="crlist[0].goodslot_no">
					</td>
					<td><input type="text" name="crlist[0].goods_code" id="crlist[0].goods_code"></td>
					<td><input type="text" name="crlist[0].goods_barcode" id="crlist[0].goods_barcode"></td>
					<td>
						<input type="text" name="crlist[0].goodssort_name" id="crlist[0].goodssort_name" readonly="readonly">
						<input type="hidden" name="crlist[0].goodskind_no" id="crlist[0].goodskind_no">
					</td>
					<td><input type="text" name="crlist[0].goodslot_price" id="crlist[0].goodslot_price"></td>
					<td><input type="text" name="crlist[0].goodsst_unit" id="crlist[0].goodsst_unit"></td>
					<td><input type="text" name="crlist[0].goodsst_size" id="crlist[0].goodsst_size"></td>
					<td>
						<input type="text" name="crlist[0].client_name1" id="crlist[0].client_name1" onkeypress="searchcl3(event, '${comcode_code}',0)">
						<input type="button" onclick="clList3('${comcode_code}',0)" value="search">
					</td>
					<td>
						<input type="text" name="crlist[0].client_name2" id="crlist[0].client_name2" onkeypress="searchcl4(event, '${comcode_code}',0)">
						<input type="button" onclick="clList4('${comcode_code}',0)" value="search">
					</td>
					<td><input type="text" name="crlist[0].goodsst_ea" id="crlist[0].goodsst_ea"></td>
					<td><input type="text" name="crlist[0].invenlot_qty" id="crlist[0].invenlot_qty"></td>
					<td><input type="text" name="crlist[0].invenlot_recode" id="crlist[0].invenlot_recode"></td>
					<td>
						<select name="crlist[0].invenlot_availability" id="crlist[0].invenlot_availability">
							<option value="">선택</option>
							<option value="0">사용</option>
							<option value="1">미사용</option>
						</select>
					</td>
					<td><input type="date" name="crlist[0].invenlot_date" id="crlist[0].invenlot_date"></td>
					<td>
						<input type="button" onclick="clearRow(this)" value="delete">
						<input type="hidden" name="crlist[0].client_no1" id="crlist[0].client_no1" value="17">
        				<input type="hidden" name="crlist[0].client_no2" id="crlist[0].client_no2" value="17">
					</td>
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
	if(document.getElementById("company_name").innerText == ""){
		f.company_name.focus();
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
        
        for (let i = 0; i < 16; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodslot_qty" id="crlist['+j+'].goodslot_qty"><input type="button" onclick="goodsList1(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_name" id="crlist['+j+'].goods_name"><input type="hidden" name="crlist['+j+'].goodslot_no" id="crlist['+j+'].goodslot_no"></td>';
            } else if (i === 2) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_code" id="crlist['+j+'].goods_code"></td>';
            } else if (i === 3){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_barcode" id="crlist['+j+'].goods_barcode"></td>';
            } else if (i === 4){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodssort_name" id="crlist['+j+'].goodssort_name" readonly="readonly"><input type="hidden" name="crlist['+j+'].goodskind_no" id="crlist['+j+'].goodskind_no"></td>';
            } else if (i === 5){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodslot_price" id="crlist['+j+'].goodslot_price"></td>';
            } else if (i === 6){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_unit" id="crlist['+j+'].goodsst_unit"></td>';
            } else if (i === 7){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_size" id="crlist['+j+'].goodsst_size"></td>';
            } else if (i === 8){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name1" id="crlist['+j+'].client_name1" onkeypress="searchcl3(event, `${comcode_code}`, '+j+')"><input type="button" onclick="clList3(`${comcode_code}`,'+j+')" value="search"></td>';
            }  else if (i === 9){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].client_name2" id="crlist['+j+'].client_name2" onkeypress="searchcl4(event, `${comcode_code}`, '+j+')"><input type="button" onclick="clList4(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodsst_ea" id="crlist['+j+'].goodsst_ea"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].invenlot_qty" id="crlist['+j+'].invenlot_qty"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].invenlot_recode" id="crlist['+j+'].invenlot_recode"></td>';
            } else if (i === 13){
                cells[i].innerHTML = '<td><select name="crlist['+j+'].invenlot_availability" id="crlist['+j+'].invenlot_availability"><option value="">선택</option><option value="0">사용</option><option value="1">미사용</option></select></td>';
            } else if (i === 14){
                cells[i].innerHTML = '<td><input type="date" name="crlist['+j+'].invenlot_date" id="crlist['+j+'].invenlot_date"></td>';
            } else {
                cells[i].innerHTML = '<td name="b32-clearRow"><input type="button" onclick="clearRow(this)" value="delete"></td></td><input type="hidden" name="crlist['+j+'].client_no1" id="crlist['+j+'].client_no1" value="17"><input type="hidden" name="crlist['+j+'].client_no2" id="crlist['+j+'].client_no2" value="17">';
            }
        }
    } else {
        alert('품목은 최대 16개까지 추가할 수 있습니다.');
    }
    j += 1;
});


deleteRowButton.addEventListener('click', function() {
    const rows = itemTable.getElementsByTagName('tr');
    
    if (itemTable.rows.length > 2) {
    	if(itemTable.getElementsByClassName("plist").length == itemTable.rows.length-1){
    		return;
    	}else{
	    	j -= 1;
	        itemTable.deleteRow(itemTable.rows.length-1);
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


function coList(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d17/coList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}


var t = 0;
function deleteGoods(ino, pno){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(arr.length == 0){
		alert("상품은 반드시 1개 이상이어야 합니다.");
		return;
	}
	var url = "${pageContext.request.contextPath }/d/d1/d17/deleteGoods";
	var param = "invenlot_no="+encodeURIComponent(ino)+"&proinventory_no="+encodeURIComponent(pno);
	
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
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_qty+'" name="crlist['+t+'].goodslot_qty" id="crlist['+t+'].goodslot_qty">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goods_name+'" name="crlist['+t+'].goods_name" id="crlist['+t+'].goods_name"><input type="hidden" value="'+map.goodslot_no+'" name="crlist['+t+'].goodslot_no" id="crlist['+t+'].goodslot_no">';
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
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_price+'" name="crlist['+t+'].goodslot_price" id="crlist['+t+'].goodslot_price">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_unit+'" name="crlist['+t+'].goodsst_unit" id="crlist['+t+'].goodsst_unit">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" value="'+map.goodsst_size+'" name="crlist['+t+'].goodsst_size" id="crlist['+t+'].goodsst_size">';
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
				newTd.innerHTML = '<input type="button" onclick="deleteGoods('+map.invenlot_no+', '+map.proinventory_no+')" value="delete">';
				newTr.appendChild(newTd);
				t = Number(t) + 1;
			});
		}else {
			procode.innerHTML = '';
			procode.innerHTML += '<tr><td colspan="13">목록이 없습니다.</td></tr>';
		}
	}
}

function goodsList(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d17/goodsList?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function goodsList1(code, h){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d17/goodsList1?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

</script>
</div>
</body>
</html>