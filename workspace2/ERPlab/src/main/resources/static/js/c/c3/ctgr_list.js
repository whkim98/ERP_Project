let ctgr_select_btn = document.getElementsByClassName("ctgr_type_select_btn");
for(let i = 0 ; i < ctgr_select_btn.length ; i++) {
	ctgr_select_btn[i].addEventListener('click', (e) => {
		let ctgr_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let ctgr_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("ctgr_name").value = ctgr_name.trimStart().trimEnd();
		opener.document.getElementById("ctgr_no").value = ctgr_no;
		window.close(); 
	});	
}