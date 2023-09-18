<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
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
</style>

</head>
<body>

<div id="erpChatroom-container">

    <div id="erpChatroomHead">
    
        <h2>채팅방 명</h2>
        참여인원 / 채팅방 검색 / 대화상대 초대 / ... 

    </div>
    
    <div id="erpChatroomMain">
        
        <table id="erpChatroomText">
            
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
	$(document).ready(function(){

        const username = `${chatNickName}`;

        $("#disconn").on("click", (e) => {
            disconnect();
        })
        
        $("#msgSend").on("click", (e) => {
            send();
        });

        const websocket = new WebSocket("ws://localhost:10000/ws/chat");

        websocket.onmessage = onMessage;
        websocket.onopen = onOpen;
        websocket.onclose = onClose;

        function send(){

            let msg = document.getElementById("msgInput");

            console.log(username + ":" + msg.value);
            websocket.send(username + ":" + msg.value);
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
	})
</script>


<script type="text/javascript">



</script>

</body>
</html>