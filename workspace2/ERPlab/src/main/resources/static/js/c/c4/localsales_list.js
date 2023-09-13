let localsales_select_btn = document.getElementsByClassName("localsales_type_select_btn");
for(let i = 0 ; i < localsales_select_btn.length ; i++) {
	localsales_select_btn[i].addEventListener('click', (e) => {	
		let localsales_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		opener.document.getElementById("goods_no").value = localsales_no;
		window.close(); 
	});	
}