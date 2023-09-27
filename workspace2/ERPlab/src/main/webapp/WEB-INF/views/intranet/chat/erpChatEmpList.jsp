<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/intranet/chat/empList.css">
</head>
<body>

<div class="erpChat-empList-container">
    <div class="erpChat-empList-head">
        <input type="button" onclick="location.href='/intranet/chat/erpchat?employee2_no=${empNo}&comcode_code=${comcode_code }'" id="empList-empListBtn" value="직원목록">
        <input type="button" onclick="chatRoomList(${empNo},'${comcode_code }')" id="empList-chatListBtn" value="채팅목록">
    </div>
    
    <input type="hidden" name="comcode_code" id="comcode_code" value="${comcode_code }">
	<input type="hidden" name="employee2_no" id="employee2_no" value="${empNo }">

    <div class="erpChat-empList-title">
    	<div class="erpChat-empList-searchBar">
	    	<select name="type">
				<option value="all" ${param.type == 'all' ? 'selected' : '' }>전체</option>
				<option value="employee1_name" ${param.type == 'employee1_name' ? 'selected' : '' }>이름</option>
				<option value="employee2_position" ${param.type == 'employee2_position' ? 'selected' : '' }>직급</option>
				<option value="team_name" ${param.type == 'team_name' ? 'selected' : '' }>팀</option>
				<option value="dept_name" ${param.type == 'dept_name' ? 'selected' : '' }>부서</option>
			</select>
	        <input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${empNo}')">
	       	<i class="input-icon uil-search"></i>
    	</div>
    </div>

    <div class="erpChat-empList-main">
        <table id="erpChat-friendList">
        	<c:forEach var="map" items="${list }">
            <tr>
                <th class="erpChat-friendList-team">${map.team_name}</th>
                <th class="erpChat-friendList-name">${map.employee1_name }</th>
                <th class="erpChat-friendList-position">${map.employee2_position }</th>
                <th class="">    </th>
                <th class="erpChat-friendList-chatStart"><a onclick="openChatroom(${empNo},${map.employee2_no },'${map.employee1_name }','${comcode_code }','${map.employee2_position }')"><i class="input-icon uil-comments"></i></a>
            </tr>
            </c:forEach>
        </table>
    </div>
    
</div>

<script type="text/javascript">


let code = document.getElementById("comcode_code").value;
function openChatroom(no1, no2, name, code, position) {
    window.open('${pageContext.request.contextPath}/intranet/chat/createChatRoom?comcode_code='+code+'&employee1_name='+name+'&employee2_no1='+no1+'&employee2_no2='+no2+"&employee2_position="+position, 'Chatroom', 'width=380, height=480');
}

function chatRoomList(no, code){
	location.href="${pageContext.request.contextPath}/intranet/chat/erpchatlist?employee2_no="+no+"&comcode_code="+code;
}

function surf(v, no){
	console.log(v);
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/intranet/chat/erpchatAjax";
	var param = "employee2_no="+no+"&word="+v+"&type="+type+"&comcode_code="+code;
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("erpChat-friendList");
		let newTr = document.createElement("tr");
		let newTd = document.createElement("th");
		let eno = document.getElementById("employee2_no").value;
		procode.innerHTML = '';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				newTr = document.createElement("tr");
				procode.appendChild(newTr);
				newTd = document.createElement("th");
				newTd.setAttribute("class", "erpChat-friendList-team");
				newTd.innerHTML = map.team_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("th");
				newTd.setAttribute("class", "erpChat-friendList-name");
				newTd.innerHTML = map.employee1_name;
				newTr.appendChild(newTd);
				newTd = document.createElement("th");
				newTd.setAttribute("class", "erpChat-friendList-position");
				newTd.innerHTML = map.employee2_position;
				newTr.appendChild(newTd);
				newTd = document.createElement("th");
				newTd.innerHTML = "    ";
				newTr.appendChild(newTd);
				newTd = document.createElement("th");
				newTd.setAttribute("class", "erpChat-friendList-chatStart");
				newTd.innerHTML = '<a onclick="openChatroom(${empNo},'+map.employee2_no+',`'+map.employee1_name+'`,`${comcode_code }`,`'+map.employee2_position+'`)"><i class="input-icon uil-comments"></i>';
				newTr.appendChild(newTd);
			});
		}else {
			procode.innerHTML += '조회된 목록이 없습니다.';
		}
	}
}



</script>

</body>
</html>