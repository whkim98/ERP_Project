<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div align="center">
	<table>
		<tr>
			<th>국가명</th>
			<th>거래처명</th>
			<th>거래처종류</th>
			<th>사업자등록번호</th>
			<th>법인등록번호</th>
			<th>대표자명</th>
			<th>사업형태</th>
			<th>업종코드</th>
			<th>업태명</th>
			<th>중분류</th>
			<th>세세분류명</th>
			<th>사업장</th>
			<th>상세주소</th>
			<th>우편주소</th>
			<th>대표번호</th>
			<th>팩스번호</th>
			<th>세금계산서이메일</th>
			<th>담당자명</th>
			<th>담당자연락처</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td>${vo.country_name }</td>
			<td>${vo.client_name }</td>
			<td>${vo.clientsort_name }</td>
			<td>${vo.client_registeredno }</td>
			<td>${vo.client_corporatedno }</td>
			<td>${vo.client_representative }</td>
			<td>${vo.client_businesstype }</td>
			<td>${vo.businesstype_code }</td>
			<td>${vo.businesstype_name }</td>
			<td>${vo.businesstype_biotore }</td>
			<td>${vo.businesstype_subctgr }</td>
			<td>${vo.client_addr1 }</td>
			<td>${vo.client_addr2 }</td>
			<td>${vo.client_postal }</td>
			<td>${vo.client_directno }</td>
			<td>${vo.client_fax }</td>
			<td>${vo.client_email }</td>
			<td>${vo.client_manager }</td>
			<td>${vo.client_contact }</td>
			<td><input type="button" value="거래처삭제" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/delete?client_no=${vo.client_no }'"></td>
			<td><input type="button" value="세부항목 관리" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/typeinsertForm?client_no=${vo.client_no }'"></td>
		</tr>
		</c:forEach>
	</table>
	<input type="button" value="추가등록" onclick="location.href='${pageContext.request.contextPath }/internationalsales/bond/addForm'">
</div>
 --%>





