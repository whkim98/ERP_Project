<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<div class="button-container">
    <div class="button-group" align="center">
    <h2>기획본부</h2>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent1', 'test/managementplanning')" class="button small">경영기획팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent2', 'test/strategicplanning')" class="button small">전략기획팀</a>
    </div>
    <div class="button-group" align="center">
    <h2>관리본부</h2>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent3', 'test/account')" class="button small">회계팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent4', 'test/finance')" class="button small">재무팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent5', 'test/greeting')" class="button small">인사팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent6', 'test/gunradish')" class="button small">총무팀</a>
    </div>
	<div class="button-group" align="center">
    <h2>영업본부</h2>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent7', 'test/internationalsales')" class="button small">해외영업팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent8', 'test/domesticsales')" class="button small">국내영업팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent9', 'test/storesales')" class="button small">매장영업팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent10', 'test/businessmanagement')" class="button small">영업관리팀</a>
    </div>
    <div class="button-group" align="center">
    <h2>지원본부</h2>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent11', 'test/production')" class="button small">생산팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent12', 'test/purchase')" class="button small">구매팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent13', 'test/quality')" class="button small">품질관리팀</a>
        <a href="javascript:void(0)" onclick="toggleFetchContent('fetchContent14', 'test/distribution')" class="button small">물류팀</a>
    </div>
</div>

<hr>


<article id="fetchContent1" name="f"></article>

<article id="fetchContent2" name="f"></article>

<article id="fetchContent3" name="f"></article>

<article id="fetchContent4" name="f"></article>

<article id="fetchContent5" name="f"></article>

<article id="fetchContent6" name="f"></article>

<article id="fetchContent7" name="f"></article>

<article id="fetchContent8" name="f"></article>

<article id="fetchContent9" name="f"></article>

<article id="fetchContent10" name="f"></article>

<article id="fetchContent11" name="f"></article>

<article id="fetchContent12" name="f"></article>

<article id="fetchContent13" name="f"></article>

<article id="fetchContent14" name="f"></article>	

	<!-- Scripts -->
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/util.js"></script>
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/main.js"></script>
			<script src="${pageContext.request.contextPath }/webdesign/assets/js/fetch.js"></script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>