<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
				
<%@ include file="/WEB-INF/views/intranet/layout/header.jsp" %>


<div class="intranetAdmin-container">

	<div class="intranetAdmin">
	
		<h1>마이페이지</h1>
		<br>
		
		<form id="changePwForm" action="${pageContext.request.contextPath}/intranet/updatePw">
		<input type="hidden" value="${Intranetlogin }" name="employee1_no">
		<input type="hidden" value="${empNo }" name="employee2_no">
	
		<caption><h3>비밀번호 변경</h3></caption>
		<table class="intranetAdmin-myinfo">

			<tr>
				<td>아이디</td>
				<td id="intranet-empId">${map.employee1_id}</td>
			</tr>
			<tr>
				<td>현재 비밀번호</td>
				<td>
					<input type="text" name="employee1_pw" id="employee1_pw" placeholder="현재 비밀번호를 입력하세요" onblur="checkCurrPw(this.value)">
					<h6 id="result-pw" style="color:red;"></h6>
				</td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="text" id="new_employee1_pw" name="new_employee1_pw" placeholder="변경할 비밀번호를 입력하세요"></td>
			</tr>	
			<tr>
				<td>변경할 비밀번호(재입력)</td>
				<td><input type="text" id="re_new_employee1_pw" placeholder="변경할 비밀번호를 재입력하세요"></td>
			</tr>	

		</table>
		
		<input type="button" onclick="checkPW()" id="check-pw" value="비밀번호 변경" disabled="disabled"/>
	
		</form>
		
		<caption><h3>기본정보</h3></caption>
		<table class="intranetAdmin-myinfo">
	
			<tr>
				<td>이름</td>
				<td>${map.employee1_name}</td>
			</tr>
			<tr>
				<td>사원코드</td>
				<td>${map.employee1_code}</td>
			</tr>
			<tr>
				<td>소속</td>
				<td>${map.dept_name} ${map.team_name}</td>
			</tr>
			<tr>
				<td>직급</td>
				<td>${map.employee2_position}</td>
			</tr>
			<tr>
				<td>내선번호</td>
				<td>${map.employee2_extension}</td>
			</tr>
			<tr>
				<td>잔여연차</td>
				<td>${map.employee2_holiday}</td>
			</tr>

		</table>


		<caption><h3>개인정보</h3></caption>
		
		<table>			
			<tr>
				<td>주민등록번호</td>
				<td>${map.employee1_residentno}</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>${map.employee1_phone}</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>${map.employee1_postal}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${map.employee1_addr1}</td>
			</tr>
		</table>
		
		<p style="color: red" > * 정보 변경은 관리자에게 문의하세요. </p>

	</div>

</div>

<script type="text/javascript">

function checkPW() {
	var currentPw = document.getElementById("employee1_pw").value;
    var newPw = document.getElementById("new_employee1_pw").value;
    var reNewPw = document.getElementById("re_new_employee1_pw").value;

	if(employee1_pw.value == ""){
		alert("현재 비밀번호를 입력하세요.")
		employee1_pw.focus();
	}else if(new_employee1_pw.value == ""){
		alert("변경할 비밀번호를 입력하세요.");
		new_employee1_pw.focus();
	}else if(re_new_employee1_pw.value == ""){
		alert("변경할 비밀번호를 다시 입력하세요.");
		re_new_employee1_pw.focus();
	}else {
	    if (newPw === reNewPw) {
			document.getElementById("changePwForm").submit();
	    } else {
	        alert("비밀번호와 재입력 비밀번호가 일치하지 않습니다.");
	    }
	}
}

function checkCurrPw(v){
	let id = document.getElementById("intranet-empId").innerHTML;
	var url = '${pageContext.request.contextPath}/intranet/checkCurrPw';
	var param = 'employee1_id='+encodeURIComponent(id)+'&employee1_pw='+encodeURIComponent(v);
	
	sendRequest(url,param,currPwResult,"POST");
}

function currPwResult(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data == "변경할 비밀번호를 입력해주세요."){
			document.getElementById("result-pw").innerText = data;
			document.getElementById("result-pw").style.color = "blue";
			document.getElementById("check-pw").disabled = false;
		}else {
			document.getElementById("result-pw").innerText = data;
			document.getElementById("result-pw").style.color = "red";
			document.getElementById("check-pw").disabled = true;
		}
	}
}

</script>

</body>
</html>