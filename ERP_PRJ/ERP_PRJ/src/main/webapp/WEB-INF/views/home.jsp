<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
    .box {
        position: relative; 
        background-color: #5c54d1;
        width: 1000px;
        height: 300px;
        opacity: 0.5;
        margin: 0 auto;
        margin-top: 50px;
        border-radius: 20px;
    }
    .box img {
        position: absolute; 
        width: 80px;
        height: 80px; 
    }
    .image-link {
        display: block;
        position: relative; 
    }
    
    .divider {
        position: absolute; 
        width: 100%; 
        height: 2px; 
        background-color: #ffffff; 
        top: 50%; 
        transform: translateY(-50%); 
    }
    
  
    .image-link:nth-child(1) {
        top: calc(50% - 40px); 
        left: 0; 
    }
    
    .image-link:nth-child(2) {
        top: calc(50% - 40px); 
        left: 100px; 
    }
    
    .image-link:nth-child(3) {
        top: calc(50% - 40px);
        left: 200px;
    }
    
    .image-link:nth-child(4) {
        top: calc(50% - 40px); 
        left: 300px; 
    }
    
    .image-link:nth-child(5) {
        top: calc(50% - 40px); 
        right: 300px;
    }
    
    .image-link:nth-child(6) {
        top: calc(50% - 40px);
        right: 200px; 
    }
    
    .image-link:nth-child(7) {
        top: calc(50% + 20px); 
        left: 0; 
    }
    
    .image-link:nth-child(8) {
        top: calc(50% + 20px); 
        left: 100px; 
    }
    
    .image-link:nth-child(9) {
        top: calc(50% + 20px);
        left: 200px;
    }
    
    .image-link:nth-child(10) {
        top: calc(50% + 20px);
        left: 300px; 
    }
    
    .image-link:nth-child(11) {
        top: calc(50% + 20px);
        right: 300px;
    }
    
    .image-link:nth-child(12) {
        top: calc(50% + 20px);
        right: 200px;
    }
    
    .image-link:nth-child(13) {
        top: calc(50% + 20px);
        right: 100px;
    }
    

    .sidebar {
    position: fixed;
    top: 20px;
    left: 20px;
    transform: translateY(0%);
    width: 40px;
    max-height: 50px;
    background-color: #f2f2f2;
    border-radius: 5px;
    transition: all 0.3s ease;
    opacity: 0.7;
    z-index: 999;
}
    .sidebar:hover {
        opacity: 1;
    }
    .sidebar-icon {
    position: fixed;
    top: 20px;
    left: 20px;
    transform: translateY(0%);
    width: 30px;
    height: 50px;
    background-color: white;
    border-radius: 5px;
    transition: all 0.3s ease;
    opacity: 0.7;
    z-index: 999;
}

    .sidebar-icon img {
    	position: fixed;
        width: 40px;
        height: 50px;
    }
</style>
<script>
    /* window.addEventListener('DOMContentLoaded', (event) => {
        const sidebar = document.querySelector('.sidebar');
        const box = document.querySelector('.box');
        
        window.addEventListener('scroll', function () {
            if (window.scrollY > box.offsetTop) {
                sidebar.style.top = '50px';
            } else {
                sidebar.style.top = '50%';
            }
        });
    }); */ 
    /* 사이드바 위치 이동 */
</script>
</head>
<body>
<header>			
    <div class="box">
        <div class="divider"></div>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('home/rjfo').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 0; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/거래처2.png" alt="이미지1" >
        </a>
        
       <a class="image-link" href="javascript:void(0)" onclick="fetch('home/aptlswj').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 120px; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/메신저2.png" alt="이미지2">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 240px; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/물류2.png" alt="이미지3">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 360px; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/발주2.png" alt="이미지4">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 480px; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/부서별 매출2.png" alt="이미지5">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 600px; top: 30px;">
            <img src="${pageContext.request.contextPath }/resources/materials/이메일2.png" alt="이미지6">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 0px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/일정2.png" alt="이미지7">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 120px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/잔여연차2.png" alt="이미지8">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 240px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/재고2.png" alt="이미지9">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 360px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/재무제표2.png" alt="이미지10">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 480px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/조직도2.png" alt="이미지11">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 600px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/주소록2.png" alt="이미지12">
        </a>
        
        <a class="image-link" href="javascript:void(0)" onclick="fetch('test/sidebar').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})" style="left: 720px; top: 180px;">
            <img src="${pageContext.request.contextPath }/resources/materials/프로젝트2.png" alt="이미지13">
        </a>
        
    </div>
</header>
    <div class="sidebar">
        <div class="sidebar-icon">
            <img src="${pageContext.request.contextPath }/resources/materials/sidebar/사이드바.png" alt="사이드바 아이콘" onclick="fetch('test/sidebar').then(function(response){
                    response.text().then(function(text){
                        document.querySelector('article').innerHTML = text;
                    })
                    })">
        </div>
    </div>

    <br>
    <div align="center">
    	<input type="button" value="경영기획팀" onclick="fetch('test/ruddud').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="전략기획팀" onclick="fetch('test/wjsfir').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="회계팀" onclick="fetch('test/ghlrP').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="재무팀" onclick="fetch('test/woan').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="인사팀" onclick="fetch('test/dlstk').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="총무팀" onclick="fetch('test/chdan').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="해외영업팀" onclick="fetch('test/godhl').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="국내영업팀" onclick="fetch('test/rnrso').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="매장영업팀" onclick="fetch('test/aowkd').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="영업관리팀" onclick="fetch('test/duddjq').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="생산팀" onclick="fetch('test/todtks').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="구매팀" onclick="fetch('test/rnao').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="품질관리팀" onclick="fetch('test/vnawlf').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    	<input type="button" value="물류팀" onclick="fetch('test/anffb').then(function(response){
					response.text().then(function(text){
						document.querySelector('article').innerHTML = text;
					})
					})">
    </div>
    
    <article>
    
    </article>
    
    <div align="center">
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    	<br>
    	<h2>dsa</h2>
    </div>
</body>
</html>

