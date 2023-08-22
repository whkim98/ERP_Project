<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="currency-container">
	
	<div class="b33-currency-head">	
	<h1>외화관리</h1>
	</div>

	
	<div class="b33-currency-main">
		<table border="1" align="center" id = "exchangeList">
	
		
		</table>
	</div>
	
	
</div>



<script type="text/javascript">
/* $.ajax({
	  method: "GET",
	  url: "http://apis.data.go.kr/1220000/retrieveTrifFxrtInfo/getRetrieveTrifFxrtInfo",
	  data: {serviceKey: "ZmCX6ouBhw5LCRs8l84TLxr87sFfocoqUOErldNUySN7OzfwdeHkspStToNcDhPSgf1qjHPYhpRhN%2FA4Ebl%2F2w%3D%3D" ,aplyBgnDt: "20150101", weekFxrtTpcd: "2" }
	 
	})
	  .done(function( msg ) {
	    alert( "Data Saved: " + msg );
	    console.log(msg);
	  }); */

	 	var newTr = document.createElement("tr");
		var newTd = document.createElement("td");
		
		var xhr = new XMLHttpRequest();
		var url = 'http://apis.data.go.kr/1220000/retrieveTrifFxrtInfo/getRetrieveTrifFxrtInfo';
		var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ZmCX6ouBhw5LCRs8l84TLxr87sFfocoqUOErldNUySN7OzfwdeHkspStToNcDhPSgf1qjHPYhpRhN%2FA4Ebl%2F2w%3D%3D';
		queryParams += '&' + encodeURIComponent('aplyBgnDt') + '=' + encodeURIComponent('20230809');
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
				newTd.innerHTML = '화폐단위명';
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
				newTd.innerHTML = '수출입구분';
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
					newTd = document.createElement("td");
					newTd.innerHTML =  cpt.cntySgn ;
					newTr.appendChild(newTd);
					newTd = document.createElement("td");
					newTd.innerHTML =  cpt.mtryUtNm ;
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
					newTd = document.createElement("td");
					newTd.innerHTML =  cpt.imexTp ;
					newTr.appendChild(newTd);
				});
		    }
		}
		}
		xhr.send('');		
	
	
</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    