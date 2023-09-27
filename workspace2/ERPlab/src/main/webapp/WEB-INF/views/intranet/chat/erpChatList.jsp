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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/intranet/chat/chatList.css">
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
				<option value="chatroom_title" ${param.type == 'chatroom_title' ? 'selected' : '' }>채팅방명</option>
			</select>
			<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off" onkeyup="surf(this.value, '${empNo}')">
	       	<i class="input-icon uil-search"></i>
       	</div>
    </div>

    <div class="erpChat-empList-main">
        <table id="erpChat-chatList">
        	<c:forEach var="map" items="${list }">
        		<c:if test="${empNo == map.e1no }">
		            <tr>
		            	<c:if test="${map.chatroom_title == null }">
			                <th onclick="openChatroom(${map.chatroom_no },'${map.e2name }','${comcode_code }','${map.e2position }')">${map.team_name2} ${map.e2position } ${map.e2name }</th>
			            </c:if>
			            <c:if test="${map.chatroom_title != null }">
		                	<th onclick="openChatroom(${map.chatroom_no },'${map.e2name }','${comcode_code }','${map.e2position }')">${map.chatroom_title }</th>
			            </c:if>
			            <th onclick="deleteRoom(${map.chatroom_no})">x</th>
		            </tr>
	           	</c:if>
        		<c:if test="${empNo == map.e2no }">
		            <tr>
		            	<c:if test="${map.chatroom_title == null }">
			                <th onclick="openChatroom(${map.chatroom_no },'${map.e2name }','${comcode_code }','${map.e1position }')">${map.team_name1} ${map.e1position } ${map.e1name }</th>
			            </c:if>
			            <c:if test="${map.chatroom_title != null }">
		                	<th onclick="openChatroom(${map.chatroom_no },'${map.e2name }','${comcode_code }','${map.e1position }')">${map.chatroom_title }</th>
			            </c:if>
			            <th onclick="deleteRoom(${map.chatroom_no})">x</th>
		            </tr>
	           	</c:if>
            </c:forEach>
        </table>
    </div>
    
</div>

<script type="text/javascript">
let code = document.getElementById("comcode_code").value;

function chatRoomList(no, code){
	location.href="${pageContext.request.contextPath}/intranet/chat/erpchatlist?employee2_no="+no+"&comcode_code="+code;
}

function openChatroom(no, name, code, position) {
    window.open('${pageContext.request.contextPath}/intranet/chat/erpchatroom?comcode_code='+code+'&employee1_name='+name+'&chatroom_no='+no+"&employee2_position="+position, 'Chatroom', 'width=380, height=480');
}

function surf(v, no){
	var type = document.getElementsByName("type")[0].value;
	if(v == ''){
		type = null;
		v = null;
	}
	var url = "${pageContext.request.contextPath}/intranet/chat/erpchatlistAjax";
	var param = "employee2_no="+no+"&word="+v+"&type="+type;
	
	sendRequest(url,param,getlist,"POST");
}
function getlist(){
	if(xhr.readyState==4 && xhr.status==200) {	
		var data = xhr.response;
		let procode = document.getElementById("erpChat-chatList");
		let code = document.getElementById("comcode_code").value;
		let eno = document.getElementById("employee2_no").value;
		let newTr = document.createElement("tr");
		let newTd = document.createElement("th");
		procode.innerHTML = '';
		if(data != ""){
			var data2 = JSON.parse(data);
			data2.forEach(function(map){
				if(eno == map.e1no){
					newTr = document.createElement("tr");
					procode.appendChild(newTr);
					if(map.chatroom_title == null){
						newTd = document.createElement("th");
						newTd.setAttribute("onclick", "openChatroom("+map.chatroom_no+",'"+map.e2name+"','"+code+"','"+map.e2position+"')");
						newTd.innerHTML = map.team_name2 + " " + map.e2position + " " + map.e2name;
						newTr.appendChild(newTd);
					}else if(map.chatroom_title != null){
						newTd = document.createElement("th");
						newTd.setAttribute("onclick", "openChatroom("+map.chatroom_no+",'"+map.e2name+"','"+code+"','"+map.e2position+"')");
						newTd.innerHTML = map.chatroom_title;
						newTr.appendChild(newTd);
					}
				}else if(eno == map.e2no){
					newTr = document.createElement("tr");
					procode.appendChild(newTr);
					if(map.chatroom_title == null){
						newTd = document.createElement("th");
						newTd.setAttribute("onclick", "openChatroom("+map.chatroom_no+",'"+map.e1name+"','"+code+"','"+map.e1position+"')");
						newTd.innerHTML = map.team_name1 + " " + map.e1position + " " + map.e1name;
						newTr.appendChild(newTd);
					}else if(map.chatroom_title != null){
						newTd = document.createElement("th");
						newTd.setAttribute("onclick", "openChatroom("+map.chatroom_no+",'"+map.e1name+"','"+code+"','"+map.e1position+"')");
						newTd.innerHTML = map.chatroom_title;
						newTr.appendChild(newTd);
					}
				}
				newTd = document.createElement("th");
				newTd.setAttribute("onclick", "deleteRoom("+map.chatroom_no+")");
				newTd.innerHTML = "x";
				newTr.appendChild(newTd);
			});
		}else {
			procode.appendChild(newTr);
			newTd.innerHTML += '조회된 목록이 없습니다.';
			newTr.appendChild(newTd);
		}
	}
}

function deleteRoom(no){
	var ch = confirm("대화 내용도 전부 삭제됩니다. 채팅방을 나가시겠습니까?");
	if(ch){
		location.href='${pageContext.request.contextPath}/intranet/chat/deleteChatRoom?chatroom_no='+no+'&comcode_code='+code;
	}else {
		return;
	}
}



</script>

</body>
</html>