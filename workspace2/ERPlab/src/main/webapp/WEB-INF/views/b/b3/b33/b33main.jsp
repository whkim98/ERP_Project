<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="currency-container">
	
	<div class="b33-currency-head">	
	<h1>외화관리</h1>
	</div>
	
	<div class="b33-currency-search">
	    <input type="text" id="searchCurrency" placeholder="국가명을 입력하세요" />
	    <button id="filterButton">검색</button>
	</div>
	
	<br>
	
	<div class="b33-currency-main">
	
		<h1>기준환율조회</h1>
		
		<table id = "exchangeList">
	
		
		</table>
	</div>
	
	
</div>



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
        var cp = document.getElementById("exchangeList");
		
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

		newTd.innerHTML = '국가부호';
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

		// newTd.innerHTML = '수출입구분';
		// newTr.appendChild(newTd);
		// newTd = document.createElement("td");
		
		if(itemData == ''){
			cp.innerHTML = '';
			cp.innerHTML += '<tr>';
			cp.innerHTML += '<td>데이터를 조회할 수 없습니다</td>';
			cp.innerHTML += '</tr>';
		}else {
		jsonData.forEach(function(cpt){
			newTr = document.createElement("tr");
			cp.appendChild(newTr);

			newTd = document.createElement("td");
			newTd.innerHTML =  cpt.cntySgn ;
			newTr.appendChild(newTd);

			newTd = document.createElement("td");

            if(cpt.cntySgn == "AE")
            {
                newTd.innerHTML =  "소라" ; 
            }else{
                newTd.innerHTML =  cpt.mtryUtNm ; 
            }

			newTr.appendChild(newTd);

			newTd = document.createElement("td");
			newTd.innerHTML =  cpt.fxrt ;
			newTr.appendChild(newTd);

			newTd = document.createElement("td");
			newTd.innerHTML =  cpt.currSgn ;
			newTr.appendChild(newTd);

			newTd = document.createElement("td");
			newTd.innerHTML =  cpt.aplyBgnDt ;
			newTr.appendChild(newTd);

		}
        
        );
    }
}
}

xhr.send('');		


</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    