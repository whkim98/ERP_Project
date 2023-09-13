let storesales_select_btn = document.getElementsByClassName("storesales_type_select_btn");
for(let i = 0 ; i < storesales_select_btn.length ; i++) {
	storesales_select_btn[i].addEventListener('click', (e) => {	
		let storesales_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		opener.document.getElementById("goods_no").value = storesales_no;
		window.close(); 
	});	
}