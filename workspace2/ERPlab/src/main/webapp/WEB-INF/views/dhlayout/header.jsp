<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>

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
		<link href="/css/dhcss/dh.css" rel="stylesheet" type="text/css">
		<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
		<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css" />
		
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
			<div>

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
								<li><a href="">이메일</a></li>
								<li><a href="#">연차</a></li>	
								<c:if test="${login == 1 }">
									<li><a href="${pageContext.request.contextPath}/admin?comcode_code=${comcode_code}">관리자페이지</a></li>	
								</c:if>					
							</ul>
							<ul>
								<li><a href="${pageContext.request.contextPath}/stock?comcode_code=${comcode_code }">재고</a></li>
								<li><a href="${pageContext.request.contextPath}/management?comcode_code=${comcode_code }">물류</a></li>
								<li><a href="${pageContext.request.contextPath}/d/d3/d31/inputOrder?comcode_code=${comcode_code}">발주</a></li>
								<li><a href="#">부서별매출</a></li>
								<li><a href="${pageContext.request.contextPath}/a/a3/a31/inputProject?comcode_code=${comcode_code}">프로젝트</a></li>
								<li><a href="#">회사정보</a></li>
								<li><a href="${pageContext.request.contextPath}/b11main?comcode_code=${comcode_code}">재무제표</a></li>
							</ul>
							
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

								<c:if test="${login == 1 }">
									<li><a href="${pageContext.request.contextPath}/admin?comcode_code=${comcode_code}">관리자페이지</a></li>	
								</c:if>	
								
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
										<a href="${pageContext.request.contextPath }/account?comcode_code=${comcode_code}">
											<p>계좌현황 및 관리</p>
										</a>
										<a href="${pageContext.request.contextPath }/funds?comcode_code=${comcode_code}">
											<p>자금관리</p>
										</a>
										<a href="${pageContext.request.contextPath }/budget?comcode_code=${comcode_code}">
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
											<a href="${pageContext.request.contextPath }/greeting?comcode_code=${comcode_code }">
												<p>인사정보</p>
											</a>
											<a href="${pageContext.request.contextPath }/greeting/attendance?comcode_code=${comcode_code }">
												<p>근태관리</p>
											</a>
											<a href="javascript:void(0);" onclick="openWindow('${comcode_code}')">
											    <p>정산</p>
											</a>
											<a href="${pageContext.request.contextPath }/greeting/resignList?comcode_code=${comcode_code }">
												<p>퇴직</p>
											</a>
									</li>
									<li>
										<h3>총무팀</h3>
											<a href="${pageContext.request.contextPath}/tools?comcode_code=${comcode_code }">
												<p>기자재</p>
											</a>
											<a href="${pageContext.request.contextPath}/supplies?comcode_code=${comcode_code }">
												<p>비품 / 소모품</p>
											</a>
									</li>
									<li>
										<h3>해외영업팀</h3>
											<a href="${pageContext.request.contextPath}/internationalsales/list?comcode_code=${comcode_code }">
												<p>해외거래처관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/internationalsales/export?comcode_code=${comcode_code }">
												<p>수출관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/internationsales/import?comcode_code=${comcode_code }">
												<p>수입(매입)</p>
											</a>
											<a href="${pageContext.request.contextPath}/internationsales/income?comcode_code=${comcode_code }">
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
											<a href="${pageContext.request.contextPath}/stock?comcode_code=${comcode_code }">
												<p>재고관리</p>
											</a>
											<a href="${pageContext.request.contextPath}/management?comcode_code=${comcode_code }">
												<p>입출고관리</p>
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

