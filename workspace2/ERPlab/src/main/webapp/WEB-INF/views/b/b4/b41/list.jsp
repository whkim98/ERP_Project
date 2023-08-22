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
					<td>차변</td>
					<td>대변</td>
				</tr>
			<c:forEach var="map" items="${list }">
				<tr onclick="location.href='${pageContext.request.contextPath}/b/b4/b41/selectCtgr?ctgr_no=${map.ctgr_no }&comcode_code=${comcode_code }'">
					<td>${map.ctgr_ctgr }</td>
					<td>${map.ctgr_name }</td>
					<td>${map.closing_debtor }</td>
					<td>${map.closing_creditor }</td>
					<c:if test="${ login == 1 }">
						<td><input type="button" value="삭제" onclick="location.href='${pageContext.request.contextPath}/b/b4/b41/delete?ctgr_no=${map.ctgr_no }&comcode_code=${comcode_code }'"></td>
					</c:if>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="2">합계</td>
					<td>${vo.closing_debtor }</td>
					<td>${vo.closing_creditor }</td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
	
	<form action="${pageContext.request.contextPath }/b/b4/b41" method="get" onsubmit="return check(this)" >
			<span style="float: left;">
				<select name="type">
					<option value="ctgr_name" ${param.type == 'ctgr_name' ? 'selected' : '' }>카테고리</option>
					<option value="ctgr_ctgr" ${param.type == 'ctgr_ctgr' ? 'selected' : '' }>코드</option>
				</select>
				<input type="hidden" name="comcode_code" value="${comcode_code}">
				<input type="text" name="word" placeholder="검색어를 입력하세요" value="${param.word }" autocomplete="off">
				<input type="submit" value="조회">
			</span>
	</form>	
	
</div>
<%@include file="/WEB-INF/views/layout/footer.jsp" %>