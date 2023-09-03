// 업종코드목록조회 선택버튼
let businesstype_select_btn = document.getElementsByClassName("comp_type_select_btn");
for(let i = 0 ; i < businesstype_select_btn.length ; i++) {
	// 업종코드목록조회 선택버튼 기능추가
	businesstype_select_btn[i].addEventListener('click', (e) => {
		let ctgr = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[1].innerHTML;	
		let bstno = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("company_businesstype").value = ctgr.trimStart().split('&gt;')[0].trimEnd();
		opener.document.getElementById("businesstype_no").value = bstno;
		window.close(); 
	});	
}