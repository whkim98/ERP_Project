<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
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
        
        .chat-roomstyle{
        	width: 200px;
        	height: 50px;
        	border: 1px solid blue;
        	border-radius: 30px;
        	text-align: center;
        	text-decoration: none; 
        }


    </style>
</head>
<body>

    <div id="erpChatList-selectOption">
    기능
    목록
    <br>
        <p onclick="location.href='${pageContext.request.contextPath}/intranet/chat/erpchat?comcode_code=${comcode_code}&employee2_no=${empNo}'">직원 목록</p>
        <p onclick="location.href='${pageContext.request.contextPath}/intranet/chat/erpchatlist?employee2_no=${empNo }&comcode_code=${comcode_code }'">채팅방</p>
        <p>3더보기</p>
    </div>

    <div id="erpChatList-selected">
    내용
    <br>

        <div id="erpChat-friendList">
            친구목록
            
        </div>

        <div id="erpChat-chatList">
            채팅방 목록 <br>
            <c:forEach var="map" items="${list }">
            	<div class="chat-roomstyle">
	            	<c:if test="${empNo == map.e1no }">
			            <a href="#" onclick="openChatroom(${map.chatroom_no },'${map.e2name }','${comcode_code }')">
			            	<c:if test="${map.chatroom_title == null }">
			            		${map.e2position } ${map.e2name }
			            	</c:if>
			            	<c:if test="${map.chatroom_title != null }">
				            	${map.chatroom_title }
			            	</c:if>
			            </a><br>
	            	</c:if>
	            	<c:if test="${empNo == map.e2no }">
			            <a href="#" onclick="openChatroom(${map.chatroom_no },'${map.e1name }','${comcode_code }');">
			            	<c:if test="${map.chatroom_title == null }">
				            	${map.e1position } ${map.e1name }
			            	</c:if>
			            	<c:if test="${map.chatroom_title != null }">
				            	${map.chatroom_title }
			            	</c:if>
			            </a><br>
	            	</c:if>
            	</div>
            </c:forEach>
        </div>
    </div>

<script>
function openChatroom(no, name, code, po) {
    window.open('${pageContext.request.contextPath}/intranet/chat/erpchatroom?comcode_code='+code+'&employee1_name='+name+'&chatroom_no='+no, 'Chatroom', 'width=380, height=480');
}
</script>

</body>
</html>