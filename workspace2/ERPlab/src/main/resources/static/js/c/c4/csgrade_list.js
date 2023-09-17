let csgrade_select_btn = document.getElementsByClassName("csgrade_type_select_btn");
for(let i = 0 ; i < csgrade_select_btn.length ; i++) {
	csgrade_select_btn[i].addEventListener('click', (e) => {
		let csgrade_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let csgrade_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("csgrade_name").value = csgrade_name.trimStart().trimEnd();
		opener.document.getElementById("csgrade_no").value = csgrade_no;
		window.close(); 
	});	
}