let ctgr_search_btn = document.getElementById("ctgrlist_search");
ctgr_search_btn.addEventListener('click', () => {
	window.open("../c3/ctgr_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let companylist_search_btn = document.getElementById("companylist_search");
companylist_search_btn.addEventListener('click', () => {
	window.open("../c3/company_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let customerlist_search_btn = document.getElementById("customerlist_search");
customerlist_search_btn.addEventListener('click', () => {
	window.open("../c3/customer_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

let settletypelist_search_btn = document.getElementById("settletypelist_search");
settletypelist_search_btn.addEventListener('click', () => {
	window.open("../c3/settletype_list", "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
});

// 행사 리스트 클릭시 정보출력
let storesales_items = document.getElementsByClassName("storesales_items");
for(let i = 0; i < storesales_items.length; i++){
	storesales_items[i].addEventListener('click', (e) => {
		//클릭된 행사 색변경
		reset(storesales_items, storesales_items.length, "storesales_items");
		e.target.parentElement.className="storesales_items selected_storesales_items";
		
		//클릭시 하단부 버튼 RESET/SAVE -> DELETE/UPDATE로 변경
		buttonController(true);
		
		//클릭시 우측에 회사 정보 출력
		selected_vo(e.target.parentElement.children[0]);
	});
}

// 행사 리스트 클릭시 기타 회사는 표시 제거
let reset = (taglist, length, className)=>{
	for(let i = 0 ; i < length; i++){
		taglist[i].className = className;
	}
}

// 클릭시 하단부 RESET/SAVE <-> DELETE/UPDATE 변경 함수 
let buttonController = (status) => {
	if (status == true) {
		document.getElementById("old_btn_sec").style.display="block";
		document.getElementById("new_btn_sec").style.display="none";
	}
	else {
		document.getElementById("old_btn_sec").style.display="none";
		document.getElementById("new_btn_sec").style.display="block";
	}
}

// input, label, 리스트 제외한 다른 영역 클릭시 DELETE/UPDATE -> RESET/SAVE 로 변경
let storesales_container = document.getElementsByClassName("storesales_container");
storesales_container[0].addEventListener('click', (e) => {
	let listarea = document.getElementsByClassName("storesales_regist");
	let labelarea = document.getElementsByTagName("label");
	let inputarea = document.getElementsByTagName("input");
	
	if(e.target.contains(listarea[0])){
		//여기는 입력란 타입(input 타입별, selectbox, checkbox 등등)마다 for문 요구
		let flag = true;
		for(let i = 0 ; i < labelarea.length; i++)
			if(!e.target.contains(labelarea[i])){ flag=false; break; }
		for(let i = 0 ; i < inputarea.length; i++)
			if(!e.target.contains(inputarea[i])){ flag=false; break; }
			
		if(flag) {
			buttonController(false);
			reset(storesales_items, storesales_items.length, "storesales_items");
			empty_inputs();
		}
	}
});

// 입력란 값 제거 함수
let empty_inputs = () => {
	document.getElementById("storesales_no").value="";
	document.getElementById("ctgr_no").value="";
	document.getElementById("storesales_code").value="";
	document.getElementById("company_no").value="";
	document.getElementById("storesales_date").value="";
	document.getElementById("customer_no").value="";
	document.getElementById("settletype_no").value="";
}

// 페이지 로딩시 error 문구 여부를 통해 focus 맞추기
window.onload = () => {
	let errormsg = document.getElementById("errormsg").innerHTML;
	errormsg = errormsg == "ctgr_no" ? "ctgr_name" : errormsg == "company_no" ? "company_name" : errormsg == "customer_no" ? "customer_name" : errormsg == "settletype_no" ? "settletype_name" : errormsg;
	if (errormsg != null) document.getElementById(errormsg).focus();
}

// 기타 입력창이 빈값일 경우 confirm 창 출력하는 함수
let empty_input_confirm = () => {
	let inputboxes = document.getElementsByTagName("input");
	let selectboxes = document.getElementsByTagName("select");
	let flag = false;
	let tagName = "";
	for(let i = 0 ; i < inputboxes.length ; i++){
		if(inputboxes[i].id=="storesales_no" || inputboxes[i].id=="search_word") continue;
		else{
			if (inputboxes[i].value == "" || inputboxes[i].value == null) {
				flag = true;
				tagName = inputboxes[i].id
				break;
			}
		}
	}
	if(!flag){
		for(let i = 0 ; i < selectboxes.length; i++){
			if(selectboxes[i].id =="search_type") continue;
			if(selectboxes[i].selectedIndex == -1) {
				flag= true;
				tagName=selectboxes[i].id;
				break;
			} 
		}
	}
	if(flag) {
		let confirm_res = window.confirm("입력되지 않은 사항이 있습니다. 전송하시겠습니까? " + tagName);
		if(confirm_res) return true;
		else return false;
	}
	else return !flag;
}

// SAVE 버튼 클릭 기능
let storesales_save_btn = document.getElementById("storesales_save_btn");
storesales_save_btn.addEventListener('click', () => {
	let res = empty_input_confirm();
	if (res) document.getElementById("storesales_frm").submit();
});

// 설비/장비리스트 검색조회
let search_word = document.getElementById("search_word");
let word="";
let select_value = "all";
search_word.addEventListener('keyup', (e) => {
	word = e.target.value;
	let search_res = search_filter(select_value, word);
	if(search_res != null) getlist(search_res);
});

// 검색어 입력 '후' 타입을 변경할 시, 해당 타입 적용을 위한 이벤트 추가
let search_type = document.getElementById("search_type");
search_type.addEventListener('change', ()=>{
	select_value = search_type.options[search_type.selectedIndex].value;
	let search_res = search_filter(select_value, word);
	if (search_res != null) getlist(search_res);
});

// 설비/장비리스트 검색 조회 결과 출력 기능
function getlist(list){
	let search_result = document.getElementById("search_result");
	let newTr = document.createElement("tr");
	let newTd = document.createElement("td");
	search_result.innerHTML = '';
	search_result.innerHTML += '<tr><td>코드</td><td>온라인매출코드</td><td>매출일자</td></tr>';
	if(list != null || list.length != 0){
		list.forEach(function(item){
			newTr = document.createElement("tr");
			search_result.appendChild(newTr);
			newTd = document.createElement("td");
			newTd.innerHTML = item.storesales_no;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.storesales_code;
			newTr.appendChild(newTd);
			newTd = document.createElement("td");
			newTd.innerHTML = item.storesales_date;
			newTr.appendChild(newTd);
			
		});
	}else {
		search_result.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
	}
}

// 설비/장비 수정 버튼
let storesales_update_btn = document.getElementById("storesales_update_btn");
storesales_update_btn.addEventListener('click', () => {
	let storesales_frm = document.getElementById("storesales_frm");
	storesales_frm.action="/c/c31/storesales_update";
	storesales_frm.submit();
});

// 설비/장비 삭제 버튼
let storesales_delete_btn = document.getElementById("storesales_delete_btn");
storesales_delete_btn.addEventListener('click', () => {
	let storesales_frm = document.getElementById("storesales_frm");
	storesales_frm.action="/c/c31/storesales_delete";
	storesales_frm.submit();
});


// 행추가 버튼
let addRow_btn = document.getElementById("addRow_btn");
addRow_btn.addEventListener("click", () => {
	let listtr = document.getElementsByClassName("list_result_items");
	let order = listtr[listtr.length-1].className.split(' ')[1].slice(5)
	order = Number(order) + 1;
	
	let newTr = document.createElement("tr");
	newTr.className = "list_result_items order"+order;
	newTr.innerHTML = '<td><button type="button" class="list_result_btn" id="list_result_search'+order+'">SEARCH</button></td>' +
	'<td class="hidden"><input type="hidden" name="salesgoods_no" id="salesgoods_no'+order+'"/></td>' +
	'<td class="hidden"><input type="hidden" name="salesgoods_code" id="salesgoods_code'+order+'"/></td>' +
	'<td><input type="text" name="goodslot_no" id="goodslot_no'+order+'"/></td>' + 
	'<td><input type="number" name="goodslot_production" id="goodslot_production'+order+'"/></td>' +
	'<td><input type="number" name="salesgoods_qty" id="salesgoods_qty'+order+'"/></td>' +
	'<td><input type="number" name="salesgoods_price" id="salesgoods_price'+order+'"/></td>' +
	'<td><input type="number" name="salesgoods_total" id="salesgoods_total'+order+'"/></td>' +
	'<td class="hidden"><input type="hidden" name="goods_no" id="goods_no'+order+'"/></td>' +
	'<td><button type="button" class="list_result_btn" id="list_result_del'+order+'">품목삭제</button></td>';

	listtr[0].parentElement.appendChild(newTr);
	
	//조회 버튼 등록
	register_search_btn();
	
	//품목삭제 버튼 등록
	register_del_btn();
	
	//원가변경함수 등록
	register_price_change();
	register_tax_change();
	register_qty_change();
});

// 행삭제 버튼
let delRow_btn = document.getElementById("delRow_btn");
delRow_btn.addEventListener("click", ()=>{
	let list_result_items = document.getElementsByClassName("list_result_items");
	list_result_items[list_result_items.length-1].remove();
});

// 조회 등록 버튼
let register_search_btn = () =>{
	let list_result_btn = document.getElementsByClassName("list_result_btn");
	for(let i = 0 ; i < list_result_btn.length; i++){
		if(list_result_btn[i].id.slice(0, -1) == "list_result_search"){
			list_result_btn[i].addEventListener("click", (e)=>{list_result_search_func(e.target)});
		}
	}
}

// 조회 기능 버튼
let list_result_search_func = (tag) => {
	let order = tag.id.charAt(tag.id.length-1);
	window.open("../c3/goodslot_list?order="+order, "_blank", "scrollbars=yes, top=200, left=450, width=1000, height=600");
}

// 품목삭제 등록 버튼
let register_del_btn = () => {
	let list_result_btn = document.getElementsByClassName("list_result_btn");
	for(let i = 0 ; i < list_result_btn.length; i++){
		if(list_result_btn[i].id.slice(0, -1) == "list_result_del"){
			list_result_btn[i].addEventListener("click", (e)=>{list_result_del_func(e.target)});
		}
	}
}

// 품목삭제 버튼
let list_result_del_func = (tag) => {
	let order = Number(tag.id.charAt(tag.id.length-1));
	document.getElementsByClassName("list_result_items order" + order)[0].remove();
}

// 원가변경함수 등록
let register_price_change = () => {
	let list_salesgoods_price = document.getElementsByName("salesgoods_price");
	for(let i = 0 ; i < list_salesgoods_price.length; i++){
		list_salesgoods_price[i].addEventListener("change", (e)=>{price_change_func(e.target)});
	}
}


// 세금변경함수 등록
let register_tax_change = () => {
	let list_salesgoods_tax = document.getElementsByName("salesgoods_price");
	for(let i = 0 ; i< list_salesgoods_tax.length; i++){
		list_salesgoods_tax[i].addEventListener("change", (e)=>{price_change_func(e.target)});
	}
}

// 수량변경함수 등록
let register_qty_change = () => {
	let list_salesgoods_qty = document.getElementsByName("salesgoods_qty");
	for(let i = 0 ; i< list_salesgoods_qty.length; i++){
		list_salesgoods_qty[i].addEventListener("change", (e)=>{price_change_func(e.target)});
	}
}

//  가격변경함수
let price_change_func = (tag) => {
	let order = Number(tag.id.charAt(tag.id.length-1));
	let qty = Number(document.getElementById("salesgoods_qty"+order).value);
	let price = Number(document.getElementById("salesgoods_price"+order).value);
	let tax_value = price * 0.1;
	document.getElementById("salesgoods_tax"+order).value = price + tax_value;  
	document.getElementById("salesgoods_total"+order).value = (price + tax_value) * qty;	
}

let prev_salesgoods_del = () => {
	alert("수정 중 해당상품의 삭제를 원하실 경우 수량을 0으로 변경해주세요");
}

// 클릭시 salesgoods 호환되는 list 출력 페이지 이동
let register_list_items = () => {
	let list_items = document.getElementsByClassName("storesales_items");
	for(let i = 0 ; i < list_items.length; i++){
		list_items[i].addEventListener("click", (e)=>{list_items_clickfunc(e.target)});
	}
}

let list_items_clickfunc = (tag) => {
	let no = tag.children[0].innerHTML;
	let code = tag.children[1].innerHTML;
	let qty_list = document.getElementsByName("salesgoods_qty");
	let goodslotno_list = document.getElementsByName("goodslot_no");
	let qty_list_toString = "";
	for(let i = 0 ; i < qty_list.length; i++){
		qty_list_toString = qty_list_toString + "/" + goodslotno_list[i].value + ":" + qty_list[i].value;
	}
	qty_list_toString = qty_list_toString.slice(0,-1);
	document.cookie = "qty_list="+qty_list_toString;
	location.href="?code="+code+"&no="+no;
}

window.onload = () => {
	register_search_btn();
	register_del_btn();
	register_price_change();
	register_tax_change();
	register_qty_change();
}
