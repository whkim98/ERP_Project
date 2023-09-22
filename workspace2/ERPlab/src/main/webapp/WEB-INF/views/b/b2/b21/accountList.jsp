<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />

<script>
function selectForm(no){
	   document.getElementsByName("account_no")[0].value = no;
	   document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}

function surf(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
	   var type = document.getElementsByName("type")[0].value;
	   console.log(type);
	   console.log(code);
	   console.log(v);
	   var url = "${pageContext.request.contextPath}/account/ajax";   // controller mapping
	   if(v == ''){
	      type = null;
	      v = null;
	   }
	   console.log(v);
	   console.log(url);
	   var param = "comcode_code="+code+"&word="+v+"&type="+type;      // 넘길 데이터
	   console.log(param);
	   sendRequest(url,param,getlist,"POST");
	}
	
function getlist() {
	console.log('getlist왔어요');
 if (xhr.readyState == 4 && xhr.status == 200) {
     var data = xhr.response;
     let procode = document.getElementById("procode"); // list가 들어갈 테이블 id
     let newTr, newTd;

     procode.innerHTML = ''; // 테이블 비우기
     procode.innerHTML += '<tr><td>은행</td><td>계좌번호</td><td>SWIFT CODE</td><td>잔액</td><td>환산금액</td></tr>';
     
     let co = document.getElementById('com').value;
     
    	console.log(co);
    	
     if (data != "") {
         var data2 = JSON.parse(data);
         data2.forEach(function (map) {
             newTr = document.createElement("tr");
             newTr.setAttribute("onclick", "selectForm(" + map.account_no + ")");
             procode.appendChild(newTr);

             // 상품명
             newTd = document.createElement("td");
             newTd.innerHTML = map.account_bank;
             newTr.appendChild(newTd);

             // 로트번호
             newTd = document.createElement("td");
             newTd.innerHTML = map.account_num;
             newTr.appendChild(newTd);

             // 유통기한
             newTd = document.createElement("td");
             newTd.innerHTML = map.account_swift;
             newTr.appendChild(newTd);

             // 소비자가
             newTd = document.createElement("td");
             newTd.innerHTML = map.account_balance;
             newTr.appendChild(newTd);
             
             // 소비자가
             newTd = document.createElement("td");
             newTd.innerHTML = map.account_exchange;
             newTr.appendChild(newTd);

         });
     } else {
         procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
     }
 }
}

</script>

</script>

 <div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">계좌현황 및 관리</h1>
      </div>
      <div class="divform2">
      <input type="hidden" name="comcode_code" id="com" value="${comcode_code }">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="account_num" ${param.type == 'account_num' ? 'selected' : '' }>계좌번호</option>
                        <option value="account_swift" ${param.type == 'account_swift' ? 'selected' : '' }>SWIFT CODE</option>
                     </select>
                  </td>
                  <td>
                     <input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${comcode_code}')">
                     <input type="button" value="전체목록" onclick="surf('', '${comcode_code}')">
                  </td>
               </tr>
            </table>
         </div>
    
		<div style="overflow: scroll;">
         <input type="hidden" id="com" value="${comcode_code }">
            <table id="procode">
            	<c:if test="${list != null }">
               		<tr>
						<th>은행</th>
						<th>계좌번호</th>
						<th>SWIFT CODE</th>
						<th>잔액</th>
						<th>환산금액</th>
					</tr>
               <c:forEach var="vo" items="${list }">
			<tr onclick="selectForm(${vo.goodslot_no})" class="filter" id="filter">
			    <td>${vo.account_bank}</td>
			    <td>${vo.account_num}</td>
			    <td>${vo.account_swift}</td>
			    <td>${vo.account_balance}</td>
			    <td>${vo.account_exchange }</td>
			</tr>
				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
          <div>
			<input type="button" value="ADD" onclick="location.href='${pageContext.request.contextPath}/account/insert?comcode_code=${comcode_code }'">
			</div>

    
<link rel="stylesheet" href="${pageContext.request.contextPath }/webdesign/assets/css/main.css" />

<script type="text/javascript">

window.onload = function() {
    // 환율 데이터 업데이트 함수 실행
    updateExchangeRate();

    // 주기적으로 업데이트 함수 호출 (예: 1시간마다)
    setInterval(updateExchangeRate, 3600000); // 1시간마다 호출 (1시간 = 3600000 밀리초)

    // 환율 데이터 업데이트 함수
    function updateExchangeRate() {
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
        
        console.log(getDate);

        // 환율 API 호출 (예시)
        var xhr = new XMLHttpRequest();
        var url = 'http://apis.data.go.kr/1220000/retrieveTrifFxrtInfo/getRetrieveTrifFxrtInfo';
        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'WjGespN29wux4Xj7jLxhXiLVM5JxvOfZUbZy7BVs%2B0JsYWmmqa8DgBDtuM50dvHb%2BQU3jR5Wa1UAB6%2F50Scuiw%3D%3D';
        queryParams += '&' + encodeURIComponent('aplyBgnDt') + '=' + encodeURIComponent(getDate);
        queryParams += '&' + encodeURIComponent('weekFxrtTpcd') + '=' + encodeURIComponent('1');

        xhr.open('GET', url + queryParams);

        xhr.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                // API 호출 성공 시 데이터 처리
                var responseXML = this.responseXML;
                var items = responseXML.getElementsByTagName("item");
                var jsonData = [];

                for (var i = 0; i < items.length; i++) {
                    var item = items[i];
                    var itemData = {
                        fxrt: item.getElementsByTagName("fxrt")[0].textContent,
                        aplyBgnDt: item.getElementsByTagName("aplyBgnDt")[0].textContent,
                        cntySgn: item.getElementsByTagName("cntySgn")[0].textContent,
                        currSgn: item.getElementsByTagName("currSgn")[0].textContent,
                        // 기타 필요한 데이터 필드 추가
                    };

                    jsonData.push(itemData);
                }

                // 데이터를 컨트롤러로 전송 (POST 요청 예시)
                var formData = new FormData();
                formData.append('jsonData', JSON.stringify(jsonData)); // JSON 데이터를 문자열로 변환하여 FormData에 추가
				
                var com = document.getElementById("com").value;
                
                var updateXhr = new XMLHttpRequest();
                updateXhr.open('POST', "${pageContext.request.contextPath}/account/autoUpdate?comcode_code=" + com, true);
                updateXhr.send(formData);
            }
        };

        xhr.send('');
    }
}

</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    