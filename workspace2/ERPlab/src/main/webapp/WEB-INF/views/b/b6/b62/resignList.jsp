<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>		
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<script>
function resignWindow(employee1_no, employee2_no, comcode_code){
	var resign = window.open('', 'resign', 'width=300, height=200');
	
	
	
	resign.document.write('<form id="myForm" action="${pageContext.request.contextPath}/greeting/resign/insert" method="post">');
	resign.document.write('<input type="hidden" name="employee2_no" id="employee2_no" value="' + employee2_no + '">');
	resign.document.write('<input type="hidden" name="employee1_no" id="employee1_no" value="' + employee1_no + '">');
	resign.document.write('<input type="hidden" name="comcode_code" value="' + comcode_code + '">');
	resign.document.write('<input type="text" name="resign_code" id="resign_code" maxlength="30" placeholder="퇴직코드를 입력해 주세요">');
	resign.document.write('<input type="date" name="resign_date" id="resign_date" placeholder="퇴직날짜를 입력해 주세요">');
	resign.document.write('<input type="submit" value="입력">');
	resign.document.write('</form>');
	
	resign.document.getElementById('myForm').onsubmit = function(event) {
	event.preventDefault();
	
	var resign_code = resign.document.getElementById('resign_code').value;
	var resign_date = resign.document.getElementById('resign_date').value;
	
	resign.close();
	
	window.location.href = '${pageContext.request.contextPath}/greeting/resign/insert?comcode_code=' + comcode_code + '&employee1_no=' + employee1_no + '&employee2_no=' + employee2_no + '&resign_code=' + resign_code + '&resign_date=' + resign_date
	
	}
}
</script>
      <div align="center">
         <h1 style="font-size: 20pt;">퇴직 관리</h1>
      </div>
<div align="center">
	<form action="${pageContext.request.contextPath }/greeting/resign/insertForm" method="post">
		<table>
			<tr>
				<th>이름</th>
				<th>사원코드</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>직급</th>
				<th>연차</th>
				<th>연봉</th>
				<th>퇴직여부</th>
				<th></th>
			</tr>
			<c:forEach var="vo" items="${list }">
			<tr>
				<td>${vo.employee1_name }</td>
				<td>${vo.employee1_code }</td>
				<td>${vo.employee1_phone }</td>
				<td>${vo.employee1_email }</td>
				<td>${vo.employee2_position }</td>
				<td>${vo.employee2_exp }</td>
				<td>${vo.employee2_salary }</td>
				<c:if test="${vo.emphistory_resign != null }">
				<td>Y</td>
				</c:if>
				<c:if test="${vo.emphistory_resign == null }">
				<td>N</td>
				<td><input type="button" value="퇴직등록" onclick="resignWindow('${vo.employee1_no}', '${vo.employee2_no }', '${comcode_code }')">
				</c:if>
			</tr>
			</c:forEach>
		</table>
	</form>
</div>