<!-- wnnnnntjrrnwnjnjsadakjsdnaosndoasndokasndokasndksandosan -->





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
   var url = "${pageContext.request.contextPath}/budget/ajax";   // controller mapping
   if(v == ''){
      type = null;
      v = null;
   }
   console.log(v);
   var param = "comcode_code="+code+"&word="+v+"&type="+type;      // 넘길 데이터
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
      procode.innerHTML += '<tr><td>항목</td><td>팀명</td><td>예산승인일</td><td>예산집행일</td><td>합계금액</td></tr>';
      if(data != ""){
         var data2 = JSON.parse(data);
         data2.forEach(function(map){      // 받아온 list 테이블에 입히기
            newTr = document.createElement("tr");
            newTr.setAttribute("onclick", "selectForm("+map.budget_no+")");
            procode.appendChild(newTr);
            newTd = document.createElement("td");
            newTd.innerHTML = map.budget_type;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.team_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.budget_approved;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.budget_execution;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.budget_total;
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
         <h1 style="font-size: 20pt;">예산관리</h1>
      </div>
      <div class="divform2">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="budget_type" ${param.type == 'budget_type' ? 'selected' : '' }>항목</option>
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
						<th>항목</th>
						<th>팀명</th>
						<th>예산승인일</th>
						<th>예산집행일</th>
						<th>합계금액</th>
					</tr>
               <c:forEach var="vo" items="${list }">
			     <tr onclick="selectForm(${vo.budget_no})" class="filter" id="filter">
			   		<td>${vo.budget_type }</td>
					<td>${vo.team_name }</td>
					<td>${vo.budget_approved }</td>
					<td>${vo.budget_execution }</td>
					<td>${vo.budget_total }</td>
				</tr>
				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
         
<div>
<input type="button" value="ADD" onclick="location.href='${pageContext.request.contextPath}/budget?comcode_code=${comcode_code }'">
</div>
         
<%--          <div align="right">
            <input type="button" onclick="location.href='${pageContext.request.contextPath }/a/a4/a41?comcode_code=${comcode_code }'" value="add">
         </div> --%>
   
   <!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->   
         <form action="${pageContext.request.contextPath }/budget/updateForm" id="content" method="post">
            <input type="hidden" name="budget_no">
            <input type="hidden" name="comcode_code" value="${comcode_code }">
         </form>
      
      </div>
      
      <div class="divform4">
         <hr class="hr">
      </div>
      
      <div id="add" class="divform3">
         <c:choose>
            <c:when test="${map != null }">
               <form action="${pageContext.request.contextPath }/budget/update" method="POST" id="update">
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                  <input type="hidden" name="budget_no" value="${map.budget_no }">
                  <div class="warning_box">
                     <span class="red bigger">* </span>
                     <div class="yellow_box"></div>
                     <span class="red">는 필수 입력란입니다.</span>
                  </div>
                     
                  <div>
                     <label>항목</label>
                     <input type="text" name="budget_type" id="budget_type" value="${map.budget_type }" maxlength="30">
                  </div>
                  <div>
                     <label>팀명 </label>
                     <select name="team_no">
					    <option value="3" ${map.team_no == 3 ? 'selected' : ''}>경영기획팀</option>
					    <option value="4" ${map.team_no == 4 ? 'selected' : ''}>전략기획팀</option>
					    <option value="6" ${map.team_no == 6 ? 'selected' : ''}>회계팀</option>
					    <option value="7" ${map.team_no == 7 ? 'selected' : ''}>재무팀</option>
					    <option value="8" ${map.team_no == 8 ? 'selected' : ''}>인사팀</option>
					    <option value="9" ${map.team_no == 9 ? 'selected' : ''}>총무팀</option>
					    <option value="11" ${map.team_no == 11 ? 'selected' : ''}>해외영업팀</option>
					    <option value="12" ${map.team_no == 12 ? 'selected' : ''}>국내영업팀</option>
					    <option value="13" ${map.team_no == 13 ? 'selected' : ''}>매장영업팀</option>
					    <option value="14" ${map.team_no == 14 ? 'selected' : ''}>영업관리팀</option>
					    <option value="16" ${map.team_no == 16 ? 'selected' : ''}>생산팀</option>
					    <option value="17" ${map.team_no == 17 ? 'selected' : ''}>구매팀</option>
					    <option value="18" ${map.team_no == 18 ? 'selected' : ''}>품질관리팀</option>
					    <option value="19" ${map.team_no == 19 ? 'selected' : ''}>물류팀</option>
					</select>
                  </div>
                  
                  <div>
                  	<label>예산내용</label>
                  	<input type="text" name="budget_contents" id="budget_contents" value="${map.budget_contents }" maxlength="500">
                  </div>
				  
				  <div>
                     <label>예산승인일 </label>
                     <input type="date" name="budget_approved" id="budget_approved" value="${map.budget_approved }">
                  </div>
                  
				  <div>
                     <label>예산집행일 </label>
                     <input type="date" name="budget_execution" id="budget_execution" value="${map.budget_execution }">
                  </div>
                  
                 <div>
                 	<label>금액</label>
                 	<input type="number" name="budget_amount" id="budget_amount" value="${map.budget_amount }">
                 </div>
                 
                 <div>
                 	<label>세액</label>
                 	<input type="number" name="budget_tax" id="budget_tax" value="${map.budget_tax }">
                 </div>
                                                      
                  <div align="right">
                     <input type="button" value="update" onclick="submitt(this.form)">
                     <input type="button" value="delete" onclick="deletei('${bs3_no}', '${dbs3_no }', ${map.forsales_no }, '${comcode_code }')">
                  </div>
               </form>
            </c:when>
            
            
            <c:otherwise>
            <form action="${pageContext.request.contextPath }/budget/insert" method="POST" id="create">
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                     <h3>예산관리 등록 사항</h3>
                  <div>
                     <label>항목 </label>
                     <input type="text" name="budget_type" id="budget_type" maxlength="30">
                  </div>
                  
                  <div>
                  	<label>팀명</label>
                  	<select name="team_no">
				  		<option value="3">경영기획팀</option>
				  		<option value="4">전략기획팀</option>
				  		<option value="6">회계팀</option>
				  		<option value="7">재무팀</option>
				  		<option value="8">인사팀</option>
				  		<option value="9">총무팀</option>
				  		<option value="11">해외영업팀</option>
				  		<option value="12">국내영업팀</option>
				  		<option value="13">매장영업팀</option>
				  		<option value="14">영업관리팀</option>
				  		<option value="16">생산팀</option>
				  		<option value="17">구매팀</option>
				  		<option value="18">품질관리팀</option>
				  		<option value="19">물류팀</option>
					</select>
                  </div>
                  
                  <div>
				    <label>예산내용</label>
				    <input type="text" name="budget_contents" id="budget_contents" maxlength="500">
				  </div>
				  
				  <div>
				  	<label>예산승인일</label>
				  	<input type="date" name="budget_approved" id="budget_approved">
				  </div>
				  
				  <div>
				  	<label>예산집행일</label>
				  	<input type="date" name="budget_execution" id="budget_execution">
				  </div>
                  
                  <div>
				    <label>금액</label>
				    <input type="number" name="budget_amount" id="budget_amount">
				  </div>   
				  
                  <div>
				    <label>세액</label>
				    <input type="number" name="budget_tax" id="budget_tax">
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
   location.href='${pageContext.request.contextPath }/internationsales/export/delete?forsales_no='+ino+'&bs3_no='+no1+'&dbs3_no='+no2+'&comcode_code='+code;
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
	   
	   var budget_type = document.getElementById("budget_type").value;
	   var budget_contents = document.getElementById("budget_contents").value;
	   var budget_approved = document.getElementById("budget_approved").value;
	   var budget_execution = document.getElementById("budget_execution").value;
	   var budget_amount = document.getElementById("budget_amount").value;
	   var budget_tax = document.getElementById("budget_tax").value;
	   
	   if(budget_type == ""){
		   alert('항목을 입력해 주세요');
		   document.getElementById('budget_type').focus();
		   return false;
	   }else if (budget_contents == "") {
	     alert("내용을 입력해 주세요");
	     document.getElementById("budget_contents").focus();
	     return false; // 폼 제출 방지
	   }else if (budget_approved == "") {
		 alert("예산승인일을 입력해 주세요");
		 document.getElementById("budget_approved").focus();
		 return false; // 폼 제출 방지
	   }else if (budget_execution == "") {
		 alert("예산집행일을 입력해 주세요");
		 document.getElementById("budget_execution").focus();
		 return false; // 폼 제출 방지
	   }else if (budget_amount == "") {
		 alert("금액을 입력해 주세요");
		 document.getElementById("budget_amount").focus();
		 return false; // 폼 제출 방지
	   }else if (budget_tax == "") {
		 alert("세액을 입력해 주세요");
		 document.getElementById("budget_tax").focus();
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
   document.getElementsByName("budget_no")[0].value = no;
   document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>