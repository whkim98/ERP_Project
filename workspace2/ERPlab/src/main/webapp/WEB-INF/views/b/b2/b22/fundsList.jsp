 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />

<style type="text/css">

.test{
	left: 80%;
}

.notosanskr * { 
 font-family: 'Noto Sans KR', sans-serif;
 font-size:10px;
}

.A31 input{
   width:
}

.divform1 {
   width: 100%;
   height: 20%;
}

.divform2 {
   float: left;
   margin-left: 5%; 
   width:35%;
}

.divform3 {
   float: left;
   margin-left: 5%; 
   width:45%;
}

.divform4 {
   float: left;
   margin-left: 5%;
}

.hr {
   height: 100vh;
   width: 0.1vw;
   border-width: 0;
   color: rgba(160, 160, 160, 0.3);
   background-color: rgba(160, 160, 160, 0.3);
   
}

input#search {
background:url(/image/search-glass.png);
background-repeat: no-repeat;
width:20px;
height:20px;
border: 0;
}

</style>

<script>

function updateForm(moneyCode, debtorNo, moneyDebtoramount, creditorNo, moneyCreditoramount, code){
	var param = "?money_code=" + moneyCode + "&debtor_no=" + debtorNo + "&money_debtoramount=" + moneyDebtoramount + "&creditor_no=" + creditorNo + "&money_creditoramount="+ moneyCreditoramount + "&comcode_code=" + code;
	
	const url = `${pageContext.request.contextPath}/funds/insert`;
	
	location.href = url + param;
}

function selectForm(no){
	   document.getElementsByName("closing_no")[0].value = no;
	   document.getElementById("content").submit(); // content라는 id의 form태그 submit
	}

