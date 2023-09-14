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
							</ul>
							<ul>
								<li><a href="#">재고</a></li>
								<li><a href="#">물류</a></li>
								<li><a href="#">발주</a></li>
								<li><a href="#">부서별매출</a></li>
								<li><a href="#">프로젝트</a></li>
								<li><a href="#">회사정보</a></li>
								<li><a href="${pageContext.request.contextPath}/b11main?comcode_code=${comcode_code}">재무제표</a></li>
							</ul>
							
						</nav>
						
						<nav class="loginSessionOutput">
						    <div class="loginSessionView">
				        		Remaining Session Time: <span id="sessionTime">Calculating...</span>					        				        
						    </div>
						</nav>
						
						
						<nav class="main">
							<ul>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
						
						<nav class="intranetLogout">
							<ul class="actions stacked">
								<li><input type="button" onclick="#" value="HOME" /></li>
							</ul>				
						</nav>

						<nav class="intranetLogout">
							<ul class="actions stacked">
								<li><input type="button" onclick="logout()" value="LOGOUT" /></li>
							</ul>				
						</nav>
					</header>


</div>

<script type="text/javascript">

//로그아웃까지 남은 시간을 가져오는 함수
function updateSessionTime() {
    const sessionStartTime = new Date(${pageContext.session.creationTime});
    const sessionTimeout = ${pageContext.session.maxInactiveInterval} * 1000;
    const currentTime = new Date();

    // 세션의 남은 시간 계산
    const remainingTime = new Date(sessionStartTime.getTime() + sessionTimeout - currentTime.getTime());

    const minutes = remainingTime.getMinutes();
    const seconds = remainingTime.getSeconds();
    let min = minutes < 10 ? '0' : '';
    let sec = seconds < 10 ? '0' : '';
    const formattedTime = min+minutes+'분'+sec+seconds+'초';
    
    document.getElementById('sessionTime').textContent = formattedTime; 
}

updateSessionTime();
setInterval(updateSessionTime, 1000);


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

