// 상품목록조회 선택버튼
let event_select_btn = document.getElementsByClassName("event_type_select_btn");
for(let i = 0 ; i < event_select_btn.length ; i++) {
	// 상품목록조회 선택버튼 기능추가
	event_select_btn[i].addEventListener('click', (e) => {
		let goods_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let goods_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("goods_name").value = goods_name.trimStart().trimEnd();
		opener.document.getElementById("goods_no").value = goods_no;
		window.close(); 
	});	
}