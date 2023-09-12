<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>
    <style>
        body, html {
            width: 100%; height: 100%;
            padding: 0%; margin: 0%;
            align-items: center;
            min-width: 300px;
            min-height: 800px;
        }   
    
        #erpChatList-selectOption {
            height: 100%;
            float: left; width: 70px;
            background-color: yellow;
            display: flex;
            flex-direction: column;
        }
        #erpChatList-selected {
            height: 100%;
            flex: 1;
            background-color: lightblue;
            display: flex;
            flex-direction: column;
        }


    </style>
</head>
<body>

    <div id="erpChatList-selectOption">
    기능
    목록
    <br>
        <p>1친구</p>
        <p>2채팅방</p>
        <p>3더보기</p>
    </div>

    <div id="erpChatList-selected">
    내용
    <br>

        <div id="erpChat-friendList">
            친구목록
            <a href="#" onclick="openChatroom();">친구와의채팅1</a><br>
        </div>

        <div id="erpChat-chatList">
            채팅방 목록
            <a href="#" onclick="openChatroom();">채팅방1</a>
        </div>
    </div>

<script>
    function openChatroom() {
        window.open('${pageContext.request.contextPath}/erpchatroom?comcode_code=${comcode_code}', 'Chatroom', 'width=380, height=480');
    }

</script>

</body>
</html>