let goodslot_type_select_btn = document.getElementsByClassName("goodslot_type_select_btn");
for(let i = 0 ; i < goodslot_type_select_btn.length ; i++) {
	goodslot_type_select_btn[i].addEventListener('click', (e) => {
		let goodslot_lot = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[0].innerHTML;	
		let goodslot_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[2].innerHTML;
		let goods_no = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[3].innerHTML
		let content = e.target.parentElement.parentElement.parentElement.parentElement.children[0].children[0].children[1].innerHTML;
		let content_list = content.split("<br>")
		let order = document.getElementById("order_value").innerHTML;
		
		opener.document.getElementById("goodslot_no"+order).value = goodslot_no;		
		opener.document.getElementById("salesgoods_qty"+order).value = content_list[0].split(':')[1].trimStart().trimEnd();
		opener.document.getElementById("salesgoods_price"+order).value = content_list[3].split(':')[1].trimStart().trimEnd();
		opener.document.getElementById("goods_no"+order).value = goods_no;
		
		window.close(); 
	});	
}