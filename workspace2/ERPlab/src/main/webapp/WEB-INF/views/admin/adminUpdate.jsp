<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

function searcht(){
	let openWin = window.open("${pageContext.request.contextPath}/searcht", "_blank", "scrollbars=yes, top=150, left=300, width=300, height=300");
}

function team(e, name){
    if(e.keyCode == 13){
        if(name == ""){
            alert("팀명을 입력해주세요.");
            document.getElementById("team_name").focus();
            return;
        }
        var url = "${pageContext.request.contextPath}/a/a3/a31/team";
        var param = "team_name=" + encodeURIComponent(name);
        
        sendRequest(url, param, teamname, "POST");
    }
}


function teamname(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.response;
		if(data != ""){
			var data2 = JSON.parse(data);
			document.getElementById("dept_name").value = data2.dept_name;
			document.getElementById("team_name").value = data2.team_name;
			document.getElementById("team_no").value = data2.team_no;
		}else {
			alert("중복된 팀 이름입니다. 조회 버튼을 클릭하여 목록에서 팀을 선택해주세요.");
		}
	}
}

</script>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

	
<div class="adminInsert-container">

	<form action="${pageContext.request.contextPath}/admin" method="get">
    	<input type="hidden" name="comcode_code" value="${comcode_code}">
    </form>

	<div class="admin-menu">
		
		<h1>계정관리</h1>
		
		<input type="button" id="erpbtn" onclick="location.href='${pageContext.request.contextPath}/admin?comcode_code=${comcode_code}'" value="ERP계정 관리" />
		<input type="button" id="intranetbtn" onclick="location.href='${pageContext.request.contextPath}/intranet?comcode_code=${comcode_code}'" value="인트라넷계정 관리" />
		<p></p>
		
	</div>
	
	<form action="${pageContext.request.contextPath}/updateAdmin" method="POST" name="createAdmin">
		<input type="hidden" name="comcode_code" value="${comcode_code}">
		<input type="hidden" name="admin_no" id="admin_no" value="${selectAdmin.admin_no}">
		
		<h1>ERP 신규 계정 생성</h1>
		
		<table>
			<tr>
				<td>
					아이디
				</td>
				<td>
					<input type="text" name="admin_id" id="admin_id" value="${selectAdmin.admin_id }" onkeyup="changeId()">
					<h6 id="idcheck" style="color:red;"></h6>
				</td>
				<td>
					<input type="button" onclick="checkId()" value="중복확인">
				</td>
			</tr>
			
			<tr>
				<td>
					비밀번호
				</td>
				<td>
					<input type="text" name="admin_pw" id="admin_pw" value="${selectAdmin.admin_pw }">
				</td>
				<td>
				</td>
			</tr>
			
			<tr>
				<td>
					팀
				</td>
				<td>
					<input type="text" name="team_name" id="team_name" onkeypress="team(event, this.value)" value="${selectAdmin.team_name }">
				</td>
				<td>
					<input type="button" onclick="searcht()" value="조회">
					<input type="hidden" name="team_no" id="team_no" value="${selectAdmin.team_no }">					
				</td>
			</tr>
			
			<tr>
				<td>
					부서
				</td>
				<td>
					<input type="text" name="dept_name" id="dept_name" readonly="readonly" value="${selectAdmin.dept_name }">
				</td>
				<td>
				</td>
			</tr>
		
		</table>
		
		<div>
			<input type="button" value="수정" id="ifcheck" onclick="sub(this.form)">
		</div>
	</form>
	
</div>


<script type="text/javascript">


function sub(f){
	if(f.admin_id.value == ""){
		alert("아이디를 입력하세요");
		f.admin_id.focus();
	}else if(f.admin_pw.value == ""){
		alert("비밀번호를 입력하세요");
		f.admin_pw.focus();
	}else if(f.team_no.value == ""){
		alert("팀을 선택하세요");
		f.team_name.focus();
	}else{
		f.submit();
	}
}

function checkId(){
	let v = document.getElementById("admin_id").value;
	if(v == ""){
		alert("아이디를 입력해주세요.");
		return;
	}
	var url = '${pageContext.request.contextPath}/checkAdminId';
	var param = 'admin_id='+encodeURIComponent(v);
	
	sendRequest(url,param,checkIdResult,"POST");
}

function checkIdResult(){
	if(xhr.readyState==4 && xhr.status==200) {
		var data = xhr.responseText;
		if(data == "사용 가능한 ID 입니다."){
			document.getElementById("idcheck").innerText = data;
			document.getElementById("idcheck").style.color = "blue";
			document.getElementById("ifcheck").disabled = false;
		}else {
			document.getElementById("idcheck").innerText = data;
			document.getElementById("idcheck").style.color = "red";
			document.getElementById("ifcheck").disabled = true;
		}
	}
}

function changeId(){
	document.getElementById("idcheck").innerText = "";
	document.getElementById("idcheck").style.color = "";
	document.getElementById("ifcheck").disabled = true;
}


</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>