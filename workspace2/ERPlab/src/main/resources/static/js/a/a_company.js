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
		//reset(comp_items, comp_items.length, "comp_items");
		//e.target.parentElement.className = "comp_items selected_comp_items";
		
		location.href="/a/a_company?id="+e.target.parentElement.children[0].innerHTML;
	});	
}

// 회사 리스트 클릭시 기타 회사는 표시 제거
/*
let reset = (taglist, length, className)=>{
	for(let i = 0 ; i < length; i++){
		taglist[i].className = className;
	}
}
 */


