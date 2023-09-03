// 설비/장비종류목록 조회 버튼
let eqkindlist_search_btn = document.getElementById("eqkindlist_search");
eqkindlist_search_btn.addEventListener('click', () => {
	window.open("../d4/eqkind_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 설비/장비등급목록 조회 버튼
let eqgradelist_search_btn = document.getElementById("eqgradelist_search");
eqgradelist_search_btn.addEventListener('click', () => {
	window.open("../d4/eqgrade_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 행사 리스트 클릭시 정보출력
let equipment_items = document.getElementsByClassName("equipment_items");
for(let i = 0; i < equipment_items.length; i++){
	equipment_items[i].addEventListener('click', (e) => {
		//클릭된 행사 색변경
		reset(equipment_items, equipment_items.length, "equipment_items");
		e.target.parentElement.className="equipment_items selected_equipment_items";
		
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
let equipment_container = document.getElementsByClassName("equipment_container");
equipment_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("equipment_regist");
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
			reset(equipment_items, equipment_items.length, "equipment_items");
			empty_inputs();
		}
	}
});

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("equipment_no").value="";
	document.getElementById("equipment_date").value="";
	document.getElementById("eqkind_name").value="";
	document.getElementById("eqkind_no").value="";
	document.getElementById("equipment_code").value="";
	document.getElementById("equipment_name").value="";
	document.getElementById("equipment_production").value="";
	document.getElementById("equipment_expiry").value="";
	document.getElementById("equipment_contents").value="";
	document.getElementById("eqgrade_name").value="";
	document.getElementById("eqgrade_no").value="";
	document.getElementById("equipment_result").value="";
	document.getElementById("equipment_revalue").value="";
	document.getElementById("equipment_remark").value="";
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
		if(inputboxes[i].id=="equipment_no" || inputboxes[i].id=="search_word") continue;
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
let equipment_save_btn = document.getElementById("equipment_save_btn");
equipment_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("equipment_frm").submit();
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
	search_result.innerHTML += '<tr><td>코드</td><td>설비/장비</td><td>설비/장비명</td><td>제조년월</td><td>합/불여부</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.equipment_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.equipment_code;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.equipment_name;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.equipment_production;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.equipment_result;
			newTr.appendChild(newTd);
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="5">목록이 없습니다.</td></tr>';
	}
}

// 설비/장비 수정 버튼
let equipment_update_btn = document.getElementById("equipment_update_btn");
equipment_update_btn.addEventListener('click', () => {
	let equipment_frm = document.getElementById("equipment_frm");
	equipment_frm.action="/d/d42/equipment_update";
	equipment_frm.submit();
});

// 설비/장비 삭제 버튼
let equipment_delete_btn = document.getElementById("equipment_delete_btn");
equipment_delete_btn.addEventListener('click', () => {
	let equipment_frm = document.getElementById("equipment_frm");
	equipment_frm.action="/d/d42/equipment_delete";
	equipment_frm.submit();
});
