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

<div class="erpChat-empList-container">
    <div class="erpChat-empList-head">
        <input type="button" onclick="" id="empList-empListBtn" value="직원목록">
        <input type="button" onclick="" id="empList-chatListBtn" value="채팅목록">
    </div>

    <div class="erpChat-empList-title">
        <input type="text" placeholder="직원검색" />
        <a onclick="searchEmp()"><i class="input-icon uil-search"></i></a>
    </div>

    <div class="erpChat-empList-main">
        main part
        <!-- 부서별 출력 할 것인지??? 직원 리스트 -->
        <table>
            <tr>
                <th>${팀}</th>
                <th>${이름}</th>
                <th>${직급}</th>
                <th>    </th>
                <th><a onclick="chatStart()"><i class="input-icon uil-comments"></i></a>
            </tr>
        </table>
        main part end
    </div>
    
</div>

<script type="text/javascript">






</script>

</body>
</html>