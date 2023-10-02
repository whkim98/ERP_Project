window.onload=()=>{
	let closing_items = document.getElementsByClassName("closing_items");
	for(let i = 0 ; i < closing_items.length; i++){
		let ctgr_no = closing_items[i].children(2).innerHTML;
		let dept_name = ret_dept_name(ctgr_no);	
		closing_items[i].children(2).innerHTML = ctgr_no + "[" + dept_name +"]";
	}
	replace_dept_sum();
	ret_dept_sum();
	
}

let replace_dept_sum = () => {
	document.getElementsByClassName("deptsales_list")[0].innerHTML = document.getElementsByClassName("deptsales_list")[0].innerHTML.replace(
		'<tr class="to_be_replaced"></tr>', 
		'<tr class="dept_sum_result"><th class="sum_ctgr_no sum_result_title">코드</th><th class="sum_ctgr_no_ret"></th><th class="sum_dept_name sum_result_title">부서</th><th class="sum_dept_name_ret"></th><th class="sum_debtor sum_result_title">차변</th><th class="sum_debtor_ret"></th><th class="sum_creditor sum_result_title">대변</th><th class="sum_creditor_ret"></th></tr><tr class="dept_sum_result"><th class="sum_ctgr_no sum_result_title">코드</th><th class="sum_ctgr_no_ret"></th><th class="sum_dept_name sum_result_title">부서</th><th class="sum_dept_name_ret"></th><th class="sum_debtor sum_result_title">차변</th><th class="sum_debtor_ret"></th><th class="sum_creditor sum_result_title">대변</th><th class="sum_creditor_ret"></th></tr><tr class="dept_sum_result"><th class="sum_ctgr_no sum_result_title">코드</th><th class="sum_ctgr_no_ret"></th><th class="sum_dept_name sum_result_title">부서</th><th class="sum_dept_name_ret"></th><th class="sum_debtor sum_result_title">차변</th><th class="sum_debtor_ret"></th><th class="sum_creditor sum_result_title">대변</th><th class="sum_creditor_ret"></th></tr><tr class="dept_sum_result"><th class="sum_ctgr_no sum_result_title">코드</th><th class="sum_ctgr_no_ret"></th><th class="sum_dept_name sum_result_title">부서</th><th class="sum_dept_name_ret"></th><th class="sum_debtor sum_result_title">차변</th><th class="sum_debtor_ret"></th><th class="sum_creditor sum_result_title">대변</th><th class="sum_creditor_ret"></th></tr>'
	);
}

