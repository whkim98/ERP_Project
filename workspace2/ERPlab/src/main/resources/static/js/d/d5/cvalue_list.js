let cvalue_select_btn = document.getElementsByClassName("cvalue_type_select_btn");
for(let i = 0 ; i < cvalue_select_btn.length ; i++) {
	cvalue_select_btn[i].addEventListener('click', (e) => {
		let cvalue_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let cvalue_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("cvalue_name").value = cvalue_name.trimStart().trimEnd();
		opener.document.getElementById("cvalue_no").value = cvalue_no;
		window.close(); 
	});	
}