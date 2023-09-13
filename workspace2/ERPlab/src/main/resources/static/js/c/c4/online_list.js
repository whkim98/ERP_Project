let online_select_btn = document.getElementsByClassName("online_type_select_btn");
for(let i = 0 ; i < online_select_btn.length ; i++) {
	online_select_btn[i].addEventListener('click', (e) => {	
		let online_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		opener.document.getElementById("goods_no").value = online_no;
		window.close(); 
	});	
}