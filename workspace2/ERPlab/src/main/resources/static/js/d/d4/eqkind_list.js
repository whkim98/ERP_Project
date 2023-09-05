// 설비/장비종류조회 선택버튼
let event_select_btn = document.getElementsByClassName("eqkind_type_select_btn");
for(let i = 0 ; i < event_select_btn.length ; i++) {
	event_select_btn[i].addEventListener('click', (e) => {
		let eqkind_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let eqkind_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("eqkind_name").value = eqkind_name.trimStart().trimEnd();
		opener.document.getElementById("eqkind_no").value = eqkind_no;
		window.close(); 
	});	
}