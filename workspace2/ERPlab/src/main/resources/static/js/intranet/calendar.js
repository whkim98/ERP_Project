window.onload = function () {
	buildCalendar(); // 웹 페이지가 로드되면 buildCalendar 실행 
}    

let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
let today = new Date();     // 페이지를 로드한 날짜를 저장
today.setHours(0, 0, 0, 0);    // 비교 편의를 위해 today의 시간을 초기화

// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
function buildCalendar() {

    let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
    let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

    let tbody_Calendar = document.querySelector(".Calendar > tbody");
    document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
    document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

    while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
        tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
    }

    let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

    for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
        let nowColumn = nowRow.insertCell();        // 열 추가
    }

    for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

        let nowColumn = nowRow.insertCell();        // 새 열을 추가하고


        let newDIV = document.createElement("p");
        newDIV.innerHTML = leftPad(nowDay.getDate());        // 추가한 열에 날짜 입력
        nowColumn.appendChild(newDIV);

        if (nowDay.getDay() == 6) {                 // 토요일인 경우
            nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
        }

        if (nowDay < today) {                       // 지난날인 경우
            newDIV.className = "pastDay";
        }
        else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
            newDIV.className = "today";
            newDIV.onclick = function () { choiceDate(this); }
        }
        else {                                      // 미래인 경우
            newDIV.className = "futureDay";
            newDIV.onclick = function () { choiceDate(this); }
        }
    }
    // 캘린더 생성 후 clickable 하게 만듬
	let futureDay_list = document.getElementsByClassName("futureDay");
	for(let i = 0 ; i < futureDay_list.length; i++){
		futureDay_list[i].addEventListener("click", (e)=>{
			day_selected(e.target);
		});
	}
}

// 날짜 선택
function choiceDate(newDIV) {
    if (document.getElementsByClassName("choiceDay")[0]) {                              // 기존에 선택한 날짜가 있으면
        document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");  // 해당 날짜의 "choiceDay" class 제거
    }
    newDIV.classList.add("choiceDay");           // 선택된 날짜에 "choiceDay" class 추가
}

// 이전달 버튼 클릭
function prevCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
    buildCalendar();    // 달력 다시 생성
}
// 다음달 버튼 클릭
function nextCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
    buildCalendar();    // 달력 다시 생성
}

// input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
function leftPad(value) {
    if (value < 10) {
        value = "0" + value;
        return value;
    }
    return value;
}

//----------------------------------------------
// 추가기능
		
// 특정 날짜 클릭시 기능
let day_selected = (day_tag)=>{
	// "일정 확인하기"란의 날짜 섹션값 변경
	let month = document.getElementById("calMonth").innerHTML;
	month = Number(month);
	let date = day_tag.innerHTML;
	document.getElementById("selected_today").innerHTML = month + "월 " + date + "일";
	
	// 날짜에 해당하는 날짜 불러오기
	document.getElementById("schedule_contents").innerHTML = schedule_onDay(month, date);
	
	//해당날짜 일정 적용하기
}

// 해당 날짜의 일정 불러오기
let schedule_onDay = (month, day) => {
	let schedule_list = schedule_listing(month);
	let text = "";

	let schedule_list_content = schedule_list[day-1].split(":")[1].split("|-|");
	for(let i = 0 ; i < schedule_list_content.length; i++){
		text = text +'<div class="schedule_sec"><p>'+schedule_list_content[i]+"</p>" + '<button id="schedule_del_btn" onClick="delete_schedule(' + month + ',' + day +',' + i + ')">일정삭제</button> </div> <br/>';		
	}
	return text;
}

// 일정 삭제 기능
let delete_schedule = (month, day, idx) => {
	let schedule_list = schedule_listing(month);

	let deleted_schedule_list = [];
	
	let schedule_list_content = schedule_list[day-1].split(":")[1].split("|-|");
	for(let i = 0 ; i < schedule_list_content.length; i++){
		if(idx != i) deleted_schedule_list.push(schedule_list_content[i]);
	}
	console.log("deleted_schedule_list : " + deleted_schedule_list);
	
	//vo에 정리된 텍스트화 된 값 넣기
	let text = listToText(day, deleted_schedule_list);
	textToVO(month, text);
	
	// 보내기
	let calendar_frm = document.getElementById("calendar_frm");
	calendar_frm.submit();
}

// 일정 추가 기능	
let schedule_add_btn = document.getElementById("schedule_add_btn");
schedule_add_btn.addEventListener("click", ()=>{
	let month = document.getElementById("calMonth").innerHTML;
	let date = document.getElementById("selected_today").innerHTML.split(" ")[1]
	let day = Number(date.substr(0,2));

	let schedule_list = schedule_listing(month);

	let content = document.getElementById("schedule_content").value;
	let schedule_list_content = schedule_list[day-1].split(":")[1].split("|-|");
	schedule_list_content.push(content);
	
	//vo에 정리된 텍스트화 된 값 넣기
	let text = listToText(day, schedule_list_content);
	textToVO(text);
	
	//보내기
	let calendar_frm = document.getElementById("calendar_frm");
	calendar_frm.submit();
});

// 일정 리스트 -> 텍스트화 함수
let listToText = (day , list) => {
	let text= "[[" + day +"]]:";
	for (let i = 0 ; i < list.length ; i++){
		text = text + list[i]; 
		if(i+1 != list.length) text= text + "|-|";
	}
	console.log("listToText text : " + text);
	return text;
}

let textToVO = (month, text)=>{
	
	switch (month) {
		case 1 : document.getElementById("calendar_jaunary").value = text;
		case 2 : document.getElementById("calendar_february").value = text;
		case 3 : document.getElementById("calendar_march").value = text;
		case 4 : document.getElementById("calendar_april").value = text;
		case 5 : document.getElementById("calendar_may").value = text;
		case 6 : document.getElementById("calendar_june").value = text;
		case 7 : document.getElementById("calendar_july").value = text;
		case 8 : document.getElementById("calendar_august").value = text;
		case 9 : document.getElementById("calendar_september").value = text;
		case 10 : document.getElementById("calendar_october").value = text;
		case 11 : document.getElementById("calendar_november").value = text;
		case 12 : document.getElementById("calendar_december").value = text;
	}
}
	
	
	
	
	
	
	