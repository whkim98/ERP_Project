<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/dhlayout/header.jsp" %>
<div class="notosanskr">
	<div class="dh_aligncenter">
    	<h1>BOM 등록</h1>
    </div>
    
    <div class="warning_box">
		<span class="red bigger">* </span>
		<div class="yellow_box"></div>
		<span class="red">는 필수 입력란입니다.</span>
	</div>
    
    <div>
        <c:if test="${inmap != null }">
        <form action="${pageContext.request.contextPath}/d/d1/d18/update">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="goods_no" id="goods_no" value="${inmap.goods_no }">
        <table>
        	<tr>
        		<th>상품코드</th>
        		<td><input type="text" name="goods_code" id="goods_code" value="${inmap.goods_code }" readonly="readonly" class="required"></td>
        		<th>바코드</th>
        		<td><input type="text" name="goods_barcode" id="goods_barcode" value="${inmap.goods_barcode }" readonly="readonly"></td>
        		<th>품명</th>
        		<td><input type="text" name="goods_name" id="goods_name" value="${inmap.goods_name }" readonly="readonly"></td>
        		<th>단위</th>
        		<td><input type="text" name="goodsst_unit" id="goodsst_unit" value="${inmap.goodsst_unit }" readonly="readonly"></td>
        		<th>등급</th>
        		<td><input type="text" name="goodslev_grade" id="goodslev_grade" value="${inmap.goodslev_grade }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>종류</th>
        		<td><input type="text" name="goodskind_name" id="goodskind_name" value="${inmap.goodssort_name } - ${inmap.goodskind_name }" readonly="readonly"></td>
        		<th>규격</th>
        		<td><input type="text" name="goodsst_size" id="goodsst_size" value="${inmap.goodsst_size }" readonly="readonly"></td>
        		<th>제조사</th>
        		<td><input type="text" name="client_name1" id="client_name1" value="${inmap.client_name1 }" readonly="readonly"></td>
        		<th>책임판매업자</th>
        		<td><input type="text" name="client_name2" id="client_name2" value="${inmap.client_name2 }" readonly="readonly"></td>
        		<th>재고수량</th>
        		<td><input type="text" name="goods_stockqty" id="goods_stockqty" value="${inmap.goods_stockqty }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>평균 원가</th>
        		<td colspan="9"><input type="text" name="goodslot_total" id="goodslot_total" value="${inmap.goodslot_total }" readonly="readonly"></td>
        	</tr>
        	<tr>
        		<th>제품 설명</th>
        		<td colspan="9"><input type="text" name="goods_description" id="goods_description" value="${inmap.goods_description }" readonly="readonly"></td>
        	</tr>
         </table>
         
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
                    <th>평균 원가</th>
                    <th>소요량</th>
                    <th>조달구분</th>
                    <th>비고</th>
                    <th>품목삭제</th>
                </tr>
                <c:if test="${blist != null }">
	                <c:forEach var="i" items="${blist }" varStatus="status">
	                	<tr class="plist">
		                	<td><input type="button" onclick="goodsList('${comcode_code}',${status.index })" value="search"></td>
							<td>
								<input type="text" name="crlist1[${status.index }].goods_name" id="crlist1[${status.index }].goods_name" value="${i.goods_name }" readonly="readonly">
								<input type="hidden" name="blist1[${status.index }].goods_no2" id="blist1[${status.index }].goods_no2" value="${i.goods_no2 }" readonly="readonly">
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
							<td><input type="text" name="crlist1[${status.index }].goodslot_total" id="crlist1[${status.index }].goodslot_total" value="${i.goodslot_total }" readonly="readonly"></td>
							<td><input type="text" min="0" maxlength="4" name="blist1[${status.index }].bom_require" id="blist1[${status.index }].bom_require" value="${i.bom_require }" class="required"></td>
							<td><input type="text" name="blist1[${status.index }].bom_obtain" id="blist1[${status.index }].bom_obtain" value="${i.bom_obtain }" class="required"></td>
							<td><input type="text" name="blist1[${status.index }].bom_note" id="blist1[${status.index }].bom_note" value="${i.bom_note }" class="required"></td>
							<td>
								<input type="button" onclick="deleteBom(${i.bom_no})" value="delete">
							</td>
						</tr>
	                </c:forEach>
                </c:if>
                <c:if test="${blist == null }">
                	<tr><td colspan="15" id="d18_bom">목록이 없습니다. 행추가를 클릭하여 원부자재를 추가해주세요.</td></tr>
                </c:if>
            </table>
        </div>
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 17 || login == 7 || login == 8}">
           <input type="button" value="update" onclick="sub(this.form)">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d1/d18/inputBom?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
	</div>
            
    <div>
        <c:if test="${inmap == null }">
        <form action="${pageContext.request.contextPath}/d/d1/d18/createBom">
        	<input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
        	<input type="hidden" name="goods_no" id="goods_no">
        	<div>
	        	<table>
			       	<tr>
			       		<th colspan="4">완성품 등록 시 조회 버튼을 클릭 하여 완성품을 선택해주세요.</th>
			       		<th><input type="button" value="조회" onclick="itemList('${comcode_code}')"></th>
			       	</tr>
			       	<tr>
			       		<th>상품코드</th>
			       		<td><input type="text" name="goods_code" id="goods_code" readonly="readonly" class="required"></td>
			       		<th>바코드</th>
			       		<td><input type="text" name="goods_barcode" id="goods_barcode" readonly="readonly"></td>
			       		<th>품명</th>
			       		<td><input type="text" name="goods_name" id="goods_name" readonly="readonly"></td>
			       		<th>단위</th>
			       		<td><input type="text" name="goodsst_unit" id="goodsst_unit" readonly="readonly"></td>
			       		<th>등급</th>
			       		<td><input type="text" name="goodslev_grade" id="goodslev_grade" readonly="readonly"></td>
			       	</tr>
			       	<tr>
			       		<th>종류</th>
			       		<td><input type="text" name="goodskind_name" id="goodskind_name" readonly="readonly"></td>
			       		<th>규격</th>
			       		<td><input type="text" name="goodsst_size" id="goodsst_size" readonly="readonly"></td>
			       		<th>제조사</th>
			       		<td><input type="text" name="client_name1" id="client_name1" readonly="readonly"></td>
			       		<th>책임판매업자</th>
			       		<td><input type="text" name="client_name2" id="client_name2" readonly="readonly"></td>
			       		<th>재고수량</th>
			       		<td><input type="text" name="goods_stockqty" id="goods_stockqty" readonly="readonly"></td>
			       	</tr>
			       	<tr>
			       		<th>평균 원가</th>
			       		<td colspan="9"><input type="text" name="goodslot_total" id="goodslot_total" readonly="readonly"></td>
			       	</tr>
			       	<tr>
			       		<th>제품 설명</th>
			       		<td colspan="9"><input type="text" name="goods_description" id="goods_description" readonly="readonly"></td>
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
                    <th>평균 원가</th>
                    <th>소요량</th>
                    <th>조달구분</th>
                    <th>비고</th>
                    <th>reset</th>
                </tr>
               	<tr id="procode" class="plist">
					<td><input type="button" onclick="goodsList1('${comcode_code}',0)" value="search"></td>
					<td>
						<input type="text" name="crlist[0].goods_name" id="crlist[0].goods_name" readonly="readonly">
						<input type="hidden" name="blist[0].goods_no2" id="blist[0].goods_no2" readonly="readonly">
					</td>
					<td><input type="text" name="crlist[0].goods_code" id="crlist[0].goods_code" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goods_barcode" id="crlist[0].goods_barcode" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist[0].goodssort_name" id="crlist[0].goodssort_name" readonly="readonly">
					</td>
					<td><input type="text" name="crlist[0].goodsst_unit" id="crlist[0].goodsst_unit" readonly="readonly"></td>
					<td><input type="text" name="crlist[0].goodsst_size" id="crlist[0].goodsst_size" readonly="readonly"></td>
					<td>
						<input type="text" name="crlist[0].client_name1" id="crlist[0].client_name1" readonly="readonly">
					</td>
					<td>
						<input type="text" name="crlist[0].client_name2" id="crlist[0].client_name2" readonly="readonly">
					</td>
					<td><input type="text" name="crlist[0].goodslot_total" id="crlist[0].goodslot_total" readonly="readonly"></td>
					<td><input type="text" min="0" maxlength="4" name="blist[0].bom_require" id="blist[0].bom_require" class="required"></td>
					<td><input type="text" name="blist[0].bom_obtain" id="blist[0].bom_obtain" class="required"></td>
					<td><input type="text" name="blist[0].bom_note" id="blist[0].bom_note" class="required"></td>
					<td>
						<input type="button" onclick="clearRow(this)" value="delete">
					</td>
				</tr>
            </table>
            
        </div>
           
        <div>
        	<c:if test="${login == 1 || login == 2 || login == 17 || login == 7 || login == 8}">
           <input type="button" value="save" id="register" onclick="sub(this.form)">
           <input type="reset" value="reset">
			</c:if>
           <input type="button" value="list" onclick="location.href='${pageContext.request.contextPath}/d/d1/d18/inputBom?comcode_code=${comcode_code }'">
        </div>
        </form>
        </c:if>
    </div>
