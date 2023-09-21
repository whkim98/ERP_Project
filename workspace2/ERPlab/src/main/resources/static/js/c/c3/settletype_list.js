let settletype_select_btn = document.getElementsByClassName("settletype_type_select_btn");
for(let i = 0 ; i < settletype_select_btn.length ; i++) {
	settletype_select_btn[i].addEventListener('click', (e) => {
		let settletype_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let settletype_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("settletype_name").value = settletype_name.trimStart().trimEnd();
		opener.document.getElementById("settletype_no").value = settletype_no;
		window.close(); 
	});	
}