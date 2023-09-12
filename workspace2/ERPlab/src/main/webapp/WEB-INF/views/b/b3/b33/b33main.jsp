<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

    <div class="currency-container">
	
        <div class="b33-currency-head">	
        <h1>외화관리</h1>
        </div>
        
        <div class="b33-currency-search">
        
            <h1>환율조회</h1>

            <select name="b33searchType" id="b33searchOption">
                <option value="b33searchCountryCode">국가코드</option>
                <option value="b33searchCountryName">국가명</option>
                <option value="b33searchCurrency">통화부호</option>
            </select>
            <input type="text" id="b33searchInput" placeholder="검색어를 입력하세요" />
            <button id="filterButton">검색</button>
        </div>
        
        <br>
        <br>
        
        <div class="b33-currency-main">
        
            <h1>국세청 기준환율</h1>
            
            <h6 style="color: red">*국세청 기준 환율은 매주 일요일을 기점으로 주 단위로 변경</h6>
            <br>
            
            <table id = "b33countryList" style="display: none;">
            <input type="hidden" name="country_no" id="country_no" value="${map.country_no}" />
           	<c:forEach var="map" items="${list}" >
            	<tr>
            		<td class="b33countryCode">${map.country_code}</td>
            		<td class="b33countryName">${map.country_name}</td>
            	</tr>            
            </c:forEach>

            </table>
            
            <table id = "b33exchangeList">
        
            
            </table>
        </div>
        
        
    </div>
    
    
    
    
<link rel="stylesheet" href="${pageContext.request.contextPath }/webdesign/assets/css/main.css" />

<script type="text/javascript">


// 오늘 날짜를 문자열로 변환
function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return year + month + day;
}

// 오늘 날짜를 가져오기
const today = new Date();
const getDate = formatDate(today);


// 환율 api 적용
var newTr = document.createElement("tr");
var newTd = document.createElement("td");

var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/1220000/retrieveTrifFxrtInfo/getRetrieveTrifFxrtInfo';
var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'WjGespN29wux4Xj7jLxhXiLVM5JxvOfZUbZy7BVs%2B0JsYWmmqa8DgBDtuM50dvHb%2BQU3jR5Wa1UAB6%2F50Scuiw%3D%3D';
queryParams += '&' + encodeURIComponent('aplyBgnDt') + '=' + encodeURIComponent(getDate);
queryParams += '&' + encodeURIComponent('weekFxrtTpcd') + '=' + encodeURIComponent('1');
xhr.open('GET', url + queryParams);

xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        var responseXML = this.responseXML;
        var items = responseXML.getElementsByTagName("item");
        var jsonData = [];
        var cp = document.getElementById("b33exchangeList");
        var matchCountry = "국가 정보가 없습니다."; // 기본값 설정
        
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var itemData = {};
            
            itemData.aplyBgnDt = item.getElementsByTagName("aplyBgnDt")[0].textContent;
            itemData.cntySgn = item.getElementsByTagName("cntySgn")[0].textContent;
            itemData.currSgn = item.getElementsByTagName("currSgn")[0].textContent;
            itemData.fxrt = item.getElementsByTagName("fxrt")[0].textContent;
            itemData.imexTp = item.getElementsByTagName("imexTp")[0].textContent;
            itemData.mtryUtNm = item.getElementsByTagName("mtryUtNm")[0].textContent;

            jsonData.push(itemData);
        }
        
        console.log(JSON.stringify(jsonData, null, 2));
        
        cp.appendChild(newTr);
        newTd = document.createElement("td");

        newTd.innerHTML = '국가코드';
        newTr.appendChild(newTd);
        newTd = document.createElement("td");

        newTd.innerHTML = '국가명';
        newTr.appendChild(newTd);
        newTd = document.createElement("td");

        newTd.innerHTML = '환율';
        newTr.appendChild(newTd);
        newTd = document.createElement("td");

        newTd.innerHTML = '통화부호';
        newTr.appendChild(newTd);
        newTd = document.createElement("td");

        newTd.innerHTML = '적용개시일자';
        newTr.appendChild(newTd);
        newTd = document.createElement("td");
        
        if(itemData == ''){
            cp.innerHTML = '';
            cp.innerHTML += '<tr>';
            cp.innerHTML += '<td>데이터를 조회할 수 없습니다</td>';
            cp.innerHTML += '</tr>';
        }else {
        jsonData.forEach(function(cpt){
            newTr = document.createElement("tr");
            cp.appendChild(newTr);
			
            // 국가코드
            newTd = document.createElement("td");
            newTd.innerHTML =  cpt.cntySgn ;
            newTr.appendChild(newTd);
            
            // 국가명
            a = Array.from(document.getElementsByClassName("b33countryCode"));
            b = Array.from(document.getElementsByClassName("b33countryName"));                     
            var nameArray = b.forEach(function(name){ });
            var codeArray = a.forEach(function(code){ });
            
            newTd = document.createElement("td");             
            var matchedCountryName = "국가 정보가 없습니다.";
            for (var i = 0; i < a.length; i++) {
                if (cpt.cntySgn === a[i].innerText) {
                    matchedCountryName = b[i].innerText;
                    break;
                }
            }           
            newTd.innerHTML = matchedCountryName;
            newTr.appendChild(newTd);

            // 환율
            newTd = document.createElement("td");
            newTd.innerHTML =  cpt.fxrt ;
            newTr.appendChild(newTd);

            // 통화부호
            newTd = document.createElement("td");
            newTd.innerHTML =  cpt.currSgn ;
            newTr.appendChild(newTd);

            // 적용개시일자
            newTd = document.createElement("td");
            newTd.innerHTML =  cpt.aplyBgnDt ;
            newTr.appendChild(newTd);

        }
        
        );
    }
}
}

xhr.send('');		


// 검색 버튼 클릭 시 실행될 함수
function filterExchangeList() {
    const searchOption = document.getElementById("b33searchOption").value;
    const searchInput = document.getElementById("b33searchInput").value.toUpperCase();

    const tableRows = document.querySelectorAll("#b33exchangeList tr");

    tableRows.forEach(function(row, index) {
        if (index > 0) { 
            const dataCells = row.querySelectorAll("td");
            let matchFound = false;

            if (searchOption === "b33searchCountryCode") {
                matchFound = dataCells[0].textContent.toUpperCase().includes(searchInput);
            } else if (searchOption === "b33searchCountryName") {
                matchFound = dataCells[1].textContent.toUpperCase().includes(searchInput);
            } else if (searchOption === "b33searchCurrency") {
                matchFound = dataCells[3].textContent.toUpperCase().includes(searchInput);
            }

            row.style.display = matchFound ? "" : "none";
        }
    });
}

// 검색 버튼 클릭 이벤트 리스너 등록
const filterButton = document.getElementById("filterButton");

filterButton.addEventListener("click", filterExchangeList);


</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    