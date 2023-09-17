let client_select_btn = document.getElementsByClassName("client_type_select_btn");
for(let i = 0 ; i < client_select_btn.length ; i++) {
	client_select_btn[i].addEventListener('click', (e) => {
		let client_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let client_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("client_name").value = client_name.trimStart().trimEnd();
		opener.document.getElementById("client_no").value = client_no;
		window.close(); 
	});	
}