<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" tabindex="-1">
<title>ERP LAB CHAT</title>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/httpRequest.js"></script>
<style>
    body, html {
        width: 100%; height: 100%;
        min-width: 380px;
        min-height: 480px;
        padding: 0%; margin: 0%;
        display: flex;
        flex-direction: column;
    }

    #erpChatroom-container {
        display: flex;
        width: 100%; height: 100%;
        flex-direction: column;
        padding: 0%; margin: 0%;
    }

    #erpChatroomHead {
        background-color: greenyellow;
        padding: 0; margin: 0;
    }
    
    #erpChatroomMain {
        background-color: rgb(208, 255, 113);
        padding: 0; margin: 0;
        flex-grow: 1;
        overflow: auto;
    }
    
    #erpChatroomBottom {
        background-color: white;
        padding: 0; margin: 0;
    }

    #msgInput {
        width: 100%;
        height: 100px;
        resize: none;
        background-color: transparent;
        border: none; outline: none;
        overflow-y: auto;
    }

    #msgSend {
        background-color: rgb(208, 255, 113);
        border: 1px solid rgb(208, 255, 113);
        color: dimgray;
        cursor: pointer;
        border-radius: 3px;
        width: 55px; height: 35px;
        float: right;
    }

    #msgSend:hover {
        background-color: limegreen;
        border: 1px solid limegreen;
    }
    
    .dh_outline {
    	outline: none;
    }
    
    .hidden{
    	display: none;
    }
</style>

</head>
<body>

<c:if test="${selectRoom.employee2_no1 == empNo || selectRoom.employee2_no2 == empNo}">
<div id="erpChatroom-container">

    <div id="erpChatroomHead">
    	<c:if test="${selectRoom.chatroom_title == null }">
       		<h2><input type="text" name="chatroom_title" value="${selectRoom.employee2_position } ${employee1_name }" onkeypress="chattitle(event, ${selectRoom.chatroom_no}, this.value)" class="dh_outline"></h2>
    	</c:if>
    	<c:if test="${selectRoom.chatroom_title != null }">
	        <h2><input type="text" name="chatroom_title" value="${selectRoom.chatroom_title }" onkeypress="chattitle(event, ${selectRoom.chatroom_no}, this.value)" class="dh_outline"></h2>
    	</c:if>
    </div>
    
    <div>
    	<input type="button" value="▼" onclick="hiddenDel()">
    	<input type="button" value="▲" onclick="hiddenOn()">
    </div>
    <div id="inputWord" class="hidden">
  		<input type="text" name="word" id="word" placeholder="검색" autocomplete="off">
  		<input type="button" value="조회" onclick="searchMsg()">
  		<input type="text" id="searchNumber">
    </div>
    
    <div id="erpChatroomMemo">
	   	<c:choose>
	   		<c:when test="${selectRoom.chatroom_memo != null }">
	   			<input type="text" name="chatroom_memo" value="${selectRoom.chatroom_memo }" onkeypress="chatmemo(event,${selectRoom.chatroom_no},this.value)" class="dh_outline">
	   		</c:when>
	   		<c:otherwise>
	   			<input type="text" name="chatroom_memo" placeholder="메모를 적어주세요" autocomplete="off" onkeypress="chatmemo(event,${selectRoom.chatroom_no},this.value)" class="dh_outline">
	   		</c:otherwise>
	   	</c:choose>
    </div>
    <input type="hidden" id="chatroom_no" value="${selectRoom.chatroom_no }">
    <input type="hidden" id="employee2_no" value="${empNo }">
    
    <div id="erpChatroomMain">
        
        <table id="erpChatroomText">
            <c:if test="${chatlist != null }">
            <c:forEach var="map" items="${chatlist }" varStatus="status">
            	<c:if test="${map.chat_date != null}">
            		<tr><td colspan="5">${map.chat_date }</td></tr>
            	</c:if>
            	<tr>
            		<td>${map.team_name }</td>
            		<td>${map.employee1_name } : </td>
            		<td class="chat-text" tabindex="${status.index }">${map.chat_text } </td>
            		<td>${map.chat_time }</td>
            		<td onclick="deleteChat(${map.chat_no},${selectRoom.chatroom_no })">x</td>
            	</tr>
            </c:forEach>
        	</c:if>
        	<c:if test="${chatlist == null }">
        		<tr><td>대화를 시작해주세요.</td></tr>
        	</c:if>
        </table>
    
    </div>
    
    <div id="erpChatroomBottom">
    
        <div>
            <textarea id="msgInput" placeholder="전송할 메세지를 입력하세요"></textarea>
        </div>
        
        <div>
            이모티콘/달력/파일/캡쳐/채팅창투명도설정/... 
            <input type="button" id="msgSend" value="전송">
        </div>
    
    </div>
	