function surf(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
	   var type = document.getElementsByName("type")[0].value;
	   console.log(type);
	   console.log(code);
	   console.log(v);
	   var url = "${pageContext.request.contextPath}/funds/ajax";   // controller mapping
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
	
function surff(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
	   var type = document.getElementsByName("type")[0].value;
	   console.log(type);
	   console.log(code);
	   console.log(v);
	   var url = "${pageContext.request.contextPath}/money/ajax";   // controller mapping
	   if(v == ''){
	      type = null;
	      v = null;
	   }
	   console.log(v);
	   console.log(url);
	   var param = "comcode_code="+code+"&word="+v+"&type="+type;      // 넘길 데이터
	   console.log(param);
	   sendRequest(url,param,getlist2,"POST");
	}
	
function getlist() {
	console.log('getlist왔어요');
    if (xhr.readyState == 4 && xhr.status == 200) {
        var data = xhr.response;
        let procode = document.getElementById("procode"); // list가 들어갈 테이블 id
        let newTr, newTd;

        procode.innerHTML = ''; // 테이블 비우기
        procode.innerHTML += '<tr><td>고유코드</td><td>등록날짜</td><td>차변금액</td><td>대변금액</td><td></td></tr>';
        
        let co = document.getElementById('com').value;
        
       	console.log(co);
       	
        if (data != "") {
            var data2 = JSON.parse(data);
            data2.forEach(function (map) {
                newTr = document.createElement("tr");
                newTr.setAttribute("onclick", "selectForm(" + map.closing_no + ")");
                procode.appendChild(newTr);

                // 상품명
                newTd = document.createElement("td");
                newTd.innerHTML = map.closing_code;
                newTr.appendChild(newTd);

                // 로트번호
                newTd = document.createElement("td");
                newTd.innerHTML = map.closing_date;
                newTr.appendChild(newTd);

                // 유통기한
                newTd = document.createElement("td");
                newTd.innerHTML = map.closing_debtor;
                newTr.appendChild(newTd);

                // 소비자가
                newTd = document.createElement("td");
                newTd.innerHTML = map.closing_creditor;
                newTr.appendChild(newTd);

                // "DELETE" 버튼
                newTd = document.createElement("td");
                var button = document.createElement("input");
                button.type = "button";
                button.value = "자금등록";
                button.onclick = function () {
                    updateForm(map.closing_code, map.debtor_no, map.closing_debtor, map.creditor_no, map.closing_creditor, co);
                };
                newTd.appendChild(button);
                newTr.appendChild(newTd);
            });
        } else {
            procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
        }
    }
}

function getlist2() {
	console.log('getlist왔어요');
    if (xhr.readyState == 4 && xhr.status == 200) {
        var data = xhr.response;
        let procode = document.getElementById("procode"); // list가 들어갈 테이블 id
        let newTr, newTd;

        procode.innerHTML = ''; // 테이블 비우기
        procode.innerHTML += '<tr><td>고유코드</td><td>일자</td><td>차변내용</td><td>차변금액</td><td>대변내용</td><td>대변금액</td></tr>';
        
        let co = document.getElementById('com').value;
        
       	console.log(co);
       	
        if (data != "") {
            var data2 = JSON.parse(data);
            data2.forEach(function (map) {
                newTr = document.createElement("tr");
                newTr.setAttribute("onclick", "selectForm(" + map.money_no + ")");
                procode.appendChild(newTr);

                // 상품명
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_code;
                newTr.appendChild(newTd);

                // 로트번호
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_date;
                newTr.appendChild(newTd);

                // 유통기한
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_debtor;
                newTr.appendChild(newTd);

                // 유통기한
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_debtoramount;
                newTr.appendChild(newTd);

                // 소비자가
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_creditor;
                newTr.appendChild(newTd);

                // 소비자가
                newTd = document.createElement("td");
                newTd.innerHTML = map.money_creditoramount;
                newTr.appendChild(newTd);

            });
        } else {
            procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
        }
    }
}

</script>



<div class="notosanskr">
      <div class="test">
         <h1 style="font-size: 20pt;">일마감 리스트</h1>
      </div>
      <div class="divform2">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="closing_code" ${param.type == 'closing_code' ? 'selected' : '' }>고유코드</option>
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
						<th>고유코드</th>
						<th>등록날짜</th>
						<th>차변금액</th>
						<th>대변금액</th>
						<th></th>
					</tr>
               <c:forEach var="vo" items="${list }">
			<tr onclick="selectForm(${vo.goodslot_no})" class="filter" id="filter">
			    <td>${vo.closing_code}</td>
			    <td>${vo.closing_date}</td>
			    <td>${vo.closing_debtor}</td>
			    <td>${vo.closing_creditor}</td>
			    <td><input type="button" value="자금등록" onclick="location.href='${pageContext.request.contextPath}/funds/insert?money_code=${vo.closing_code }&debtor_no=${vo.debtor_no }&money_debtoramount=${vo.closing_debtor }&creditor_no=${vo.creditor_no }&money_creditoramount=${vo.closing_creditor }&comcode_code=${comcode_code }'"></td>
			</tr>

				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
      </div>
      </div>
      

         <div class="divform4">
         <hr class="hr">
      	</div>
      
      
      <div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">자금등록 리스트</h1>
      </div>
      <div class="divform3">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="money_debtor" ${param.type == 'money_debtor' ? 'selected' : '' }>차변내용</option>
                        <option value="money_creditor" ${param.type == 'money_creditor' ? 'selected' : '' }>대변내용</option>
                     </select>
                  </td>
                  <td>
                     <input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surff(this.value, '${comcode_code}')">
                     <input type="button" value="전체목록" onclick="surff('', '${comcode_code}')">
                  </td>
               </tr>
            </table>
         </div>
         
         <div style="overflow: scroll;">
         <input type="hidden" id="com" value="${comcode_code }">
            <table id="procode">
            	<c:if test="${list2 != null }">
               		<tr>
						<th>고유코드</th>
						<th>일자</th>
						<th>차변내용</th>
						<th>차변금액</th>
						<th>대변내용</th>
						<th>대변금액</th>
					</tr>
               <c:forEach var="vo" items="${list2 }">
			<tr onclick="selectForm(${vo.money_no})" class="filter" id="filter">
			    <td>${vo.money_code}</td>
			    <td>${vo.money_date}</td>
			    <td>${vo.money_debtor}</td>
			    <td>${vo.money_debtoramount}</td>
			    <td>${vo.money_creditor}</td>
			    <td>${vo.money_creditoramount}</td>
			</tr>

				</c:forEach>
            </c:if>
            <c:if test="${list2 == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
      </div>
      </div>
      
         <%@ include file="/WEB-INF/views/layout/footer.jsp"%>