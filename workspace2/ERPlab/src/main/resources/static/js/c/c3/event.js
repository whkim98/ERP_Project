// 상품목록 조회 버튼
let goodslist_search_btn = document.getElementById("goodslist_search");
goodslist_search_btn.addEventListener('click', () => {
	window.open("goods_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 행사 리스트 클릭시 정보출력
let event_items = document.getElementsByClassName("event_items");
for(let i = 0; i < event_items.length; i++){
	event_items[i].addEventListener('click', (e) => {
		//클릭된 행사 색변경
		reset(event_items, event_items.length, "event_items");
		e.target.parentElement.className="event_items selected_event_items";
		
		//클릭시 하단부 버튼 RESET/SAVE -> DELETE/UPDATE로 변경
		buttonController(true);
		
		//클릭시 우측에 회사 정보 출력
		selected_vo(e.target.parentElement.children[0]);
	});
}

// 행사 리스트 클릭시 기타 행사 표시 제거
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
let event_container = document.getElementsByClassName("event_container");
event_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("event_regist");
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
			reset(comp_items, comp_items.length, "comp_items");
			empty_inputs();
		}
	}
});

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("event_no").value="";
	document.getElementById("event_code").value="";
	document.getElementById("event_name").value="";
	document.getElementById("event_start").value="";
	document.getElementById("event_end").value="";
	document.getElementById("event_period").value="";
	document.getElementById("goods_no").value="";
	document.getElementById("event_price").value="";
	document.getElementById("event_qty").value="";
	document.getElementById("event_tax").value="";
	document.getElementById("event_total").value="";
	document.getElementById("event_manager").value="";
	document.getElementById("event_remark").value="";
}

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	errormsg = errormsg == "businesstype_no" ? "company_businesstype" : errormsg;
	if (errormsg != null) document.getElementById(errormsg).focus();
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수


// SAVE 버튼 클릭 기능
let event_save_btn = document.getElementById("event_save_btn");
event_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("event_frm").submit();
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

// 검색결과 출력
function getlist(list){
	let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>행사명</td><td>행사기간</td><td>상품코드</td><td>담당자</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.event_name;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.event_period;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.goods_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.event_manager;
			newTr.appendChild(newTd);
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="4">목록이 없습니다.</td></tr>';
	}
}

// 행사 수정 버튼
let event_update_btn = document.getElementById("event_update_btn");
event_update_btn.addEventListener('click', () => {
	let event_frm = document.getElementById("event_frm");
	event_frm.action="/c/c3/event_update";
	event_frm.submit();
});

// 행사 삭제 버튼
let event_delete_btn = document.getElementById("event_delete_btn");
event_delete_btn.addEventListener('click', () => {
	let event_frm = document.getElementById("event_frm");
	event_frm.action="/c/c3/event_delete";
	event_frm.submit();
});