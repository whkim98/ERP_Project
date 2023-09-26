<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

      <div align="center">
         <h1 style="font-size: 20pt;">근태등록</h1>
      </div>

<div align="center">
    <form action="${pageContext.request.contextPath }/greeting/attendance/insert" method="post" name="privacy">
        <input type="hidden" name="employee2_no" value="${employee2_no }">
        <input type="hidden" name="comcode_code" value="${comcode_code }">
        <table>
            <tr>
                <td>휴가종류</td>
                <td>
                    <select name="hdkind_no">
                        <option value="1">연차</option>
                        <option value="2">반차</option>
                        <option value="3">조퇴</option>
                        <option value="4">지각</option>
                        <option value="5">결근</option>
                        <option value="6">경조휴가</option>
                        <option value="7">병가</option>
                        <option value="8">예비군</option>
                        <option value="9">민방위</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>휴가시작일</td>
                <td>
                    <input type="date" name="attendance_start" id="attendance_start" onchange="validateDates()">
                </td>
            </tr>
            <tr>
                <td>휴가종료일</td>
                <td>
                    <input type="date" name="attendance_end" id="attendance_end" onchange="validateDates()">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="입력" onclick="checkSubmit(this.form)">
                </td>
            </tr>
        </table>
    </form>
    <table>
        <tr>
            <th>직원코드</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>내선번호</th>
            <th>잔여휴가</th>
            <th>근로형태</th>
            <th>휴가시작일</th>
            <th>휴가종료일</th>
            <th>휴가종류</th>
        </tr>
        <c:forEach var="vo" items="${list }">
            <tr>
                <td>${vo.employee1_code }</td>
                <td>${vo.employee1_name }</td>
                <td>${vo.employee1_phone }</td>
                <td>${vo.employee1_email }</td>
                <td>${vo.employee2_extension }</td>
                <td>${vo.employee2_holiday }</td>
                <td>${vo.employee2_worktype }</td>
                <td>${vo.attendance_start }</td>
                <td>${vo.attendance_end }</td>
                <td>${vo.hdkind_name }</td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>

function checkSubmit(f) {
    var attendance_start = document.getElementById("attendance_start").value;
    var attendance_end = document.getElementById("attendance_end").value;

    if (attendance_start == "") {
        alert("시작날짜를 입력해 주세요.");
        document.getElementById("attendance_start").focus();
        return false;
    } else if (attendance_end == "") {
        alert("종료날짜를 입력해 주세요.");
        document.getElementById("attendance_end").focus();
        return false;
    } else {
        // Confirm dialog for submission
        var ch = confirm("등록하시겠습니까?");
        if (ch) {
            // Call the date validation function
            if (!validateDates()) {
                return false; // 날짜가 유효하지 않으면 제출 중단
            }
            f.submit();
        } else {
            return false;
        }
    }

    return true; // 폼 제출 허용
}


function validateDates() {
	
    var startDate = new Date(document.getElementById("attendance_start").value);
    var endDate = new Date(document.getElementById("attendance_end").value);

    if (isNaN(startDate) || isNaN(endDate)) {
        // One or both dates are invalid, do nothing
        return;
    }

    if (endDate < startDate) {
        alert("올바른 날짜를 입력해 주세요. 휴가시작일보다 앞에 날짜를 선택할 수 없습니다.");
        document.getElementById("attendance_end").value = ""; // Clear the end date field
    }
}
</script>
