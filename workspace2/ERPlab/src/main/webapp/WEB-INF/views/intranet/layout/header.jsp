<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE HTML>

<html>
	<head>
		<title>ERPLAB</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/webdesign/assets/css/main.css" />
		<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css" />
		<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
		
		<!-- 로그인 세션 -->
		<c:if test="${Intralogin == null }">
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
						<h1><a href="/intranet/intranetMain">ERPlab</a></h1>
						<nav class="links">
						
						<!-- 인트라넷 헤더 -->
							<ul>
								<li><a href="#">조직도</a></li>
								<li><a href="#">일정</a></li>
								<li><a href="#">주소록</a></li>
								<li><a href="javascript:void(0);" onclick="msgWindow()">메신저</a></li>
								<li><a href="#">이메일</a></li>
								<li><a href="#">연차</a></li>								
							</ul>
							<ul>
								<li><a href="${pageContext.request.contextPath}/">ERP 페이지로 이동</a></li>
								<li><a href="${pageContext.request.contextPath}intranet/inputPw?comcode_code=${comcode_code}&employee2_no=${empNo}">마이페이지</a></li>
							</ul>
							
						</nav>

						<nav class="intranetLogout">
							<ul class="actions stacked">
								<li></li>
								<li><input type="button" onclick="logout()" value="LOGOUT" /></li>
							</ul>				
						</nav>
					</header>


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

// 메신저
function msgWindow() {
    var url = "${pageContext.request.contextPath}/intranet/chat/erpchat?comcode_code=${comcode_code}&employee2_no=${empNo}";
    var windowFeatures = 'width=380,height=480';

    window.open(url, '_blank', windowFeatures);
}


</script>

<div>


