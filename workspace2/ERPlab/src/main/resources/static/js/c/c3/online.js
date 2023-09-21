let ctgr_search_btn = document.getElementById("ctgrlist_search");
ctgr_search_btn.addEventListener('click', () => {
	window.open("../c3/ctgr_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let teamlist_search_btn = document.getElementById("teamlist_search");
teamlist_search_btn.addEventListener('click', () => {
	window.open("../c3/team_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let customerlist_search_btn = document.getElementById("customerlist_search");
customerlist_search_btn.addEventListener('click', () => {
	window.open("../c3/customer_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let settletypelist_search_btn = document.getElementById("settletypelist_search");
settletypelist_search_btn.addEventListener('click', () => {
	window.open("../c3/settletype_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 행사 리스트 클릭시 정보출력
let online_items = document.getElementsByClassName("online_items");
for(let i = 0; i < online_items.length; i++){
	online_items[i].addEventListener('click', (e) => {
		//클릭된 행사 색변경
		reset(online_items, online_items.length, "online_items");
		e.target.parentElement.className="online_items selected_online_items";
		
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
let online_container = document.getElementsByClassName("online_container");
online_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("online_regist");
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
			reset(online_items, online_items.length, "online_items");
			empty_inputs();
		}
	}
});

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("online_no").value="";
	document.getElementById("ctgr_no").value="";
	document.getElementById("online_code").value="";
	document.getElementById("team_no").value="";
	document.getElementById("online_date").value="";
	document.getElementById("customer_no").value="";
	document.getElementById("settletype_no").value="";
}

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	errormsg = errormsg == "eqkind_no" ? "eqkind_name" : errormsg == "eqgrade_no" ? "eqgrade_name" : errormsg;
	if (errormsg != null) document.getElementById(errormsg).focus();
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수
let empty_input_confirm = () => {
	let inputboxes = document.getElementsByTagName("input");
	let selectboxes = document.getElementsByTagName("select");
	let flag = false;
	let tagName = "";
	for(let i = 0 ; i < inputboxes.length ; i++){
		if(inputboxes[i].id=="online_no" || inputboxes[i].id=="search_word") continue;
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
let online_save_btn = document.getElementById("online_save_btn");
online_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("online_frm").submit();
});

// 설비/장비리스트 검색조회
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

// 설비/장비리스트 검색 조회 결과 출력 기능
function getlist(list){
	let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>코드</td><td>온라인매출코드</td><td>매출일자</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_code;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_date;
			newTr.appendChild(newTd);
			
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
	}
}

// 설비/장비 수정 버튼
let online_update_btn = document.getElementById("online_update_btn");
online_update_btn.addEventListener('click', () => {
	let online_frm = document.getElementById("online_frm");
	online_frm.action="/c/c34/online_update";
	online_frm.submit();
});

// 설비/장비 삭제 버튼
let online_delete_btn = document.getElementById("online_delete_btn");
online_delete_btn.addEventListener('click', () => {
	let online_frm = document.getElementById("online_frm");
	online_frm.action="/c/c34/online_delete";
	online_frm.submit();
});


let list_result_td_arr = [];
list_result_td_arr[0]= '<button class="list_result_btn" id="list_result_search0">SEARCH</button>';
list_result_td_arr[1]= '<input type="text" name="goodslot_no" id="goodslot_no0"/>';
list_result_td_arr[2]= '<input type="text" name="goodslot_qty" id="goodslot_qty0"/>';
list_result_td_arr[3]= '<input type="text" name="goodslot_production" id="goodslot_production0"/>';
list_result_td_arr[4]= '<input type="text" name="goodslot_expiry" id="goodslot_expiry0"/>';
list_result_td_arr[5]= '<input type="text" name="goodslot_total" id="goodslot_total0"/>';
list_result_td_arr[6]= '<button class="list_result_btn" id="list_result_del0">품목삭제</button>'


// 행추가 버튼
let addRow_btn = document.getElementById("addRow_btn");
addRow_btn.addEventListener("click", () => {
	let listtr = document.getElementsByClassName("list_result_items");
	let order = listtr[0].className.split(' ')[1].slice(5)
	console.log("order : " + order);
	let newTr = document.createElement("tr");
	let newTd1 = document.createElement("td");
	newTd1.innerHTML = '<button type="button" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd2 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd3 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd4 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd5 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd6 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	let newTd7 = document.createElement("td");
	newTd1.innerHTML = '<input type="text" name="goodslot_no" />'
	newTr.appendChild(newTd1);
	
});

// 예시
let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>코드</td><td>온라인매출코드</td><td>매출일자</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_code;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.online_date;
			newTr.appendChild(newTd);
			
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
	}

// 행삭제 버튼

// 행조회 버튼

// 품목삭제 버튼

//
