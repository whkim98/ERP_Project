<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<%@include file="/WEB-INF/views/layout/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>

<link href="/webdesign/assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/css/a/a_company.css" />
<style type="text/css">
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
<script type="text/javascript" charset="UTF-8">

function surf(v, code){      // list ajax 함수 > A4Controller, a4.xml(investmentList select문)
   var type = document.getElementsByName("type")[0].value;
   var url = "${pageContext.request.contextPath}/greeting/salary/ajax";   // controller mapping
   if(v == ''){
      type = null;
      v = null;
   }
   console.log(v);
   employee1_code = document.getElementById("employee1_code").value;
   console.log(employee1_code);
   var param = "comcode_code="+code+"&word="+v+"&type="+type+"&employee1_code="+employee1_code;      // 넘길 데이터
   console.log(param);
   sendRequest(url,param,getlist,"POST");
}
function getlist(){
   if(xhr.readyState==4 && xhr.status==200) {   
      var data = xhr.response;
      let procode = document.getElementById("procode");    // list가 들어갈 테이블 id
      let newTr = document.createElement("tr");      // tr 만듦
      let newTd = document.createElement("td");      // td 만듦
      procode.innerHTML = '';                     // 일단 테이블 비워줌
      procode.innerHTML += '<tr><td>코드</td><td>직원명</td><td>추가근무종류</td><td>근무날짜</td><td>시작시간</td><td>종료시간</td><td>수당</td></tr>';
      if(data != ""){
         var data2 = JSON.parse(data);
         data2.forEach(function(map){      // 받아온 list 테이블에 입히기
            newTr = document.createElement("tr");
            newTr.setAttribute("onclick", "selectForm("+map.salary_no+", "+map.bs3_no1+", "+map.bs3_no2+")");
            procode.appendChild(newTr);
            newTd = document.createElement("td");
            newTd.innerHTML = map.salary_code;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.employee1_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.salarytype_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.salary_date;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.salary_start;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.salary_end;
            newTr.appendChild(newTd);
            if(map.salary_cash == undefined){
            	
            	map.salary_cash = "";
            }
            newTd = document.createElement("td");
            newTd.innerHTML = map.salary_cash;
            newTr.appendChild(newTd);
         });
      }else {
         procode.innerHTML += '<tr><td colspan="3">목록이 없습니다.</td></tr>';
      }
   }
}


