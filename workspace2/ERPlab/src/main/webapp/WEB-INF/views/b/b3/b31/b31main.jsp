<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="statement-container">
	
    <div class="b31-head">

    <h1>일반전표</h1>
    
    <table class="b31-title">
            <tr>
                <th>일자별</th>
                <td>
                    <select id="yearSelect"></select>년
                    <select id="monthSelect"></select>월
                    <select id="daySelect"></select>일
                    <input type="button" id="b31-dateSearch" value="검색" />
                </td>
                <td></td>
                <th>기간별</th>
                <td>
                    <select id="yearPeriod"></select>년
                    <select id="monthPeriod1"></select>월 ~ 
                    <select id="monthPeriod2"></select>월
                    <input type="button" id="b31-monthPeriodSearch" value="검색" />
                    </td>
                <th>항목으로 검색</th>
                <td><input type="text" id="searchInput" value="검색할 항목을 입력하세요" /><button>검색</button></td>
            </tr>
        </table>
    
    </div>
	
	<div class="b31-body">
		
        <table class="b31-clauses" id="b31-itemTable">
        
            <tr>
                <th>checkbox</th>
                <th>년</th>
                <th>월</th>
                <th>일</th>
                <th>고유코드</th>
                <th>구분</th>
                <th>차변 계정과목</th>
                <th>차변 금액</th>
                <th>대변 계정과목</th>
                <th>대변 금액</th>
                <th>적요</th>
                <th>거래처</th>
                <th>삭제</th>
            </tr>
            
            <tr>
                <td>입력checkbox</td>
                <td>입력년</td>
                <td>입력월</td>
                <td>입력일</td>
                <td>입력고유코드</td>
                <td>입력구분</td>
                <td>차변 계정과목</td>
                <th id="debitAmount">5000</th>
                <td>입력대변 계정과목</td>
                <th id="creditAmount">7000</th>
                <td>입력적요</td>
                <td>입력거래처</td>
                <td><input type="button" id="b31-deleteStatement" value="삭제" /></td>
            </tr>
    
            <tr>
                <th colspan="4">선택 전표 소계</th>
                <td colspan="2"></td>
                <td></td>
                <td id="debitAmountTotal"></td>
                <td></td>
                <td id="creditAmountTotal"></td>
                <td colspan="2">기타</td>
            </tr>
        
        </table>
	
	</div>

</div>

<script type="text/javascript">


	// <일자별 검색>
	const yearSelect = document.getElementById("yearSelect");
	const monthSelect = document.getElementById("monthSelect");
	const daySelect = document.getElementById("daySelect");
	
	const currentYear = new Date().getFullYear();
	const startYear = 2020; // 시작년도 설정
	
	// 연도 선택 드롭다운 목록 채우기
	for (let year = startYear; year <= currentYear; year++) {
	    const option = document.createElement("option");
	    option.value = year;
	    option.text = year;
	    yearSelect.appendChild(option);
	}
	
	// 월 선택 드롭다운 목록 채우기
	for (let month = 1; month <= 12; month++) {
	    const option = document.createElement("option");
	    option.value = month;
	    option.text = month;
	    monthSelect.appendChild(option);
	}
	
	// 월과 연도에 따라 일 선택 드롭다운 목록 업데이트
	function updateDays() {
	    const selectedYear = parseInt(yearSelect.value);
	    const selectedMonth = parseInt(monthSelect.value);
	
	    // 선택한 월의 일수 구하기
	    const daysInMonth = new Date(selectedYear, selectedMonth, 0).getDate();
	
	    // 일 선택 드롭다운 목록 비우기
	    daySelect.innerHTML = "";
	
	    // 일 선택 드롭다운 목록 채우기
	    for (let day = 1; day <= daysInMonth; day++) {
	        const option = document.createElement("option");
	        option.value = day;
	        option.text = day;
	        daySelect.appendChild(option);
	    }
	}
	
	// 연도나 월이 변경될 때마다 일 선택 드롭다운 목록 업데이트
	yearSelect.addEventListener("change", updateDays);
	monthSelect.addEventListener("change", updateDays);
	
	// 페이지 로드 시 일 선택 드롭다운 목록 초기화
	updateDays();
	
	
	// 월 기간 검색
	const yearPeriod = document.getElementById("yearPeriod");
	for (let year = startYear; year <= currentYear; year++) {
	    const option = document.createElement("option");
	    option.value = year;
	    option.text = year;
	    yearPeriod.appendChild(option);
	}
	
	const monthPeriod1 = document.getElementById("monthPeriod1");
	for (let month = 1; month <= 12; month++) {
	    const option = document.createElement("option");
	    option.value = month;
	    option.text = month;
	    monthPeriod1.appendChild(option);
	}
	
	const monthPeriod2 = document.getElementById("monthPeriod2");
	for (let month = 1; month <= 12; month++) {
	    const option = document.createElement("option");
	    option.value = month;
	    option.text = month;
	    monthPeriod2.appendChild(option);
	}   
	
	
	
    // <합계 계산 및 갱신 함수 호출>
    calculateTotals();
   
   // 합계 계산 및 갱신 함수
   function calculateTotals() {
       const table = document.getElementById('b31-itemTable');
       const rows = table.rows;
       
       let debitTotal = 0;
       let creditTotal = 0;
       
       // 첫 번째 행부터 마지막 합계 행 전까지 계산
       for (let i = 1; i < rows.length - 1; i++) {
           const debitCell = rows[i].querySelector('[id="debitAmount"]');
           const creditCell = rows[i].querySelector('[id="creditAmount"]');
           
           // 숫자로 변환 후 합산
           debitTotal += parseInt(debitCell.textContent, 10);
           creditTotal += parseInt(creditCell.textContent, 10);
       }
       
       // 합계를 표시할 요소에 결과 설정
       const debitTotalCell = document.getElementById('debitAmountTotal');
       const creditTotalCell = document.getElementById('creditAmountTotal');
       
       debitTotalCell.textContent = debitTotal;
       creditTotalCell.textContent = creditTotal;
  	 }   

    
</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    