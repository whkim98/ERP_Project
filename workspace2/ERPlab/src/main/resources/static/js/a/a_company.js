// 사업형태 조회 버튼
let businesstype_search_btn = document.getElementById("businesstype_search");

// 업종코드목록조회 열기 버튼
businesstype_search_btn.addEventListener("click", function(){
	document.getElementById("wrapper").style.display="block";
	console.log("### LOG : businesstype search");
});

// 업종코드목록조회 선택버튼
let businesstype_select_btn = document.getElementsByClassName("comp_type_select_btn");

// 업종코드목록 선택버튼
businesstype_select_btn.addEventListender("click", function(){
	//TODO
});

// 닫기 버튼
let close_businesstype = document.getElementsByClassName("close_businesstype");
close_businesstype.addEventListener("click", businesstype_close_func);

// 닫기 기능
let businesstype_close_func = () => {
		document.getElementById("wrapper").style.display="none";
}
