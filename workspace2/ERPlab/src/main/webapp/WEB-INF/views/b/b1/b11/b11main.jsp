<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="bs-container">

	<form action="${pageContext.request.contextPath}/b/b1/b11/b11main" method="get">
    	<input type="hidden" name="comcode_code" value="${comcode_code}">
    </form>
	
	<div class="b11-head">
	
		<h1>재무상태표</h1>  
		
		<div>
			<input type="button" id="b11clear" value="기초데이터">
		</div>
		    
		<table>
			<tr>
				<th colspan="4">계정과목</th>
				<th>금액</th>
			</tr>
			
        <c:if test="${list != null}">  
            <c:forEach var="map" items="${bs2map}">
            <tr>
                <td name="b31bs" colspan="3"></td>
                <td name="b31bs">${bs2map.bs3_ctgr}</td>
                <td name="b31bs"></td>
            </tr>
            </c:forEach>            
		</c:if>
		
        <c:if test="${list != null}">  
            <c:forEach var="list" items="${list}">
            <tr>
                <td name="b31bs">${list.bs3_class}</td>
                <td name="b31bs" colspan="3"></td>
                <td name="b31bs">대분류합계</td>
            </tr>
            <tr>
                <td name="b31bs"></td>
                <td name="b31bs">${list.bs1_ctgr}</td>
                <td name="b31bs" colspan="2"></td>
                <td name="b31bs">${list.bs1_amount}</td>
            </tr>
            <tr>
                <td name="b31bs" colspan="2"></td>
                <td name="b31bs">${list.bs2_ctgr}</td>
                <td name="b31bs"></td>
                <td name="b31bs">{list.bs2_amount}</td>
            </tr>
            <tr>
                <td name="b31bs" colspan="3"></td>
                <td name="b31bs">${list.bs3_ctgr}</td>
                <td name="b31bs">${list.bs3_amount}</td>
            </tr>
            </c:forEach>            
		</c:if>
    	<c:if test="${list == null }">
    		<tr>
    			<td>내용이 없습니다.</td>
    		</tr>
    	</c:if>
	    	
		</table>
		
		
		
		
	</div>
	
</div>

<script>


    
</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    