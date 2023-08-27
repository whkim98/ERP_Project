// 변수 초기화
let wrapper = document.getElementById("wrapper");

// 사업형태 조회 버튼
let businesstype_search_btn = document.getElementById("businesstype_search");

// 업종코드목록조회 열기 버튼 기능 추가
businesstype_search_btn.addEventListener('click', () => {
	wrapper.style.display="block";
	console.log("### LOG : open businesstype list");
});

// 닫기 버튼
let close_businesstype = document.getElementsByClassName("close_businesstype")[0];
close_businesstype.addEventListener('click', () => {
	businesstype_close_func(); 
});

// 닫기 기능
let businesstype_close_func = () => {
	wrapper.style.display="none";
}

// 업종코드목록조회 선택버튼
let businesstype_select_btn = document.getElementsByClassName("comp_type_select_btn");
for(let i = 0 ; i < businesstype_select_btn.length ; i++) {
	// 업종코드목록조회 선택버튼 기능추가
	businesstype_select_btn[i].addEventListener('click', (e) => {
		let ctgr = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[1].innerHTML;	
		document.getElementById("company_businesstype").value = ctgr.trimStart().split('&gt;')[0].trimEnd();
		let bstno = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		document.getElementById("businesstype_no").value = bstno;
		businesstype_close_func();
	});	
}

// 회사 리스트 클릭시 정보출력
let comp_items = document.getElementsByClassName("comp_items");
for(let i = 0 ; i < comp_items.length; i++){
	comp_items[i].addEventListener('click', (e) => {
<<<<<<< Updated upstream
		console.log("클릭된 태그 : " + e.target.tagName);
		
		//클릭된 회사 색변경
		reset(comp_items, comp_items.length, "comp_items");
		e.target.parentElement.className = "comp_items selected_comp_items";
		
		//클릭시 하단부 버튼 RESET/SAVE -> DELETE/UPDATE로 변경
		buttonController(true);
		
		//클릭시 좌측에 회사 정보 띄우기
=======
		reset(comp_items, comp_items.length, "comp_items");
		e.target.parentElement.className = "comp_items selected_comp_items";
		
		//location.href="/a/a_company?id="+e.target.parentElement.children[0].innerHTML;
>>>>>>> Stashed changes
	});	
}

// 회사 리스트 클릭시 기타 회사는 표시 제거
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
let reset = (taglist, length, className)=>{
	for(let i = 0 ; i < length; i++){
		taglist[i].className = className;
	}
}
<<<<<<< Updated upstream
=======
 
>>>>>>> Stashed changes

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
		}
	}
});

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	errormsg = errormsg == "businesstype_no" ? "company_businesstype" : errormsg;
	if (errormsg != null) {
		document.getElementById(errormsg).focus();
	}  
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수
let empty_input_confirm = () => {
	let inputboxes = document.getElementsByTagName("input");
	let selectboxes = document.getElementsByTagName("select");
	let flag = false;
	for(let i = 0 ; i < inputboxes.length ; i++){
		if (inputboxes[i].value == "" || inputboxes[i].value == null) flag = true; 
		break;
	}
	if(!flag){
		for(let i = 0 ; i < selectboxes.length; i++){
			if(selectboxes[i].selectedIndex == -1) flag= true; 
			break;
		}
	}
	if(flag) {
		let confirm_res = window.confirm("입력되지 않은 사항이 있습니다. 전송하시겠습니까?");
		if(confirm_res) return true;
		else return false;
	}
}

// SAVE 버튼 클릭 기능
let comp_save_btn = document.getElementById("comp_save_btn");
comp_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("comp_frm").submit();
});
