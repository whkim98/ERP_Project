<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE HTML>
<!--
	Future Imperfect by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<html>
	<head>
		<title>ERPLAB</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/webdesign/assets/css/main.css" />
		<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css" />
		
		<!-- 로그인 세션 -->
		<c:if test="${login == null }">
			<script type="text/javascript">
				alert("세션이 만료되었습니다.");
				location.href="${pageContext.request.contextPath }/";
			</script>
		</c:if>
		<c:if test="${comcode_code == null }"> 
			<script type="text/javascript">
				alert("세션이 만료되었습니다.");
				location.href="${pageContext.request.contextPath }/";
			</script>
		</c:if>
		
		
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="/index">ERPlab</a></h1>
						<nav class="links">
						<!-- 인트라넷 애들은 로그인을 따로 할 수 있도록 나중에 수정 -->
							<ul>
								<li><a href="#">조직도</a></li>
								<li><a href="#">일정</a></li>
								<li><a href="#">주소록</a></li>
								<li><a href="${pageContext.request.contextPath}/erpchat?comcode_code=${comcode_code}" target="_blank">메신저</a></li>
								<li><a href="#">이메일</a></li>
								<li><a href="#">연차</a></li>	
								<c:if test="${login == 1 }">
									<li><a href="#">관리자</a></li>	
								</c:if>					
							</ul>
							<ul>
								<li><a href="#">재고</a></li>
								<li><a href="#">물류</a></li>
								<li><a href="${pageContext.request.contextPath}/d/d3/d31/inputOrder?comcode_code=${comcode_code}">발주</a></li>
								<li><a href="#">부서별매출</a></li>
								<li><a href="${pageContext.request.contextPath}/a/a3/a31/inputProject?comcode_code=${comcode_code}">프로젝트</a></li>
								<li><a href="#">회사정보</a></li>
								<li><a href="${pageContext.request.contextPath}/b11main?comcode_code=${comcode_code}">재무제표</a></li>
							</ul>
							
						</nav>
						
						<nav class="loginSessionOutput">
						    <div class="loginSessionView">
				        		로그아웃까지 남은 시간: <span id="sessionTime">Calculating...</span>					        				        
						    </div>
						</nav>
						
						
						<nav class="main">
							<ul>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Menu -->
					<section id="menu">

						<!-- Links -->
							<section>
								<ul class="links">
									<li>
											<h3>경영기획팀</h3>
										<a href="#">
											<p>회사정보</p>
										</a>
										<a href="#">
											<p>사업자정보</p>
										</a>
										<a href="#">
											<p>지점관리</p>
										</a>
									</li>
									<li>
											<h3>전략기획팀</h3>
										<a href="${pageContext.request.contextPath}/a/a3/a31/inputProject?comcode_code=${comcode_code}">
											<p>프로젝트</p>
										</a>
										<a href="${pageContext.request.contextPath}/a/a3/a32/inputContract?comcode_code=${comcode_code}&project_no=0">
											<p>계약관리</p>
										</a>
										<a href="${pageContext.request.contextPath}/a/a3/a33/?comcode_code=${comcode_code}&project_no=0">
											<p>실적 / 평가</p>
										</a>
									</li>
									<li>
											<h3>회계팀</h3>
										<a href="${pageContext.request.contextPath}/b11main?comcode_code=${comcode_code}">
											<p>재무상태표</p>
										</a>
										<a href="${pageContext.request.contextPath}/b12main?comcode_code=${comcode_code}">
											<p>손익계산서</p>
										</a>
										<a href="${pageContext.request.contextPath}/b13main?comcode_code=${comcode_code}">
											<p>현금흐름표</p>
										</a>
									</li>
									<li>
											<h3>재무팀</h3>
										<a href="#">
											<p>계좌현황 및 관리</p>
										</a>
										<a href="#">
											<p>자금관리</p>
										</a>
										<a href="#">
											<p>예산관리</p>
										</a>
										<a href="${pageContext.request.contextPath }/b31main?comcode_code=${comcode_code}">
											<p>전표입력</p>
										</a>
										<a href="${pageContext.request.contextPath }/b32main?comcode_code=${comcode_code}">
											<p>전자세금계산서</p>
										</a>
										<a href="${pageContext.request.contextPath }/b33main">
											<p>외화관리</p>
										</a>
										<a href="${pageContext.request.contextPath }/b/b4/b41?comcode_code=${comcode_code }">
											<p>마감 / 결산</p>
										</a>
										<a href="${pageContext.request.contextPath}/d/d1/d18/inputBom?comcode_code=${comcode_code}">
											<p>원가분석</p>
										</a>
									</li>
									<li>
										<h3>인사팀</h3>
											<a href="#">
												<p>인사정보</p>
											</a>
											<a href="#">
												<p>조직관리</p>
											</a>
											<a href="#">
												<p>근태관리</p>
											</a>
											<a href="#">
												<p>정산</p>
											</a>
											<a href="#">
												<p>퇴직</p>
											</a>
									</li>
									<li>
										<h3>총무팀</h3>
											<a href="#">
												<p>기자재</p>
											</a>
											<a href="#">
												<p>비품 / 소모품</p>
											</a>
									</li>
									<li>
										<h3>해외영업팀</h3>
											<a href="#">
												<p>해외거래처관리</p>
											</a>
											<a href="#">
												<p>수출관리</p>
											</a>
											<a href="#">
												<p>수입(매입)</p>
											</a>
											<a href="#">
												<p>수입발주관리</p>
											</a>
									</li>
									<li>
										<h3>국내영업팀</h3>
											<a href="${pageContext.request.contextPath }/c/c2/c21?comcode_code=${comcode_code }">
												<p>국내거래처관리</p>
											</a>
											<a href="${pageContext.request.contextPath }/c/c2/c22?comcode_code=${comcode_code }">
												<p>채권관리</p>
											</a>
											<a href="${pageContext.request.contextPath }/c/c2/c23/inputReturn?comcode_code=${comcode_code }">
												<p>반품관리</p>
											</a>
											<a href="${pageContext.request.contextPath }/c/c2/c25/inputLocalSales?comcode_code=${comcode_code }">
												<p>매출현황</p>
											</a>
									</li>
									<li>
										<h3>매장영업팀</h3>
											<a href="#">
												<p>매장관리</p>
											</a>
											<a href="#">
												<p>발주관리</p>
											</a>
											<a href="#">
												<p>고객관리</p>
											</a>
											<a href="#">
												<p>창고관리</p>
											</a>
											<a href="#">
												<p>행사관리</p>
											</a>
											<a href="#">
												<p>온라인</p>
											</a>
									</li>
									<li>
										<h3>영업관리팀</h3>
											<a href="#">
												<p>영업실적관리</p>
											</a>
											<a href="#">
												<p>부서별매출</p>
											</a>
									</li>
									<li>
										<h3>생산팀</h3>
											<a href="${pageContext.request.contextPath}/d/d1/d11/inputProduct?comcode_code=${comcode_code}">
												<p>생산 / 제조</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d1/d12/inputRequestProduct?comcode_code=${comcode_code}">
												<p>생산의뢰</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d1/d14/inputEvaluation?comcode_code=${comcode_code}">
												<p>생산실적관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d1/d15/inputEvaluemng?comcode_code=${comcode_code}">
												<p>작업실적관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d1/d17/inputProinventory?comcode_code=${comcode_code}">
												<p>공정재고관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d2/d21/inputOrder?comcode_code=${comcode_code}">
												<p>발주관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d2/d22/inputPurchase?comcode_code=${comcode_code}">
												<p>매입관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d2/d23/inputInventory?comcode_code=${comcode_code}">
												<p>재고관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d2/d24/inputProductTest?comcode_code=${comcode_code}">
												<p>재고평가</p>
											</a>
									</li>
									<li>
										<h3>구매팀</h3>
											<a href="${pageContext.request.contextPath}/d/d3/d31/inputOrder?comcode_code=${comcode_code}">
												<p>발주관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d3/d32/inputPurchase?comcode_code=${comcode_code}">
												<p>매입관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d3/d33/inputInventory?comcode_code=${comcode_code}">
												<p>재고관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/d/d3/d34/inputProductTest?comcode_code=${comcode_code}">
												<p>재고평가</p>
											</a>
									</li>
									<li>
										<h3>품질관리팀</h3>
											<a href="#">
												<p>품질검사</p>
											</a>
											<a href="#">
												<p>설비 / 장비 관리</p>
											</a>
											<a href="#">
												<p>클레임(기업)</p>
											</a>
											<a href="#">
												<p>CS(소비자)</p>
											</a>
									</li>
									<li>
										<h3>물류팀</h3>
											<a href="#">
												<p>재고관리</p>
											</a>
											<a href="#">
												<p>입출고관리</p>
											</a>
											<a href="#">
												<p>폐기 / 물류 감소</p>
											</a>
									</li>
								</ul>
							</section>

						<!-- Actions -->
							<section>
								<ul class="actions stacked">
									<li><input type="button" onclick="logout()" value="LOGOUT" /></li>
								</ul>
							</section>

					</section>
 
