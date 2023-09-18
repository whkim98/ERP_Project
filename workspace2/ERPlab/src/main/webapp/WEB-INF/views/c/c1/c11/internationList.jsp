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
   var url = "${pageContext.request.contextPath}/internationalsales/bond/ajax";   // controller mapping
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
      procode.innerHTML += '<tr><td>국가명</td><td>거래처명</td><td>거래처종류</td><td>대표자명</td><td>사업형태</td><td>업태명</td><td>대표번호</td><td>담당자연락처<td></tr>';
      if(data != ""){
         var data2 = JSON.parse(data);
         data2.forEach(function(map){      // 받아온 list 테이블에 입히기
            newTr = document.createElement("tr");
            newTr.setAttribute("onclick", "selectForm("+map.client_no+", "+map.bs3_no1+", "+map.bs3_no2+")");
            procode.appendChild(newTr);
            newTd = document.createElement("td");
            newTd.innerHTML = map.country_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.clientsort_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_representative;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_businesstype;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.businesstype_name;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_directno;
            newTr.appendChild(newTd);
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_manager;
            newTd = document.createElement("td");
            newTd.innerHTML = map.client_contact;
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
         <h1 style="font-size: 20pt;">거래처 관리</h1>
      </div>
      <div class="divform2">
         <div>
            <table>
               <tr>
                  <td>
                     <select name="type">
                        <option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
                        <option value="country_name" ${param.type == 'country_name' ? 'selected' : '' }>국가명</option>
                        <option value="clientsort_name" ${param.type == 'clientsort_name' ? 'selected' : '' }>거래처종류</option>
                        <option value="businesstype_name" ${param.type == 'businesstype_name' ? 'selected' : '' }>업태명</option>
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
						<th>국가명</th>
						<th>거래처명</th>
						<th>거래처종류</th>
						<th>대표자명</th>
						<th>사업형태</th>
						<th>업태명</th>
						<th>대표번호</th>
						<th>담당자명</th>
						<th>담당자연락처</th>
					</tr>
               <c:forEach var="vo" items="${list }">
			     <tr onclick="selectForm(${vo.client_no})" class="filter" id="filter">
			   		<td>${vo.country_name }</td>
					<td>${vo.client_name }</td>
					<td>${vo.clientsort_name }</td>
					<td>${vo.client_representative }</td>
					<td>${vo.client_businesstype }</td>
					<td>${vo.businesstype_name }</td>
					<td>${vo.client_directno }</td>
					<td>${vo.client_manager }</td>
					<td>${vo.client_contact }</td>
				</tr>
				</c:forEach>
            </c:if>
            <c:if test="${list == null }">
               <tr><td>목록이 비어있습니다</td></tr>
            </c:if>
            </table>
         </div>
         <div>
		<input type="button" value="ADD" onclick="location.href='${pageContext.request.contextPath}/internationalsales/list?comcode_code=${comcode_code }'">
		</div>
<%--          <div align="right">
            <input type="button" onclick="location.href='${pageContext.request.contextPath }/a/a4/a41?comcode_code=${comcode_code }'" value="add">
         </div> --%>
   
   <!-- 리스트 클릭 시 url 데이터 숨기기 위한 form태그 -->   
         <form action="${pageContext.request.contextPath }/internationalsales/bond/updateForm" id="content" method="post">
            <input type="hidden" name="client_no">
            <input type="hidden" name="comcode_code" value="${comcode_code }">
         </form>
      
      </div>
      
      <div class="divform4">
         <hr class="hr">
      </div>
      
      <div id="add" class="divform3">
         <c:choose>
            <c:when test="${map != null }">
               <form action="${pageContext.request.contextPath }/internationalsales/bond/update" method="POST" id="update">
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                  <input type="hidden" name="client_no" value="${map.client_no }">
                  <input type="hidden" name="country_no" id="country_no" value="${map.country_no }">
                  <input type="hidden" name="businesstype_no" id="businesstype_no" value="${map.businesstype_no }">
                  <div class="warning_box">
                     <span class="red bigger">* </span>
                     <div class="yellow_box"></div>
                     <span class="red">는 필수 입력란입니다.</span>
                  </div>
                     
                  <div>
                     <label>국가명 </label>
                     
                     <select name="country_no">
			  		<option value="1">미국</option>
			  		<option value="2">캐나다</option>
			  		<option value="3">버진아일랜드(미)</option>
			  		<option value="4">북마리아나제도</option>
			  		<option value="5">괌</option>
			  		<option value="6">아메리칸사모아</option>
			  		<option value="7">푸에르토리코</option>
			  		<option value="8">버뮤다</option>
			  		<option value="9">바하마</option>
			  		<option value="10">바베이도스</option>
			  		<option value="11">앵귈라</option>
			  		<option value="12">바부다</option>
			  		<option value="13">버진아일랜드</option>
			  		<option value="14">케이맨 제도</option>
			  		<option value="15">그레나다</option>
			  		<option value="16">케이커스제도</option>
			  		<option value="17">몬트세렛</option>
			  		<option value="18">신트마르턴</option>
			  		<option value="19">세인트루시아</option>
			  		<option value="20">도미니카 연방</option>
			  		<option value="21">세인트빈센트 그레나딘</option>
			  		<option value="22">도미니카 공화국</option>
			  		<option value="23">트리니다드 토바고</option>
			  		<option value="24">세인트키츠 네비스</option>
			  		<option value="25">일본</option>
			  		<option value="26">대한민국</option>
			  		<option value="27">베트남</option>
			  		<option value="28">조선민주주의인민공화국</option>
			  		<option value="29">홍콩</option>
			  		<option value="30">마카오</option>
			  		<option value="31">캄보디아</option>
			  		<option value="32">라오스</option>
			  		<option value="33">중화인민공화국</option>
			  		<option value="34">방글라데시</option>
			  		<option value="35">중화민국</option>
				</select>
                  </div>
                  
                  <div>
                     <label>거래처명 </label>
                     <input type="text" name="client_name" id="client_name" value="${map.client_name }" maxlength="30">
                  </div>
                  
                  <div>
                     <label>거래처종류 </label>
                     <c:if test="${map.clientsort_no == 2 }">
                     <select name="clientsort_no">
					<option value="2" selected>매출</option>
					<option value="1">매입</option>
				</select>
				</c:if>
                     <c:if test="${map.clientsort_no == 1 }">
                     <select name="clientsort_no">
					<option value="2">매출</option>
					<option value="1" selected>매입</option>
				</select>
				</c:if>
                  </div>
                  
                  <div>
                     <label>사업자등록번호 </label>
                    <input type="text" name="client_registeredno" id="client_registeredno" value="${map.client_registeredno }" maxlength="30">
                  </div>   
                     
                  <div>
                     <label>법인등록번호 </label>
                    <input type="text" name="client_corporatedno" id="client_corporatedno" value="${map.client_corporatedno }" maxlength="30">
                  </div> 
                    
                  <div>
                     <label>대표자명 </label>
                     <input type="text" name="client_representative" id="client_representative" value="${map.client_representative }" maxlength="30">
                  </div>   
                  <div>
                     <label>사업형태 </label>
                     <input type="text" name="client_businesstype" id="client_businesstype" value="${map.client_businesstype }" maxlength="30">
                  </div>   
                  <div>
                     <label>사업장 </label>
                    <input type="text" name="client_addr1" id="client_addr1" value="${map.client_addr1 }" maxlength="100">
                    <input type="text" name="client_addr2" id="client_addr2" value="${map.client_addr2 }" maxlength="50">
                    <input type="text" name="client_postal" id="client_postal" value="${map.client_postal }" maxlength="10">
                  </div>   
                  <div>
                     <label>대표번호 </label>
                    <input type="text" name="client_directno" id="client_directno" value="${map.client_directno }" maxlength="30">
                  </div>   
                  <div>
                     <label>팩스번호 </label>
                     <input type="text" name="client_fax" id="client_fax" value="${map.client_fax }" maxlength="30">
                  </div>   
                  <div>
                     <label>세금계산서이메일 </label>
                     <input type="text" name="client_email" id="client_email" value="${map.client_email }" maxlength="30">
                  </div>   
                  <div>
                     <label>담당자명 </label>
                     <input type="text" name="client_manager" id="client_manager" value="${map.client_manager }" maxlength="30">
                  </div>   
                  <div>
                     <label>담당자연락처 </label>
                     <input type="text" name="client_contact" id="client_contact" value="${map.client_contact }" maxlength="30">
                  </div>   
                                    
                  <div align="right">
                     <input type="button" value="update" onclick="sub(this.form)">
                     <input type="button" value="delete" onclick="deletei('${bs3_no1}', '${bs3_no2 }', ${inmap.investment_no }, '${comcode_code }')">
                  </div>
               </form>
            </c:when>
            
            
            <c:otherwise>
               <form action="${pageContext.request.contextPath }/internationalsales/bond/insert" method="POST" id="create">
                  <input type="hidden" name="comcode_code" value="${comcode_code }">
                     <h3>거래처 등록 사항</h3>
                  <div>
                     <label>국가명 </label>
                     <select name="country_no">
			  		<option value="1">미국</option>
			  		<option value="2">캐나다</option>
			  		<option value="3">버진아일랜드(미)</option>
			  		<option value="4">북마리아나제도</option>
			  		<option value="5">괌</option>
			  		<option value="6">아메리칸사모아</option>
			  		<option value="7">푸에르토리코</option>
			  		<option value="8">버뮤다</option>
			  		<option value="9">바하마</option>
			  		<option value="10">바베이도스</option>
			  		<option value="11">앵귈라</option>
			  		<option value="12">바부다</option>
			  		<option value="13">버진아일랜드</option>
			  		<option value="14">케이맨 제도</option>
			  		<option value="15">그레나다</option>
			  		<option value="16">케이커스제도</option>
			  		<option value="17">몬트세렛</option>
			  		<option value="18">신트마르턴</option>
			  		<option value="19">세인트루시아</option>
			  		<option value="20">도미니카 연방</option>
			  		<option value="21">세인트빈센트 그레나딘</option>
			  		<option value="22">도미니카 공화국</option>
			  		<option value="23">트리니다드 토바고</option>
			  		<option value="24">세인트키츠 네비스</option>
			  		<option value="25">일본</option>
			  		<option value="26">대한민국</option>
			  		<option value="27">베트남</option>
			  		<option value="28">조선민주주의인민공화국</option>
			  		<option value="29">홍콩</option>
			  		<option value="30">마카오</option>
			  		<option value="31">캄보디아</option>
			  		<option value="32">라오스</option>
			  		<option value="33">중화인민공화국</option>
			  		<option value="34">방글라데시</option>
			  		<option value="35">중화민국</option>
				</select>
                  </div>
                  
                  <div>
                     <label>거래처명 </label>
                     <input type="text" name="client_name" id="client_name" maxlength="30">
                  </div>
                  
                  <div>
                     <label>거래처종류 </label>
                     <select name="clientsort_no">
					<option value="2">매출</option>
					<option value="1">매입</option>
				</select>
                  </div>
                  
                  <div>
                     <label>사업자등록번호 </label>
                    <input type="text" name="client_registeredno" id="client_registeredno" maxlength="30">
                  </div>   
                     
                  <div>
                     <label>법인등록번호 </label>
                    <input type="text" name="client_corporatedno" id="client_corporatedno" maxlength="30">
                  </div> 
                    
                  <div>
                     <label>대표자명 </label>
                     <input type="text" name="client_representative" id="client_representative" maxlength="30">
                  </div>   
                  <div>
                     <label>사업형태 </label>
                     <input type="text" name="client_businesstype" id="client_businesstype" value="법인" maxlength="30">
                  </div>   
                  <div>
                     <label>사업장 </label>
                    <input type="text" name="client_addr1" id="client_addr1" maxlength="100">
                    <input type="text" name="client_addr2" id="client_addr2" maxlength="50">
                    <input type="text" name="client_postal" id="client_postal" maxlength="10">
                  </div>   
                  <div>
                     <label>대표번호 </label>
                    <input type="text" name="client_directno" id="client_directno" maxlength="30">
                  </div>   
                  <div>
                     <label>팩스번호 </label>
                     <input type="text" name="client_fax" id="client_fax" maxlength="30">
                  </div>   
                  <div>
                     <label>세금계산서이메일 </label>
                     <input type="text" name="client_email" id="client_email" maxlength="30">
                  </div>   
                  <div>
                     <label>담당자명 </label>
                     <input type="text" name="client_manager" id="client_manager" maxlength="30">
                  </div>   
                  <div>
                     <label>담당자연락처 </label>
                     <input type="text" name="client_contact" id="client_contact" maxlength="30">
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
	   
	   var client_name = document.getElementById("client_name").value;
	   var client_registeredno = document.getElementById("client_registeredno").value;
	   var client_corporatedno = document.getElementById("client_corporatedno").value;
	   var client_representative = document.getElementById("client_representative").value;
	   var client_businesstype = document.getElementById("client_businesstype").value;
	   var client_addr1 = document.getElementById("client_addr1").value;
	   var client_addr2 = document.getElementById("client_addr2").value;
	   var client_postal = document.getElementById("client_postal").value;
	   var client_directno = document.getElementById("client_directno").value;
	   var client_fax = document.getElementById("client_fax").value;
	   var client_email = document.getElementById("client_email").value;
	   var client_manager = document.getElementById("client_manager").value;
	   var client_contact = document.getElementById("client_contact").value;
	   
	   console.log(client_name);
	   console.log(client_registeredno);
	   
	   if(client_name == ""){
		   alert('거래쳐명을 입력해 주세요');
		   document.getElementById('client_name').focus();
		   return false;
	   }else if (client_registeredno == "") {
	     alert("사업자등록번호를 입력해 주세요");
	     document.getElementById("client_registeredno").focus();
	     return false; // 폼 제출 방지
	   }else if(client_corporatedno == ""){
		  alert("법인등록번호를 입력해 주세요");
		  document.getElementById("client_corporatedno").focus();
		  return false;
	   }else if(client_representative == ""){
		   alert("대표자명을 입력해 주세요");
		   document.getElementById("client_representative").focus();
		   return false;
	   }else if(client_businesstype == ""){
		   alert("사업형태를 입력해 주세요");
		   document.getElementById("client_businesstype").focus();
		   return false;
	   }else if(client_addr1 == "" || client_addr2 == "" || client_postal == ""){
		   alert("사업장 및 주소를 입력해 주세요");
		   document.getElementById("client_addr1").focus();
		   return false;
	   }else if(client_directno == ""){
		   alert("대표번호를 입력해 주세요");
		   document.getElementById("client_directno").focus();
		   return false;
	   }else if(client_fax == ""){
		   alert("팩스번호를 입력해 주세요");
		   document.getElementById("client_fax").focus();
		   return false;
	   }else if(client_email == ""){
		   alert("이메일을 입력해 주세요");
		   document.getElementById("client_email").focus();
		   return false;
	   }else if(client_manager == ""){
		   alert("담당자명을 입력해 주세요");
		   document.getElementById("client_manager").focus();
		   return false;
	   }else if(client_contact == ""){
		   alert("담당자번호를 입력해 주세요");
		   document.getElementById("client_contact").focus();
		   return false;
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
   document.getElementsByName("client_no")[0].value = no;
   document.getElementById("content").submit(); // content라는 id의 form태그 submit
}


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp"%>