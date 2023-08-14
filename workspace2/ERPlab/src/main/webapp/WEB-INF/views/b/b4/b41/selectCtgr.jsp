<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

	function check(f) {
		if(f.word.value == ""){
			alert("검색어를 입력하십시오!");
			return false;
		}
		
		return true;
	}
	
</script>    

<%@include file="/WEB-INF/views/layout/header.jsp" %>
<div align="center">
	<c:choose>
		<c:when test="${list == null }">
			목록이 없습니다.
		</c:when>
		<c:otherwise>
			<table>
				<tr>
					<td>코드</td>
					<td>카테고리</td>
					<td>적요</td>
					<td>차변</td>
					<td>대변</td>
					<td>비고</td>
					<td>날짜</td>
				</tr>
			<c:forEach var="map" items="${list }">
				<tr>
					<td>${map.ctgr_ctgr }</td>
					<td>${map.ctgr_name }</td>
					<td>${map.closing_content }</td>
					<td>${map.closing_debtor }</td>
					<td>${map.closing_creditor }</td>
					<td>${map.closing_note }</td>
					<td>${map.closing_date }</td>
					<c:if test="${ login == 1 }">
						<td><input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath}/b/b4/b41/delete?ctgr_no=${ctgr_no }&comcode_code=${comcode_code }'"></td>
					</c:if>
				</tr>
			</c:forEach>
				<tr>
					<td></td>
					<td colspan="2">합계</td>
					<td>${vo.closing_debtor }</td>
					<td>${vo.closing_creditor }</td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
	
	<form action="${pageContext.request.contextPath }/b/b4/b41/selectCtgr" method="get" onsubmit="return check(this)" >
			<span style="float: left;">
				<select name="type">
					<option value="closing_content" ${param.type == 'closing_content' ? 'selected' : '' }>적요</option>
					<option value="closing_note" ${param.type == 'closing_note' ? 'selected' : '' }>비고</option>
					<option value="closing_month" ${param.type == 'closing_month' ? 'selected' : '' }>월</option>
					<option value="closing_day" ${param.type == 'closing_day' ? 'selected' : '' }>일</option>
				</select>
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="hidden" name="ctgr_no" value="${ctgr_no }">
				<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
				<input type="submit" value="조회">
				<input type="button" value="전체목록" onclick="location.href='${pageContext.request.contextPath }/b/b4/b41/selectCtgr?ctgr_no=${ctgr_no }&comcode_code=${comcode_code}&type=null'">
			</span>
	</form>	
	
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>