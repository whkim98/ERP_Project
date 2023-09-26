<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
</head>
<body>
	<div id="erpChat-friendList">
        친구목록<br>
        <c:forEach var="map" items="${list }">
         ${map.employee2_position } ${map.employee1_name }<input type="button" value="초대하기" onclick="inviteUser(${chatroom_no},${map.employee2_no },'${map.employee1_name }','${comcode_code }')"><br>
        </c:forEach>
    </div>
</body>
<script type="text/javascript">
function inviteUser(cno, no2, name, code) {
    location.href='${pageContext.request.contextPath}/intranet/chat/updateInvite?comcode_code='+code+'&employee1_name='+name+'&chatroom_no='+cno+'&employee2_no2='+no2;
    window.close();
}
</script>
</html>