//전체목록조회 > 새창으로
function searchim(){
   let openWin = window.open("${pageContext.request.contextPath}/a/a4/searchim", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function searcht(){
   let openWin = window.open("${pageContext.request.contextPath}/a/a4/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function acList(code, team){
   let openWin = window.open("${pageContext.request.contextPath}/a/a4/acList?comcode_code="+code+"&team_code="+team, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}
function clList(code){
   let openWin = window.open("${pageContext.request.contextPath}/a/a4/clList?comcode_code="+code, "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

//자동완성 > AJAX
function imkind(e, name){
   if(e.keyCode == 13){
      if(name == ""){      // 매개변수값이 비어있는 지 판단
         alert("종류를 입력해주세요.");
         document.getElementById("imkind_name").focus();
         return;   // 비어있으면 imkind_name에 포커싱되고 메소드 종료
      }
      var url = "${pageContext.request.contextPath}/a/a4/imkind";      // url 경로 지정 > controller 매핑
      var param = "imkind_name=" + encodeURIComponent(name);      // controller에 넘길 데이터 인코드해서 세팅
      
      sendRequest(url, param, investmentkind, "POST");   // httpRequest.js에 있는 sendRequest함수 실행 > (경로,넘길데이터,콜벡함수,방식);
   }
}
function investmentkind(){   // 콜벡함수
   if(xhr.readyState==4 && xhr.status==200) {      // 신호가 정상인 지 판단
      var data = xhr.response;   // 넘어온 데이터 세팅
      if(data != ""){         // 넘어온 데이터가 null인지 판단
         var data2 = JSON.parse(data);      // 넘어온 데이터 json으로 변형
         document.getElementById("imkind_name").value = data2.imkind_name;   // 넘어온 데이터 input태그에 세팅
         document.getElementById("imkind_no").value = data2.imkind_no;
      }else {
         document.getElementById("imkind_name").value = '';      // 데이터가 비어있으면 실행
         alert("조회된 종류가 없습니다. 조회 버튼을 클릭하여 목록에서 종류를 선택해주세요.");
      }
   }
}

function team(e, name){
   if(e.keyCode == 13){
      if(name == ""){
         alert("팀명을 입력해주세요.");
         document.getElementById("team_name").focus();
         return;
      }
      var url = "${pageContext.request.contextPath}/a/a4/team";
      var param = "team_name=" + encodeURIComponent(name);
      
      sendRequest(url, param, teamname, "POST");
   }
}
function teamname(){
   if(xhr.readyState==4 && xhr.status==200) {
      var data = xhr.response;
      if(data != ""){
         var data2 = JSON.parse(data);
         document.getElementById("team_name").value = data2.team_name;
         document.getElementById("team_no").value = data2.team_no;
      }else {
         document.getElementById("team_name").value = '';
         alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
      }
   }
}
</script>

   <div class="notosanskr">
      <div align="center">
         <h1 style="font-size: 20pt;">정산관리</h1>
      </div>
      <div class="divform2">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="salary_code" ${param.type == 'salary_code' ? 'selected' : '' }>정산코드</option>
                        <option value="salary_date" ${param.type == 'salary_date' ? 'selected' : '' }>근무날짜</option>
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
            <table id="procode">
            <c:if test="${list != null }">
               <tr>
                  <td>직원명</td>
                  <td>근무종류</td>
                  <td>근무날짜</td>
                  <td>시작시간</td>
                  <td>종료시간</td>
                  <td>수당</td>
               </tr>
               <c:forEach var="map" items="${list }">
               <tr onclick="selectForm(${map.salary_no})" class="filter" id="filter">
                  <td class="price">${map.employee1_name }</td>
                  <td class="cont">${map.salarytype_name }</td>
                  <td class="cont">${map.salary_date }</td>
                  <td class="cont">${map.salary_start }</td>
                  <td class="cont">${map.salary_end }</td>
                  <td class="cont">${map.salary_cash }</td>
               </tr>
               </c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
   
   <!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->   
         <form action="${pageContext.request.contextPath }/greeting/salary/updateForm" id="content" method="post">
            <input type="hidden" name="salary_no">
            <input type="hidden" name="employee1_code" value="${employee1_code }">
            <input type="hidden" name="comcode_code" value="${comcode_code }">
         </form>
      
      </div>
      
      <div class="divform4">
         <hr class="hr">
      </div>
      
      <div id="add" class="divform3">
         <c:choose>
            <c:when test="${map != null}">
               <form action="${pageContext.request.contextPath }/greeting/salary/update" method="POST" id="update">
       
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                  <input type="hidden" name="salary_no" value="${map.salary_no }">
                  <input type="hidden" name="ctgr_no" id="ctgr_no" value="${map.ctgr_no }">
                  <input type="hidden" name="employee2_no" id="employee2_no" value="${map.employee2_no }">
                  <input type="hidden" name="salarytype_no" id="salarytype_no" value="${map.salarytype_no }">
                  <input type="hidden" name="bs3_no" id="bs3_no" value="${map.bs3_no }">
                  <input type="hidden" name="bs2_no" id="bs2_no" value="${map.bs3_no }">
                  <input type="hidden" name="bs1_no" id="bs1_no" value="${map.bs1_no }">
                
                  <div class="warning_box">
                     <span class="red bigger">* </span>
                     <div class="yellow_box"></div>
                     <span class="red">는 필수 입력란입니다.</span>
                  </div>
                     
                  <div>
                     <label>정산코드 </label>
                     <input type="text" name="salary_code" id="salary_code" value="${map.salary_code }" maxlength="30">
                  </div>
                  
                  
                  <div>
                     <label>근무날짜 </label>
                     <input type="date" name="salary_date" id="salary_date" value="${map.salary_date }">
                  </div>
                  
                  <div>
                     <label>직원코드 </label>
                     <input type="text" name="employee1_code" id="employee1_code" value="${map.employee1_code }" readonly="readonly">
                  </div>
                  
                  <div>
                     <label>추가근무종류 </label>
                     <c:if test="${map.salarytype_name == '야간근무'}">
                     <select name="salarytype_name">
				  		<option value="야간근무" selected>야간근무</option>
				  		<option value="출장">출장</option>
				  		<option value="휴일근무">휴일근무</option>
					 </select>
					 </c:if>
                     <c:if test="${map.salarytype_name ==  '출장'}">
                     <select name="salarytype_name">
				  		<option value="야간근무">야간근무</option>
				  		<option value="출장" selected>출장</option>
				  		<option value="휴일근무">휴일근무</option>
					 </select>
					 </c:if>
                     <c:if test="${map.salarytype_name ==  '휴일근무'}">
                     <select name="salarytype_name">
				  		<option value="야간근무">야간근무</option>
				  		<option value="출장">출장</option>
				  		<option value="휴일근무" selected>휴일근무</option>
					 </select>
					 </c:if>
                  </div>   
                     
                  <div>
                     <label>시작시간 </label>
                     <input type="time" name="salary_start" id="salary_start" value="${map.salary_start }">
                  </div> 
                    
                  <div>
                     <label>종료시간 </label>
                     <input type="time" name="salary_end" id="salary_end" value="${map.salary_end }">
                  </div>   
                  
                  
                  
                  <div>
                     <label>차변 </label>
                     <select name="bs3_no">
						  <c:forEach var="vo" items="${blist}">
						    <option value="${vo.bs3_no}" ${vo.bs3_no == map.bs3_no ? 'selected' : ''}>
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>

                  </div>   
                  
                  <div>
                     <label>대변</label> 
                     <select name="dbs3_no">
						  <c:forEach var="vo" items="${blist}">
						    <option value="${vo.bs3_no}" ${vo.bs3_no == map2.bs3_no ? 'selected' : ''}>
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>
                  </div>
                  
                  <div align="right">
                     <input type="button" value="update" onclick="submitt(this.form)">
                     <input type="button" value="delete" onclick="deletei('${bs3_no1}', '${bs3_no2 }', ${inmap.investment_no }, '${comcode_code }')">
                  </div>
               </form>
               
            </c:when>
            
            
            <c:otherwise>
               <form action="${pageContext.request.contextPath }/greeting/salary/insert" method="POST" id="create">
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                     <h3>차입 등록 사항</h3>
                  <div>
                     <label>정산코드 </label>
                     <input type="text" name="salary_code" id="salary_code" maxlength="30" class="required">
                     <h6 id="imcodecheck" style="color:red;"></h6>
                  </div>
                  
                  <div>
                     <label>근무날짜 </label>
                     <input type="date" name="salary_date" id="salary_date">
                  </div>
                  
                  <div>
                     <label>직원코드 </label>
                     <input type="text" name="employee1_code" id="employee1_code" value="${employee1_code }" readonly="readonly">
                  </div>
                  
                  <div>
                     <label>추가근무종류 </label>
                     <select name="salarytype_name">
				  		<option value="야간근무">야간근무</option>
				  		<option value="출장">출장</option>
				  		<option value="휴일근무">휴일근무</option>
					 </select>
                  </div>   
                     
                  <div>
                     <label>시작시간 </label>
                     <input type="time" name="salary_start" id="salary_start" value="17:00">
                  </div> 
                    
                  <div>
                     <label>종료시간 </label>
                     <input type="time" name="salary_end" id="salary_end" value="17:00">
                  </div>   
                  
                  
                  
                  <div>
                     <label>차변 </label>
                     <select name="bs3_no">
						  <c:forEach var="vo" items="${blist}">
						    <option value="${vo.bs3_no}" ${vo.bs3_no == 28 ? 'selected' : ''}>
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>

                  </div>   
                  
                  <div>
                     <label>대변</label> 
                     <select name="dbs3_no">
						  <c:forEach var="vo" items="${blist}">
						    <option value="${vo.bs3_no}" ${vo.bs3_no == 4 ? 'selected' : ''}>
						      ${vo.bs3_ctgr}
						    </option>
						  </c:forEach>
						</select>
                  </div>
                  
                  <div>
                     <input type="button" id="register" value="save" onclick="submitt(this.form)">
                     <input type="reset" value="reset">
                  </div>
               </form>
            </c:otherwise>
         </c:choose>
         
      </div>
   
</div>
<script type="text/javascript">

// 삭제버튼 경로 및 넘길 parameter 설정
function deletei(no1, no2, ino, code){
   location.href='${pageContext.request.contextPath }/a/a4/a41/delete?investment_no='+ino+'&bs3_no1='+no1+'&bs3_no2='+no2+'&comcode_code='+code;
}


// 코드 UNIQUE 검사 AJAX
function imcode(v){
   var url = "${pageContext.request.contextPath }/b/b6/imcode";   // controller mapping 지정
   var param = "salary_code="+encodeURIComponent(v);         // parameter로 넘길 데이터 인코드해서 설정
   
   sendRequest(url,param,imcodecheck,"POST");      // httpRequest.js파일에 있는 sendRequest메소드 실행 > (경로, 데이터, 콜벡함수, 방식)
}
function imcodecheck(){      // imcode의 sendRequest에서 지정한 콜벡함수
   if(xhr.readyState==4 && xhr.status==200) {      // 신호가 정상인지 판단
      var data = xhr.responseText;            // controller에서 넘어온 데이터
      if(data != ""){      // 데이터가 정상적으로 넘어왔는 지 판단
         if(data == "사용 가능한 코드입니다."){      // 데이터값 판단
            document.getElementById("imcodecheck").innerText = data;   // imcodecheck라는 id의 text에 넘어온 data 저장
            document.getElementById("imcodecheck").style.color = "blue";
            document.getElementById("register").disabled = false;      // register 라는 id의 태그 활성화 > 버튼 활성화
         }else {
            document.getElementById("imcodecheck").innerText = data;
            document.getElementById("register").disabled = true;      // 버튼 비활성화
            document.getElementById("investment_code").focus();         // investment_code에 커서 지정
         }
      }
   }
}


//   bs3_no 세팅
   function check1(){
      let t = document.getElementById("debtor_no");   // debtor_no 불러옴
      let arr = document.querySelectorAll("#debtor_no > option");   // debtor_no의 옵션 태그들 nodelist로 불러옴
      let bs3_no1 = document.getElementById("bs3_no1");   // bs3_no1 불러옴
      arr.forEach(function(e, i, array) {
         if(t.value == e.value){      // 위에서 선언한 debtor_no를 불러온 값과 option태그들의 value값을 for문으로 전부 검사
            bs3_no1.value = e.id;   // value가 같으면 해당 옵션태그의 id를 bs3_no1에 저장
         }               // check 메소드 전부 동일
      });
   }
   function check2(){
      let t = document.getElementById("creditor_no");
      let arr = document.querySelectorAll("#creditor_no > option");
      let bs3_no2 = document.getElementById("bs3_no2");
      arr.forEach(function(e, i, array) {
         if(t.value == e.value){
            bs3_no2.value = e.id;
         }
      });
   }
   
   function check12(){
      let t = document.getElementById("debtor_no");
      let arr = document.querySelectorAll("#debtor_no > option");
      let bs3_no1 = document.getElementById("bs3_no12");
      arr.forEach(function(e, i, array) {
         if(t.value == e.value){
            bs3_no1.value = e.id;
         }
      });
   }
   function check22(){
      let t = document.getElementById("creditor_no");
      let arr = document.querySelectorAll("#creditor_no > option");
      let bs3_no2 = document.getElementById("bs3_no22");
      arr.forEach(function(e, i, array) {
         if(t.value == e.value){
            bs3_no2.value = e.id;
         }
      });
   }

   function submitt(f) {
	   var salary_start = document.getElementById("salary_start").value;
	   var salary_end = document.getElementById("salary_end").value;
	   
	   var salary_code = document.getElementById("salary_code").value;
	   
	   console.log(salary_start);
	   console.log(salary_end);
	   
	   if(salary_code == ""){
		   alert('정산코드를 입력해 주세요');
		   document.getElementById('salary_code').focus();
		   return false;
	   }else if (salary_start == salary_end) {
	     alert("올바른 시간을 입력해 주세요");
	     document.getElementById("salary_start").focus();
	     return false; // 폼 제출 방지
	   }else {
		      var ch = confirm("등록하시겠습니까?");
		      if(ch){
		         f.submit();
		      }else {
		         return;
		      }
		   }

	   return true; // 폼 제출 허용
	 }



   

// 거래처 자동완성 AJAX
function searchcl(e, code){
   if(e.keyCode == 13){
      var clname = document.getElementById("client_name").value;
      if(clname == ""){
         alert("조회할 거래처명을 입력해주세요.");
         document.getElementById("client_name").focus();
         return;
      }
      var url = "${pageContext.request.contextPath}/a/a4/searchcl";
      var param = "comcode_code="+encodeURIComponent(code)+"&client_name="+encodeURIComponent(clname);
      
      sendRequest(url, param, clName, "POST");
   }
}
function clName(){
   if(xhr.readyState==4 && xhr.status==200) {
      var data = xhr.response;
      if(data != ""){
         var data2 = JSON.parse(data);   // ajax로 받아온 데이터를 json으로 변형
         document.getElementById("client_no").value = data2.client_no;
         document.getElementById("client_name").value = data2.client_name;
         document.getElementById("client_registeredno").value = data2.client_registeredno;
         document.getElementById("client_manager").value = data2.client_manager;
      }else {
         document.getElementById("client_name").value = '';
         document.getElementById("client_registeredno").value = '';
         document.getElementById("client_manager").value = '';
         alert("조회된 거래처가 없거나 중복된 이름입니다. 조회 버튼을 클릭하여 거래처를 선택해주세요.");
      }
   }
}


// 리스트에서 글 선택 시 넘어가는 form
function selectForm(no){
   document.getElementsByName("salary_no")[0].value = no;
   document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>