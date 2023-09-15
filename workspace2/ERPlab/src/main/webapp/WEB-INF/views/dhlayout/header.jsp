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
		<link href="/css/dhcss/dh.css" rel="stylesheet" type="text/css">
		<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
		
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
								<li><a href="#">주소록</a></li>
								<li><a href="#">메신저</a></li>
								<li><a href="#">조직도</a></li>
								<li><a href="#">이메일</a></li>
								<li><a href="#">일정</a></li>
								<li><a href="#">연차</a></li>
								
							</ul>
							<ul>
								<li><a href="#">재고</a></li>
								<li><a href="#">물류</a></li>
								<li><a href="#">재무제표</a></li>
								<li><a href="#">발주</a></li>
								<li><a href="#">프로젝트</a></li>
								<li><a href="#">거래처</a></li>
								<li><a href="#">부서별 매출</a></li>
							</ul>
							
							
						</nav>
						
						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>
					
				<!-- Menu -->
					<section id="menu">

						<!-- Search -->
							<section>
								<form class="search" method="get" action="#">
									<input type="text" name="query" placeholder="Search" />
								</form>
							</section>

						<!-- Links -->
							<section>
								<ul class="links">
									<li>
											<h3>경영기획팀</h3>
										<a href="#">
											<p>회사정보</p>
										</a>
										<a href="#">
											<p>사업자정</p>
										</a>
										<a href="#">
											<p>지점관리</p>
										</a>
									</li>
									<li>
											<h3>전략기획팀</h3>
										<a href="#">
											<p>프로젝트</p>
										</a>
										<a href="#">
											<p>계약관리</p>
										</a>
										<a href="#">
											<p>실적 / 평가</p>
										</a>
									</li>
									<li>
											<h3>회계팀</h3>
										<a href="#">
											<p>재무상태표</p>
										</a>
										<a href="#">
											<p>손익계산서</p>
										</a>
										<a href="#">
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
										<a href="#">
											<p>전표입력</p>
										</a>
										<a href="#">
											<p>외화관리</p>
										</a>
										<a href="#">
											<p>전자세금계산서</p>
										</a>
										<a href="#">
											<p>마감 / 결산</p>
										</a>
										<a href="#">
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
												<p>국가별분류</p>
											</a>
											<a href="#">
												<p>해외거래처관리</p>
											</a>
											<a href="#">
												<p>수출관리</p>
											</a>
											<a href="#">
												<p>수출채권</p>
											</a>
											<a href="#">
												<p>수입 / 매입</p>
											</a>
											<a href="#">
												<p>수입발주관리</p>
											</a>
											<a href="#">
												<p>수입채무관리</p>
											</a>
									</li>
									<li>
										<h3>국내영업팀</h3>
											<a href="#">
												<p>국내거래처관리</p>
											</a>
											<a href="#">
												<p>채권관리</p>
											</a>
											<a href="#">
												<p>반품관리</p>
											</a>
											<a href="#">
												<p>영업전표</p>
											</a>
											<a href="#">
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
											<a href="#">
												<p>생산 / 제조</p>
											</a>
											<a href="#">
												<p>생산의뢰</p>
											</a>
											<a href="#">
												<p>작업지시서</p>
											</a>
											<a href="#">
												<p>생산실적관리</p>
											</a>
											<a href="#">
												<p>작업실적관리</p>
											</a>
											<a href="#">
												<p>불량분석</p>
											</a>
											<a href="#">
												<p>공정재고관리</p>
											</a>
											<a href="#">
												<p>발주관리</p>
											</a>
											<a href="#">
												<p>매입관리</p>
											</a>
											<a href="#">
												<p>재고관리</p>
											</a>
											<a href="#">
												<p>재고평가</p>
											</a>
									</li>
									<li>
										<h3>구매팀</h3>
											<a href="#">
												<p>발주관리</p>
											</a>
											<a href="#">
												<p>매입관리</p>
											</a>
											<a href="#">
												<p>재고관리</p>
											</a>
											<a href="#">
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
									<li><a href="#" class="button large fit">LogOut</a></li>
								</ul>
							</section>

					</section>

</div>

<div>

