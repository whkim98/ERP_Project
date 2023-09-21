let team_select_btn = document.getElementsByClassName("team_type_select_btn");
for(let i = 0 ; i < team_select_btn.length ; i++) {
	team_select_btn[i].addEventListener('click', (e) => {
		let team_name = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let team_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		
		opener.document.getElementById("team_name").value = team_name.trimStart().trimEnd();
		opener.document.getElementById("team_no").value = team_no;
		window.close(); 
	});	
}