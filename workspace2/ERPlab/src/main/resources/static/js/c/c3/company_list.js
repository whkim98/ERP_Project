// 회사목록조회 선택버튼
let warehouse_select_btn = document.getElementsByClassName("warehouse_type_select_btn");
for(let i = 0 ; i < warehouse_select_btn.length ; i++) {
	// 회사목록조회 선택버튼 기능추가
	warehouse_select_btn[i].addEventListener('click', (e) => {
		let company_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let company_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("company_name").value = company_name.trimStart().trimEnd();
		opener.document.getElementById("company_no").value = company_no;
		window.close(); 
	});	
}