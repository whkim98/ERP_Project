<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="statement-container">
	
	<form action="${pageContext.request.contextPath }/b/b3/b31/b31main" method="get">
    	<input type="hidden" name="comcode_code" value="${comcode_code}">
    </form>
	
    <div class="b31-head">

  	   <h1>일반전표</h1>  
    
 	   <table class="b31-title">
            <tr>
                <th>일자별</th>
                <td>
                    <select id="b31yearSelect"></select>년
                    <select id="b31monthSelect"></select>월
                    <select id="b31daySelect"></select>일
                    <input type="button" id="b31-dateSearch" value="검색" />
                </td>
                <td></td>
                <th>기간별</th>
                <td>
                    <select id="yearPeriod"></select>년
                    <select id="monthPeriod1"></select>월 ~ 
                    <select id="monthPeriod2"></select>월
                    <input type="button" id="b31-monthPeriodSearch" value="검색" />
                    </td>
                <th>항목으로 검색</th>
                <td><input type="text" id="searchInput" value="검색할 항목을 입력하세요" /><button>검색</button></td>
            </tr>
        </table>
    
    </div>
	
	<div class="b31-body">
		
        <table class="b31-clauses" id="b31-itemTable">
            <tr>
                <th>년</th>
                <th>월</th>
                <th>일</th>
                <th>부서</th>
                <th>고유코드</th>
                <th>구분</th>
                <th>차변 계정과목</th>
                <th>차변 금액</th>
                <th>대변 계정과목</th>
                <th>대변 금액</th>
                <th>적요</th>
                <th>거래처</th>
                <th>삭제</th>
            </tr>
            
        <c:if test="${list != null}">       
        	<c:forEach var="map" items="${list}">
            <input type="hidden" name="statement_no" id="statement_no" value="${map.statement_no}" />
            <tr>
                <td name="b31statementYY">${map.closing_yy}</td>
                <td name="b31statementMM">${map.closing_mm}</td>
                <td name="b31statementDD">${map.closing_dd}</td>
                <td name="b31statementTeam">${map.team_name}</td>
                <td name="b31statementCode">${map.statement_code}</td>
                <td name="b31statementType">${map.statement_type}</td>
                <td name="b31statementDebtorType">${map.bs3_no1}</td>
                <td name="b31statementDebtorAmount" id="b31debitAmount">${map.statement_debtor}</td>
                <td name="b31statementCreditorType">${map.bs3_no2}</td>
                <td name="b31statementCreditorAmount" id="b31creditAmount">${map.statement_creditor}</td>
                <td name="b31statementAbstract">${map.statement_abstract}</td>
                <td name="b31statementClient">${map.client_name}</td>
                <td name="b31statementDelete"><input type="button" id="b31-deleteStatement" value="삭제" /></td>
            </tr>
            </c:forEach>
		</c:if>
    	<c:if test="${list == null }">
    		<tr>
    			<td>내용이 없습니다.</td>
    		</tr>
    	</c:if>
    	
            <tr>
                <th colspan="5">선택 전표 소계</th>
                <td></td>
                <td id="b31debitAmountTotal"></td>
                <td></td>
                <td id="b31creditAmountTotal"></td>
                <td colspan="3"></td>
            </tr>
        
        </table>

	
	</div>
	

</div>

<script type="text/javascript">

    
</script>
    

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    
    
    