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
            친구목록<br>
            <c:forEach var="map" items="${list }">
	            ${map.employee2_position } ${map.employee1_name }<input type="button" value="대화하기" onclick="openChatroom(${empNo},${map.employee2_no },'${map.employee1_name }','${comcode_code }')"><br>
            </c:forEach>
        </div>

        <div id="erpChat-chatList">
            채팅방 목록
            <a href="#" onclick="chatRoomList(${empNo},'${comcode_code }')">채팅방1</a>
        </div>
    </div>

<script>
    function openChatroom(no1, no2, name, code) {
        window.open('${pageContext.request.contextPath}/intranet/chat/createChatRoom?comcode_code='+code+'&employee1_name='+name+'&employee2_no1='+no1+'&employee2_no2='+no2, 'Chatroom', 'width=380, height=480');
    }
    
    function chatRoomList(no, code){
    	location.href="${pageContext.request.contextPath}/intranet/chat/erpchatlist?employee2_no="+no+"&comcode_code="+code;
    }

</script>

</body>
</html>