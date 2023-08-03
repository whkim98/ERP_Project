<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
.dividerbk {
        position: absolute; 
        width: 100%; 
        height: 2px; 
        background-color: black; 
        top: 50%; 
        transform: translateY(-50%); 
    }
.sidebar-box {
    position: fixed;
    top: 43%;
    left: 0;
    transform: translateY(-50%);
    background-color: #03fca9;
    border-radius: 5px;
    width: 200px;
    max-height: 500px;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin-bottom: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    z-index: 999;
    overflow-y: auto; /* 사이드바에 휠 적용 */
    }
 .my_box1 {
        position: relative; 
        background-color: white;
        width: 190px;
        max-height: 200px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
        visibility: visible;
    }
 .box2 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 180px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box3 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 100px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box4 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 250px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box5 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 140px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box6 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 100px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box7 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 280px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box8 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 180px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box9 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 180px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box10 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 140px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box11 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 350px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box12 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 130px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box13 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 210px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
 .box14 {
        position: relative; 
        background-color: white;
        width: 190px;
        height: 160px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
    
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="sidebar-box">
    <!-- 사이드바 내용 -->
    <div class="my_box1">
        <h2>경영기획팀</h2>
        <div>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">회사정보</a>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">사업자정보</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">사업자정보</a>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">경영자정보</a>
        </div>
    </div>
    <div class="box2">
        <h2>전략기획팀</h2>
        <div>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">프로젝트</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">계약관리</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">실적 / 평가</a>
        </div>
    </div>
    <div class="box3">
        <h2>회계팀</h2>
        <div>
            추가예정
        </div>
    </div>
    <div class="box4">
        <h2>재무팀</h2>
        <div>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">계좌현황및관리</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">자금관리</a>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">예산관리</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">전표입력</a>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">외화관리</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">전자세금계산서</a><br><br>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">마감/결산</a>
            <a href="javascript:void(0)" onclick="toggleFetchContent()">원가분석</a>
        </div>
    </div>
    <div class="box5">
    	<h2>인사팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">인사정보</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">조직관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">근태관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">정산</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">퇴직</a>
    	</div>
    </div>
    <div class="box6">
    	<h2>총무팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">기자재</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">비품/소모품</a>
    	</div>
    </div>
    <div class="box7">
    	<h2>해외영업팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">국가별분류</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">해외거래처관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">수출관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">수출채권</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">수입(매입)</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">수입발주관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">수입채무관리</a>
    	</div>
    </div>
    <div class="box8">
    	<h2>국내영업팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">국내거래처관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">채권관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">반품관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">영업전표</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">매출현황</a>
    	</div>
    </div>
    <div class="box9">
    	<h2>매장영업팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">매장관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">발주관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">고객관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">창고관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">행사관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">온라인</a>
    	</div>
    </div>
    <div class="box10">
    	<h2>영업관리팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">영업실적관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">부서별 매출</a>
    	</div>
    </div>
    <div class="box11">
    	<h2>생산팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">자체 생산/제조</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">생산의뢰</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">작업지시서</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">생산실적관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">작업실적관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">불량분석</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">공정재고관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">발주관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">매입관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">재고관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">재고평가</a>
    	</div>
    </div>
    <div class="box12">
    	<h2>구매팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">발주관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">매입관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">재고관리</a>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">재고평가</a>
    	</div>
    </div>
    <div class="box13">
    	<h2>품질관리팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">품질검사</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">설비/장비 관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">클레임(기업)</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">CS(소비자)</a>
    	</div>
    </div>
    <div class="box14">
    	<h2>물류팀</h2>
    	<div>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">재고관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">입출고관리</a><br><br>
    		<a href="javascript:void(0)" onclick="toggleFetchContent()">폐기/물류감소</a>
    	</div>
    </div>
</div>


<script>
    function toggleFetchContent() {
        // 회사정보를 불러오는 fetch 코드를 작성하세요.
        fetch('컨트롤러에 들어갈 경로').then(function(response) {
            response.text().then(function(text) {
                // 회사정보를 받아와서 특정 요소에 넣으세요.
                document.querySelector('#company-info').innerHTML = text;
            });
        });
    }

</script>




</body>
</html>
