<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/home.css" />
   	<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css" />
   	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" />
   	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <title>ERP LAB</title>
</head>
<body>

<div class="section">
	<div class="container">
		
      <div class="row full-height justify-content-center">
        <div class="col-12 text-center align-self-center py-5">
          <div class="section pb-5 pt-5 pt-sm-2 text-center">
            <h6 class="mb-0 pb-3"><span>ERP</span><span>INTRANET</span></h6>
                  <input class="checkbox" type="checkbox" id="reg-log" name="reg-log"/>
                  <label for="reg-log"></label>
            <div class="card-3d-wrap mx-auto">
              <div class="card-3d-wrapper">
				  
                <div class="card-front">		
                  <div class="center-wrap">
                    <div class="section text-center">
                      <h4 class="mb-4 pb-3">ERP 로그인</h4>
                      
                      <form action="${pageContext.request.contextPath}/login/check" method="post" name="logincheck">

                      <div class="form-group">
                        <a onclick="searchcode()"><input type="text" name="comcode_code" class="form-style" placeholder="회사명" id="comcode_code" autocomplete="off" value="${comcode_code}"></a>
                        <i class="input-icon uil uil-building"></i>
                      </div>

                      <div class="form-group">
                        <input type="text" name="admin_id" class="form-style" placeholder="아이디" id="admin_id" autocomplete="off">
                        <i class="input-icon uil uil-user"></i>
                      </div>
                      
                      <div class="form-group mt-2">
                        <input type="password" name="admin_pw" class="form-style" placeholder="비밀번호" id="admin_pw" autocomplete="off">
                        <i class="input-icon uil uil-lock-alt"></i>
                      </div>
             			<a onclick="login(this.form)">
	           				<div class="erplog">
		             			LOGIN
	           				</div>
             			</a>
					  </form>
                    </div>
               	  </div>
                </div>

                <div class="card-back">
                  <div class="center-wrap">
                    <div class="section text-center">
                      <h4 class="mb-4 pb-3">인트라넷 로그인</h4>
                      
                     <form action="${pageContext.request.contextPath}/intranet/check" method="post" name="intranetlogincheck">

                      <div class="form-group">
                         <a onclick="searchcode1()"><input type="text" name="comcode_code" class="form-style" placeholder="회사명" id="comcode_code_intranet" autocomplete="off" value="${comcode_code}"></a>
	                     <i class="input-icon uil uil-building"></i>
                      </div>

                      <div class="form-group">
                        <input type="text" name="employee1_id" class="form-style" placeholder="아이디" id="employee1_id" autocomplete="off">
                        <i class="input-icon uil uil-user"></i>
                      </div>
                      
                      <div class="form-group mt-2">
                        <input type="password" name="employee1_pw" class="form-style" placeholder="비밀번호" id="employee1_pw" autocomplete="off">
                        <i class="input-icon uil uil-lock-alt"></i>
                      </div>
              			<a onclick="intranetLogin(this.form)">
              				<div class="erplog">LOGIN</div>
              			</a>
					  </form>
					 	    
                      </div>
                        
                    </div>
                      
                  </div>
                </div>
              </div>
            </div>
          </div>
	</div>
</div>
  
</body>
<script type="text/javascript">

	function login(f){
		var comcode_code = document.getElementById("comcode_code");
		var admin_id = document.getElementById("admin_id");
		var admin_pw = document.getElementById("admin_pw");
		
		if(comcode_code.value == ""){
			alert("회사 코드를 입력해주세요!")
			comcode_code.focus();
		}else if(admin_id.value == ""){
			alert("아이디를 입력해주세요!");
			admin_id.focus();
		}else if(admin_pw.value == ""){
			alert("비밀번호를 입력해주세요!");
			admin_pw.focus();
		}else {
			document.logincheck.submit();
		}
	}
	
	function intranetLogin(f){
		var comcode_code_intranet = document.getElementById("comcode_code_intranet");
		var employee1_id = document.getElementById("employee1_id");
		var employee1_pw = document.getElementById("employee1_pw");
		
		if(comcode_code_intranet.value == ""){
			alert("회사 코드를 입력해주세요!")
			comcode_code_intranet.focus();
		}else if(employee1_id.value == ""){
			alert("아이디를 입력해주세요!");
			employee1_id.focus();
		}else if(employee1_pw.value == ""){
			alert("비밀번호를 입력해주세요!");
			employee1_pw.focus();
		}else {
			document.intranetlogincheck.submit();
		}
	}
	
	function searchcode(){
		let openWin = window.open("${pageContext.request.contextPath}/login/searchcode", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	
	function searchcode1(){
		let openWin = window.open("${pageContext.request.contextPath}/intranet/searchcode", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
	}
	
</script>
</html>