</div>

<script type="text/javascript">

let sessionTimeout; // 세션 타임아웃을 저장하는 변수
const maxSessionDuration = ${pageContext.session.maxInactiveInterval} * 1000; // 세션 최대 지속 시간 (밀리초)
let sessionStartTime = new Date(${pageContext.session.creationTime}); // 세션 시작 시간 초기화

// 세션 타임아웃 타이머 시작
function startSessionTimeout() {
    sessionStartTime = new Date(); // 새로운 세션 시작 시간 설정
    clearTimeout(sessionTimeout); // 이전 인터벌 제거

    // 새로운 세션 타임아웃 인터벌 설정
    sessionTimeout = setTimeout(logout, maxSessionDuration);
}

// 클릭, 입력, 마우스 움직임, 새로고침 등 모든 이벤트에 대한 세션 초기화 리스너 추가
document.addEventListener('click', startSessionTimeout);
document.addEventListener('input', startSessionTimeout);
document.addEventListener('mousemove', startSessionTimeout);
window.addEventListener('beforeunload', startSessionTimeout); // 새로고침 및 탭 닫힘 이벤트

// 남은 세션 시간을 업데이트하고 세션 타임아웃 타이머를 재설정하는 함수
function updateSessionTime() {
    const currentTime = new Date();
    const elapsedTime = currentTime - sessionStartTime;
    const remainingTime = maxSessionDuration - elapsedTime;

    if (remainingTime <= 0) {
        // 세션 타임아웃이 0 이하이면 로그아웃
        logout();
    } else {
        const minutes = Math.floor(remainingTime / 60000); // 밀리초를 분으로 변환
        const seconds = Math.floor((remainingTime % 60000) / 1000); // 밀리초를 초로 변환
        let min = minutes < 10 ? '0' : '';
        let sec = seconds < 10 ? '0' : '';
        const formattedTime = min + minutes + '분' + sec + seconds + '초';

        document.getElementById('sessionTime').textContent = formattedTime;
    }

    // 다음 프레임에서 업데이트 요청
    requestAnimationFrame(updateSessionTime);
}

// 초기 업데이트 호출
updateSessionTime();


// logout
function logout() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "${pageContext.request.contextPath}/logout", true);
    
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            alert("로그아웃되었습니다.");
            location.href = "${pageContext.request.contextPath}/";
        }
    };
    xhr.send();
}


</script>

<div>