</div>


<script type="text/javascript">
var idx = 0;

	$(document).ready(function(){

        const username = `${chatNickName}`;

        $("#disconn").on("click", (e) => {
            disconnect();
        })
        
        $("#msgSend").on("click", (e) => {
            send();
        });

        const websocket = new WebSocket("ws://192.168.123.14:10000/ws/chat");

        websocket.onmessage = onMessage;
        websocket.onopen = onOpen;
        websocket.onclose = onClose;

        function send(){

            let msg = document.getElementById("msgInput");
            let cno = document.getElementById("chatroom_no").value;
            let eno = document.getElementById("employee2_no").value;
            console.log(eno);
			
            var url = '${pageContext.request.contextPath}/intranet/chat/createChatAjax';
            var param = 'chat_text='+msg.value+'&chatroom_no='+cno+'&employee2_no='+eno;
            
            
            console.log(username + ":" + msg.value);
            websocket.send(username + ":" + msg.value);
            sendRequest(url,param,checksend,"POST");
        }
        
        function checksend(){
        	idx = 0;
        	let msg = document.getElementById("msgInput");
        	if(xhr.readyState==4 && xhr.status==200) {
        		var data = xhr.response;
        		
        		let bf = document.getElementById("erpChatroomText");
        		let newTr = document.createElement("tr");
    		    let newTd = document.createElement("td");
        		bf.innerHTML = '';
        		if(data != ""){
        			var data2 = JSON.parse(data);
        			data2.forEach(function(map){
        				if(map.chat_date != null){
    	    				newTr = document.createElement("tr");
    	    				newTr.setAttribute("colspan", "5");
        					bf.appendChild(newTr);
    	    				newTd = document.createElement("td");
    	    				newTd.innerHTML = map.chat_date;
    	    				newTr.appendChild(newTd);
        				}
        				newTr = document.createElement("tr");
        				bf.appendChild(newTr);
        				newTd = document.createElement("td");
        				newTd.innerHTML = map.team_name;
        				newTr.appendChild(newTd);
        				newTd = document.createElement("td");
        				newTd.innerHTML = map.employee1_name+' : ';
        				newTr.appendChild(newTd);
        				newTd = document.createElement("td");
        				newTd.setAttribute("class","chat-text");
        				newTd.setAttribute("tabindex",idx);
        				newTd.innerHTML = map.chat_text;
        				newTr.appendChild(newTd);
        				newTd = document.createElement("td");
        				newTd.innerHTML = map.chat_time;
        				newTr.appendChild(newTd);
        				newTd = document.createElement("td");
        				newTd.setAttribute("onclick", "deleteChat("+map.chat_no+","+map.chatroom_no+")")
        				newTd.innerHTML = 'x';
        				newTr.appendChild(newTd);
        				idx = Number(idx) + 1;
        			});
        		}else {
        			bf.innerHTML = '<tr><td>대화를 시작해주세요.</td></tr>';
        		}
        	}
            msg.value = '';
        }
            
            //채팅창에서 나갔을 때
        function onClose(evt) {
            var str = username + ": 님이 방을 나가셨습니다.";
            websocket.send(str);
        }
            
            //채팅창에 들어왔을 때
        function onOpen(evt) {
            var str = username + ": 님이 입장하셨습니다.";
            websocket.send(str);
        }

		function onMessage(msg) {
		    var data = msg.data;
		    var sessionId = null;
		    //데이터를 보낸 사람
		    var message = null;
		    var arr = data.split(":");
		
		    for(var i=0; i<arr.length; i++){
		        console.log('arr[' + i + ']: ' + arr[i]);
		    }
		    
		    var cur_session = username;
		    
		    this.value
		
		
		    //현재 세션에 로그인 한 사람
		    console.log("cur_session : " + cur_session);
		    sessionId = arr[0];
		    message = arr[1];
		    
		    let tb = document.getElementById("erpChatroomText");
		    let newTr = document.createElement("tr");
		    let newTd = document.createElement("td");
		    
		    tb.appendChild(newTr);
		    newTd.innerHTML = sessionId;
		    newTr.appendChild(newTd);
		    newTd = document.createElement("td");
		    newTd.innerHTML = message;
		    newTr.appendChild(newTd);
		
		    console.log("sessionID : " + sessionId);
		    console.log("cur_session : " + cur_session);
		
		    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		    if(sessionId == cur_session){
		        var str = "<div class='col-6'>";
		        str += "<div class='alert alert-secondary'>";
		        str += "<b>" + sessionId + " : " + message + "</b>";
		        str += "</div></div>";
		        $("#msgArea").append(str);
		    }
		    else{
		        var str = "<div class='col-6'>";
		        str += "<div class='alert alert-warning'>";
		        str += "<b>" + sessionId + " : " + message + "</b>";
		        str += "</div></div>";
		        $("#msgArea").append(str);
		    }
		}
	});
	
	function chattitle(e,no,t){
		if(e.keyCode == 13){
			console.log("실행");
			var url = '${pageContext.request.contextPath}/intranet/chat/updateChatTitle';
	        var param = 'chatroom_title='+t+'&chatroom_no='+no;
	        
	        sendRequest(url,param,checktitle,"POST");
		}
	}
	function checktitle(){
		if(xhr.readyState==4 && xhr.status==200) {
    		var data = xhr.responseText;
			console.log(data);
    		var head = document.getElementById("erpChatroomHead");
    		head.innerHTML = '<h2><input type="text" name="chatroom_title" value="'+data+'" onkeypress="chattitle(event,${selectRoom.chatroom_no},this.value)"></h2>';
		}
	}
	
	
	function chatmemo(e,no,m){
		if(e.keyCode == 13){
			console.log("실행");
			var url = '${pageContext.request.contextPath}/intranet/chat/updateChatMemo';
	        var param = 'chatroom_memo='+m+'&chatroom_no='+no;
			
	        sendRequest(url,param,checkmemo,"POST");
		}
	}
	function checkmemo(){
		if(xhr.readyState==4 && xhr.status==200) {
    		var data = xhr.responseText;
			console.log(data);
    		var memo = document.getElementById("erpChatroomMemo");
    		memo.innerHTML = '<input type="text" name="chatroom_memo" value="'+data+'" onkeypress="chatmemo(event,${selectRoom.chatroom_no},this.value)">'
		}
	}
	
	function deleteChat(no, cno){
		var ch = confirm("대화내용을 삭제하시겠습니까?");
		if(ch){
			var url = '${pageContext.request.contextPath}/intranet/chat/deleteChatAjax';
	        var param = 'chat_no='+no+'&chatroom_no='+cno;
			
	        sendRequest(url,param,deleteChatCheck,"POST");
		}else {
			return;
		}
	}
	function deleteChatCheck(){
		idx = 0;
		if(xhr.readyState==4 && xhr.status==200) {
    		var data = xhr.response;
    		let tb = document.getElementById("erpChatroomText");
    		let newTr = document.createElement("tr");
    		let newTd = document.createElement("td");
    		if(data != ""){
    			tb.innerHTML = '';
    			var data2 = JSON.parse(data);
    			data2.forEach(function(map){
    				if(map.chat_date != null){
	    				newTr = document.createElement("tr");
	    				newTr.setAttribute("colspan", "5");
    					tb.appendChild(newTr);
	    				newTd = document.createElement("td");
	    				newTd.innerHTML = map.chat_date;
	    				newTr.appendChild(newTd);
    				}
    				newTr = document.createElement("tr");
    				tb.appendChild(newTr);
    				newTd = document.createElement("td");
    				newTd.innerHTML = map.team_name;
    				newTr.appendChild(newTd);
    				newTd = document.createElement("td");
    				newTd.innerHTML = map.employee1_name;
    				newTr.appendChild(newTd);
    				newTd = document.createElement("td");
    				newTd.setAttribute("class","chat-text");
    				newTd.setAttribute("tabindex",idx);
    				newTd.innerHTML = map.chat_text;
    				newTr.appendChild(newTd);
    				newTd = document.createElement("td");
    				newTd.innerHTML = map.chat_time
    				newTr.appendChild(newTd);
    				newTd = document.createElement("td");
    				newTd.setAttribute("onclick", "deleteChat("+map.chat_no+","+map.chatroom_no+")")
    				newTd.innerHTML = 'x';
    				newTr.appendChild(newTd);
    				idx = Number(idx) + 1;
    			});
			}else {
				tb.innerHTML = '';
				tb.innerHTML = '<tr><td>대화를 시작해주세요.</td></tr>';
			}
		}
	}
	
	function searchMsg(no){
		var url = '${pageContext.request.contextPath}/intranet/chat/searchMsgCheck';
        var param = 'chatroom_no='+no;
		
        sendRequest(url,param,searchMsgCheck,"POST");
	}
	function searchMsgCheck(){
		if(xhr.readyState==4 && xhr.status==200) {
    		var data = xhr.response;
    		var sm = document.getElementById("searchNumber");
    		
    		if(data != ""){
    			var data2 = JSON.parse(data);
    			var leng = data2.length;
    			console.log(leng);
    		}
		}
	}
	
	function searchMsg(){
		let all = document.getElementById("erpChatroom-container").children;
		let inp = document.getElementsByTagName("input");
		
		for(var j = 0; j < all.length; j++){
			console.log(all[j]);
			all[j].setAttribute("tabindex", "-1");
		}
		for(var o = 0; o < inp.length; o++){
			inp[o].setAttribute("tabindex", "-1");
		}
		
		let word = document.getElementById("word").value;
		let textarr = document.getElementsByClassName("chat-text");
		
		for(var h = 0; h < textarr.length; h++){
			if(textarr[h].innerHTML.indexOf(word) != -1){
				textarr[h].setAttribute("tabindex", h);
				textarr[h].focus();
				textarr[h].style.backgroundColor = "yellow";
			}else {
				textarr[h].setAttribute("tabindex", "-1");
			}
		}	
	}
	
	function hiddenDel(){
		document.getElementById("inputWord").removeAttribute("class");
	}
	function hiddenOn(){
	let all = document.getElementById("erpChatroom-container").children;
	let inp = document.getElementsByTagName("input");
		
	for(var j = 0; j < all.length; j++){
		all[j].removeAttribute("tabindex");
	}
	
	for(var o = 0; o < inp.length; o++){
		inp[o].removeAttribute("tabindex");
	}
	
	let textarr = document.getElementsByClassName("chat-text");
		
		for(var h = 0; h < textarr.length; h++){
			textarr[h].style.backgroundColor = "";
		}
		document.getElementById("inputWord").setAttribute("class", "hidden");
	}
	
</script>
</c:if>
</body>
</html>