</div>

<script type="text/javascript">

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
			if(!pat.test(arr.item(11).value)){
				arr.item(11).value = 0;
				alert("숫자만 입력 가능합니다.");
				return;
			}
		}
	}
	
	if(document.getElementById("goods_no").value == ""){
		f.goods_code.focus();
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


const itemTable = document.getElementById('itemTable');

const addRowButton = document.getElementById('addRow');
const deleteRowButton = document.getElementById('deleteRow');

var j = 0;
addRowButton.addEventListener('click', function() {
	if(document.getElementById("d18_bom")){
		document.getElementById("d18_bom").innerHTML = '';
	}
    if (itemTable.rows.length <= 100) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
        
        for (let i = 0; i < 14; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="button" onclick="goodsList1(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_name" id="crlist['+j+'].goods_name" readonly="readonly"><input type="hidden" name="blist['+j+'].goods_no2" id="blist['+j+'].goods_no2"></td>';
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
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goodslot_total" id="crlist['+j+'].goodslot_total" readonly="readonly"></td>';
            } else if (i === 10){
                cells[i].innerHTML = '<td><input type="text" min="0" name="blist['+j+'].bom_require" id="blist['+j+'].bom_require" maxlength="4" class="required"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" name="blist['+j+'].bom_obtain" id="blist['+j+'].bom_obtain" class="required"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="blist['+j+'].bom_note" id="blist['+j+'].bom_note" class="required"></td>';
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


var t = 0;
function deleteBom(no){
	var list = document.getElementById("itemTable");
	var arr = list.getElementsByTagName('input');
	if(list.getElementsByTagName("tr").length < 3){
		alert("상품은 반드시 1개 이상이어야 합니다.");
		return;
	}
	let gno = document.getElementById("goods_no").value;
	var url = "${pageContext.request.contextPath }/d/d1/d18/deleteBom";
	var param = "bom_no="+encodeURIComponent(no)+"&goods_no="+encodeURIComponent(gno);
	
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
			procode.innerHTML += '<tr><th>조회</th><th>품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>단위</th><th>규격</th><th>제조사</th><th>책임판매업자</th><th>평균 원가</th><th>소요량</th><th>조달구분</th><th>비고</th></tr>';
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="button" onclick="goodsList(`${comcode_code}`,'+t+')" value="search"></td>';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<td><input type="text" value="'+map.goods_name+'" name="crlist1['+t+'].goods_name" id="crlist1['+t+'].goods_name" readonly="readonly"><input type="hidden" value="'+map.goods_no2+'" name="blist1['+t+'].goods_no2" id="blist1['+t+'].goods_no2"></td>';
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
				newTd.innerHTML = '<input type="text" value="'+map.goodslot_total+'" name="crlist1['+t+'].goodslot_total" id="crlist1['+t+'].goodslot_total">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" min="0" name="blist1['+t+'].bom_require" id="blist1['+t+'].bom_require" value="'+map.bom_require+'" maxlength="4" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="blist1['+t+'].bom_obtain" id="blist1['+t+'].bom_obtain" value="'+map.bom_obtain+'" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="text" name="blist1['+t+'].bom_note" id="blist1['+t+'].bom_note" value="'+map.bom_note+'" class="required">';
				newTr.appendChild(newTd);
				newTd = document.createElement("td");
				newTd.innerHTML = '<input type="button" onclick="deleteBom('+map.bom_no+')" value="delete">';
				newTr.appendChild(newTd);
				t = Number(t) + 1;
			});
		}else {
			procode.innerHTML = '';
			procode.innerHTML += '<tr><th>조회</th><th>품명</th><th>상품코드</th><th>바코드</th><th>종류</th><th>단위</th><th>규격</th><th>제조사</th><th>책임판매업자</th><th>평균 원가</th><th>소요량</th><th>조달구분</th><th>비고</th></tr>';
			procode.innerHTML += '<tr><td colspan="13">목록이 없습니다.</td></tr>';
		}
	}
}

function goodsList(code, h){
	let cv = document.getElementById("goods_no").value;
	if(cv == ""){
		alert("완성품을 먼저 선택해주세요.");
		document.getElementById("goods_no").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d18/goodsList?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}
function goodsList1(code, h){
	let cv = document.getElementById("goods_no").value;
	if(cv == ""){
		alert("완성품을 먼저 선택해주세요.");
		document.getElementById("goods_no").focus();
		return;
	}
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d18/goodsList1?comcode_code="+code+"&i="+h, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

function itemList(code){
	let openWin = window.open("${pageContext.request.contextPath}/d/d1/d18/itemList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=1000, height=500");
}

</script>
</div>
</body>
</html>