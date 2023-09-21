// 조회 버튼
let forsaleslist_search_btn = document.getElementById("forsaleslist_search");
forsaleslist_search_btn.addEventListener('click', () => {
	window.open("../c3/forsales_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let localsaleslist_search_btn = document.getElementById("forsaleslist_search");
localsaleslist_search_btn.addEventListener('click', () => {
	window.open("../c3/localsales_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let storesaleslist_search_btn = document.getElementById("storesaleslist_search");
storesaleslist_search_btn.addEventListener('click', () => {
	window.open("../c3/storesales_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let onlinelist_search_btn = document.getElementById("onlinelist_search");
onlinelist_search_btn.addEventListener('click', () => {
	window.open("../c3/online_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 행사 리스트 클릭시 정보출력
let salesresult_items = document.getElementsByClassName("salesresult_items");
for(let i = 0; i < salesresult_items.length; i++){
	salesresult_items[i].addEventListener('click', (e) => {
		//클릭된 행사 색변경
		reset(salesresult_items, salesresult_items.length, "salesresult_items");
		e.target.parentElement.className="salesresult_items selected_salesresult_items";
		
		//클릭시 하단부 버튼 RESET/SAVE -> DELETE/UPDATE로 변경
		buttonController(true);
		
		//클릭시 우측에 회사 정보 출력
		selected_vo(e.target.parentElement.children[0]);
	});
}

// 행사 리스트 클릭시 기타 회사는 표시 제거
let reset = (taglist, length, className)=>{
	for(let i = 0 ; i < length; i++){
		taglist[i].className = className;
	}
}

// 클릭시 하단부 RESET/SAVE <-> DELETE/UPDATE 변경 함수 
let buttonController = (status) => {
	if (status == true) {
		document.getElementById("old_btn_sec").style.display="block";
		document.getElementById("new_btn_sec").style.display="none";
	}
	else {
		document.getElementById("old_btn_sec").style.display="none";
		document.getElementById("new_btn_sec").style.display="block";
	}
}

// input, label, 리스트 제외한 다른 영역 클릭시 DELETE/UPDATE -> RESET/SAVE 로 변경
let salesresult_container = document.getElementsByClassName("salesresult_container");
salesresult_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("salesresult_regist");
	let labelarea = document.getElementsByTagName("label");
	let inputarea = document.getElementsByTagName("input");
	
	if(e.target.contains(listarea[0])){
		//여기는 입력란 타입(input 타입별, selectbox, checkbox 등등)마다 for문 요구
		let flag = true;
		for(let i = 0 ; i < labelarea.length; i++)
			if(!e.target.contains(labelarea[i])){ flag=false; break; }
		for(let i = 0 ; i < inputarea.length; i++)
			if(!e.target.contains(inputarea[i])){ flag=false; break; }
			
		if(flag) {
			buttonController(false);
			reset(salesresult_items, salesresult_items.length, "salesresult_items");
			empty_inputs();
		}
	}
});

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("salesresult_no").value="";
	document.getElementById("ctgr_no").value="";
	document.getElementById("salesresult_start").value="";
	document.getElementById("salesresult_end").value="";
	document.getElementById("salesresult_goal").value="";
	document.getElementById("forsales_no").value="";
	document.getElementById("localsales_no").value="";
	document.getElementById("storesales_no").value="";
	document.getElementById("online_no").value="";
	document.getElementById("salesresult_achieve").value="";
}

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	if (errormsg != null) document.getElementById(errormsg).focus();
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수
let empty_input_confirm = () => {
	let inputboxes = document.getElementsByTagName("input");
	let selectboxes = document.getElementsByTagName("select");
	let flag = false;
	let tagName = "";
	for(let i = 0 ; i < inputboxes.length ; i++){
		if(inputboxes[i].id=="salesresult_no" || inputboxes[i].id=="search_word") continue;
		else{
			if (inputboxes[i].value == "" || inputboxes[i].value == null) {
				flag = true;
				tagName = inputboxes[i].id
				break;
			}
		}
	}
	if(!flag){
		for(let i = 0 ; i < selectboxes.length; i++){
			if(selectboxes[i].id =="search_type") continue;
			if(selectboxes[i].selectedIndex == -1) {
				flag= true;
				tagName=selectboxes[i].id;
				break;
			} 
		}
	}
	if(flag) {
		let confirm_res = window.confirm("입력되지 않은 사항이 있습니다. 전송하시겠습니까? " + tagName);
		if(confirm_res) return true;
		else return false;
	}
	else return !flag;
}

// SAVE 버튼 클릭 기능
let salesresult_save_btn = document.getElementById("salesresult_save_btn");
salesresult_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("salesresult_frm").submit();
});

// 행사리스트 검색조회
let search_word = document.getElementById("search_word");
let word="";
let select_value = "all";
search_word.addEventListener('keyup', (e) => {
	word = e.target.value;
	let search_res = search_filter(select_value, word);
	if(search_res != null) getlist(search_res);
});

// 검색어 입력 '후' 타입을 변경할 시, 해당 타입 적용을 위한 이벤트 추가
let search_type = document.getElementById("search_type");
search_type.addEventListener('change', ()=>{
	select_value = search_type.options[search_type.selectedIndex].value;
	let search_res = search_filter(select_value, word);
	if (search_res != null) getlist(search_res);
});

// 행사리스트 검색 조회 결과 출력 기능
function getlist(list){
	let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>코드</td><td>시작일</td><td>종료일</td><td>달성률</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.salesresult_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.salesresult_start;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.salesresult_end;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.salesresult_achieve;
			newTr.appendChild(newTd);
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
	}
}

// 행사 수정 버튼
let salesresult_update_btn = document.getElementById("salesresult_update_btn");
salesresult_update_btn.addEventListener('click', () => {
	let salesresult_frm = document.getElementById("salesresult_frm");
	salesresult_frm.action="/c/c41/salesresult_update";
	salesresult_frm.submit();
});

// 행사 삭제 버튼
let salesresult_delete_btn = document.getElementById("salesresult_delete_btn");
salesresult_delete_btn.addEventListener('click', () => {
	let salesresult_frm = document.getElementById("salesresult_frm");
	salesresult_frm.action="/c/c41/salesresult_delete";
	salesresult_frm.submit();
});

// 시작기간 자동 계산 함수
let salesresult_period_calc = () => {
	let start = document.getElementById("salesresult_start").valueAsNumber;
	let end = document.getElementById("salesresult_end").valueAsNumber;
	if(start && end){
		let chker_res = incorrect_salesresult_period_chker(start, end);
		if(chker_res){
			let period = end-start;
			let day = period/86400000;
			document.getElementById("salesresult_period").value= day+1;	
		}
	}
}

// 종료기간 오입력시 알림창 출력 및 값 제거
let incorrect_salesresult_period_chker = (start, end) => {
	if(start > end) {
		alert("행사기간이 잘못 입력되었습니다.");
		document.getElementById("salesresult_start").value="";
		document.getElementById('salesresult_end').value="";
		document.getElementById("salesresult_start").focus();
		return false;
	}
	return true;
}

// 행사기간 자동 계산
let salesresult_start = document.getElementById("salesresult_start");
salesresult_start.addEventListener("change", salesresult_period_calc);
let salesresult_end = document.getElementById("salesresult_end");
salesresult_end.addEventListener("change", salesresult_period_calc);


const addRowButton = document.getElementById('addRow');
const deleteRowButton = document.getElementById('deleteRow');

var j = 0;
addRowButton.addEventListener('click', function() {
    if (itemTable.rows.length <= 100) {
        const newRow = itemTable.insertRow(-1);
        const cells = [];
        if(document.getElementById("crlist[0].goods_name")){
       		j += 1;
        }
        for (let i = 0; i < 15; i++) {
            cells.push(newRow.insertCell(i));
            if (i === 0) {
                cells[i].innerHTML = '<td><input type="button" onclick="goodsList1(`${comcode_code}`,'+j+')" value="search"></td>';
            } else if (i === 1) {
                cells[i].innerHTML = '<td><input type="text" name="crlist['+j+'].goods_name" id="crlist['+j+'].goods_name" readonly="readonly"><input type="hidden" name="oclist['+j+'].goods_no" id="oclist['+j+'].goods_no"></td>';
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
                cells[i].innerHTML = '<td><input type="text" min="0" name="oclist['+j+'].orderconnect_qty" id="oclist['+j+'].orderconnect_qty" maxlength="4" class="required"></td>';
            } else if (i === 11){
                cells[i].innerHTML = '<td><input type="text" min="0" name="oclist['+j+'].orderconnect_price" id="oclist['+j+'].orderconnect_price" onblur="conculator11('+j+',this.value)" onkeyup="conculator21('+j+',event, this.value)" class="required"></td>';
            } else if (i === 12){
                cells[i].innerHTML = '<td><input type="text" name="oclist['+j+'].orderconnect_tax" id="oclist['+j+'].orderconnect_tax" readonly="readonly"></td>';
            } else if (i === 13){
                cells[i].innerHTML = '<td><input type="text" name="oclist['+j+'].orderconnect_total" id="oclist['+j+'].orderconnect_total" readonly="readonly"></td>';
            } else {
                cells[i].innerHTML = '<td><input type="button" onclick="clearRow(this)" value="delete"></td>';
            }
        }
        
        for(let u = 1; u < itemTable.getElementsByTagName("tr").length; u++){
            itemTable.getElementsByTagName("tr").item(u).setAttribute("class", "plist");
        }
        
    } else {
        alert('품목은 최대 100개까지 추가할 수 있습니다.');
    }
    
});