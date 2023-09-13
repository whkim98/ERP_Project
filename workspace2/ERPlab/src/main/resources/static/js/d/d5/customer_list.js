let customer_select_btn = document.getElementsByClassName("customer_type_select_btn");
for(let i = 0 ; i < customer_select_btn.length ; i++) {
	customer_select_btn[i].addEventListener('click', (e) => {
		let customer_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let customer_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("customer_name").value = customer_name.trimStart().trimEnd();
		opener.document.getElementById("customer_no").value = customer_no;
		window.close(); 
	});	
}