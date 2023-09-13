let forsales_select_btn = document.getElementsByClassName("forsales_type_select_btn");
for(let i = 0 ; i < forsales_select_btn.length ; i++) {
	forsales_select_btn[i].addEventListener('click', (e) => {	
		let forsales_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		opener.document.getElementById("goods_no").value = forsales_no;
		window.close(); 
	});	
}