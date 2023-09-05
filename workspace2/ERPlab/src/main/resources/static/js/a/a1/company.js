// 사업형태 조회 버튼
let businesstype_search_btn = document.getElementById("businesstype_search");

// 업종코드목록조회 열기 버튼 기능 추가
businesstype_search_btn.addEventListener('click', () => {
	window.open("businesstype_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 회사 리스트 클릭시 정보출력
let comp_items = document.getElementsByClassName("comp_items");
for(let i = 0 ; i < comp_items.length; i++){
	comp_items[i].addEventListener('click', (e) => {		
		//클릭된 회사 색변경
		reset(comp_items, comp_items.length, "comp_items");
		e.target.parentElement.className = "comp_items selected_comp_items";
		
		//클릭시 하단부 버튼 RESET/SAVE -> DELETE/UPDATE로 변경
		buttonController(true);
		
		//클릭시 우측에 회사 정보 출력
		selected_vo(e.target.parentElement.children[0]);
	});	
}

// 회사 리스트 클릭시 기타 회사는 표시 제거
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
let comp_container = document.getElementsByClassName("comp_container");
comp_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("comp_regist");
	let labelarea = document.getElementsByTagName("label");
	let inputarea = document.getElementsByTagName("input");
	let selectarea = document.getElementsByTagName("select");
		
	if(e.target.contains(listarea[0])){
		//여기는 입력란 타입(input 타입별, selectbox, checkbox 등등)마다 for문 요구
		let flag = true;
		for(let i = 0 ; i < labelarea.length; i++)
			if(!e.target.contains(labelarea[i])){ flag=false; break; }
		for(let i = 0 ; i < inputarea.length; i++)
			if(!e.target.contains(inputarea[i])){ flag=false; break; }
		for(let i = 0; i < selectarea.length; i++)
			if(!e.target.contains(selectarea[i])){ flag=false; break; }
		 
		if(flag) {
			buttonController(false);
			reset(comp_items, comp_items.length, "comp_items");
			empty_inputs();
		}
	}
}); 

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("company_no").value="";
	document.getElementById("comptype_no").value="";
	document.getElementById("company_name").value="";
	document.getElementById("company_registeredno").value="";
	document.getElementById("company_corporatedno").value="";
	document.getElementById("company_representative").value="";
	document.getElementById("company_businesstype").value="";
	document.getElementById("businesstype_no").value="";
	document.getElementById("company_addr1").value="";
	document.getElementById("company_addr2").value="";
	document.getElementById("company_postal").value="";
	document.getElementById("company_opendate").value="";
	document.getElementById("company_use").value="";
	document.getElementById("company_foreign").value="";
	document.getElementById("company_directno").value="";
	document.getElementById("company_fax").value="";
	document.getElementById("company_email").value="";
}

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	errormsg = errormsg == "businesstype_no" ? "company_businesstype" : errormsg;
	if (errormsg != null) document.getElementById(errormsg).focus();
	
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수
let empty_input_confirm = () => {
	let inputboxes = document.getElementsByTagName("input");
	let selectboxes = document.getElementsByTagName("select");
	let flag = false;
	let tagName = "";
	for(let i = 0 ; i < inputboxes.length ; i++){
		if(inputboxes[i].id=="company_no" || inputboxes[i].id=="search_word") continue;
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
let comp_save_btn = document.getElementById("comp_save_btn");
comp_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("comp_frm").submit();
});

// 회사리스트 검색조회
let search_word = document.getElementById("search_word");
let word = "";
let select_value = "all";
search_word.addEventListener('keyup', (e) => {
	word = e.target.value;
	let search_res = search_filter(select_value, word);
	if (search_res != null) getlist(search_res);
});

// 검색어 입력 '후' 타입을 변경할 시, 해당 타입 적용을 위한 이벤트 추가
let search_type = document.getElementById("search_type");
search_type.addEventListener('change', ()=>{
	select_value = search_type.options[search_type.selectedIndex].value;
	let search_res = search_filter(select_value, word);
	if (search_res != null) getlist(search_res);
});

// 회사리스트 검색 조회 결과 출력 기능
function getlist(list){
	let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>코드</td><td>회사명</td><td>구분</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.company_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.company_name;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.comptype_no;
			newTr.appendChild(newTd);
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
	}
}

// 회사 수정 버튼
let comp_update_btn = document.getElementById("comp_update_btn");
comp_update_btn.addEventListener('click', () => {
	let comp_frm = document.getElementById("comp_frm");
	comp_frm.action="/a/a1/company_update";
	comp_frm.submit();
});


// 회사 삭제 버튼
let comp_delete_btn = document.getElementById("comp_delete_btn");
comp_delete_btn.addEventListener('click', () => {
	let comp_frm = document.getElementById("comp_frm");
	comp_frm.action="/a/a1/company_delete";
	comp_frm.submit();
});


