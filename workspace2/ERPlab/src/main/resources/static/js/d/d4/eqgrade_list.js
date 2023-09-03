// 설비/장비등급조회 선택버튼
let event_select_btn = document.getElementsByClassName("event_type_select_btn");
for(let i = 0 ; i < event_select_btn.length ; i++) {
	event_select_btn[i].addEventListener('click', (e) => {
		let eqgrade_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let eqgrade_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("eqgrade_name").value = eqgrade_name.trimStart().trimEnd();
		opener.document.getElementById("eqgrade_no").value = eqgrade_no;
		window.close(); 
	});	
}